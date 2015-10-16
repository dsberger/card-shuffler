cardShuffler.controller('ListsIndexCtrl',
    [ '$scope',
      'ListsAPI',
      'ListOrderAPI',
      'CardOrderAPI',
      function( $scope, ListsAPI, ListOrderAPI, CardOrderAPI ){

        $scope.lists = [];

        $scope.onListDropComplete = function( moveToList, object ){
          if (object.type === "list") {
            rearrangeList( moveToList, object );
            ListOrderAPI.update( object.id, moveToList + 1 )
              .then( function(response){
                $scope.lists = response;
                $scope.lists.sort(function(a,b){
                  return parseInt(a.order_on_board) - parseInt(b.order_on_board)
                });
                $scope.lists.forEach( function( list ){
                  list.cards.sort(function(a,b){
                    return parseInt(a.order_on_list) - parseInt(b.order_on_list);
                  });
                });
              });
          };
        };

        $scope.onCardDropComplete = function( moveToList, moveToCard, object ){
          if ( object.type === "card" ) {
            CardOrderAPI.update( object.id, moveToList + 1, moveToCard + 1 )
              .then( function(response){
                $scope.lists = response;
                $scope.lists.sort(function(a,b){
                  return parseInt(a.order_on_board) - parseInt(b.order_on_board)
                });
                $scope.lists.forEach( function( list ){
                  list.cards.sort(function(a,b){
                    return parseInt(a.order_on_list) - parseInt(b.order_on_list);
                  });
                });
              });
          };
        };

        var rearrangeList = function( moveTo, list ){
          var moveFrom = $scope.lists.indexOf( list );
          var i = moveFrom;

          if ( moveFrom > moveTo ) {
            for ( i; i > moveTo; i-- ){
              $scope.lists[i] = $scope.lists[i-1];
            };
          } else {
            for ( i; i < moveTo; i++){
              $scope.lists[i] = $scope.lists[i+1];
            };
          }

          $scope.lists[i] = list;
        };

        ListsAPI.index()
          .then( function( listsResponse ){
            $scope.lists.push.apply( $scope.lists, listsResponse );
            $scope.lists.sort(function(a,b){
              return parseInt(a.order_on_board) - parseInt(b.order_on_board)
            });
            $scope.lists.forEach( function( list ){
              list.cards.sort(function(a,b){
                return parseInt(a.order_on_list) - parseInt(b.order_on_list);
              });
            });
          });

      }]);
