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
            rearrangeCards( moveToList, moveToCard, object );
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
          $scope.lists[moveFrom] = null;

          if ( moveFrom > moveTo ) {
            iterateDownLists( moveFrom, moveTo );
          } else {
            iterateUpLists( moveFrom, moveTo );
          }

          $scope.lists[moveFrom] = list;
        };

        function iterateDownLists( moveFrom, moveTo ) {
          var i = moveFrom;
          for ( i; i > moveTo; i-- ){
            var movingList = $scope.lists[i-1];
            $scope.lists[i-1] = null;
            $scope.lists[i] = movingList;
          };
        };

        function iterateUpLists( moveFrom, moveTo ) {
          var i = moveFrom;
          for ( i; i < moveTo; i++){
            var movingList = $scope.lists[i+1];
            $scope.lists[i+1] = null;
            $scope.lists[i] = movingList;
          };
        };

        function rearrangeCards( moveToList, moveToCard, card ){
          console.log( "target list: " + moveToList );
          console.log( "target card: " + moveToCard );
          console.log( card );
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
