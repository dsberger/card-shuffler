cardShuffler.controller('ListsIndexCtrl',
    [ '$scope',
      'ListsAPI',
      'ListOrderAPI',
      function( $scope, ListsAPI, ListOrderAPI ){

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
              });
          };
        };

        $scope.onCardDropComplete = function( moveToList, moveToCard, object ){
          if ( object.type === "card" ) {
            console.log( "Moving to list " + moveToList + " and card " + moveToCard );
            console.log( object );
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
          });

      }]);
