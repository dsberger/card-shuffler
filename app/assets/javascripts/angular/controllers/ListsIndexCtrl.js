cardShuffler.controller('ListsIndexCtrl',
    [ '$scope',
      'ListsAPI',
      'ListOrderAPI',
      'CardOrderAPI',
      function( $scope, ListsAPI, ListOrderAPI, CardOrderAPI ){

        $scope.lists = [];

        $scope.onListDropComplete = function( moveToList, object ){
          if (object.type === "list") {
            rearrangeLists( moveToList, object );
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

        $scope.saveCardAndListIndex = function( cardIndex, listIndex ){

          if ($scope.originatingCard === undefined ){
            $scope.originatingCard = cardIndex;
          };

          if ($scope.originatingList === undefined ){
            $scope.originatingList = listIndex;
          };

        };

        function rearrangeLists( moveTo, list ) {
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
        
        function retrieveOriginatingList(){
          var list = $scope.originatingList;
          $scope.originatingList = undefined;
          return list;
        };

        function retrieveOriginatingCard(){
          var card = $scope.originatingCard;
          $scope.originatingCard = undefined;
          return card;
        };

        function rearrangeCards( newListIndex, newCardIndex ){
          var oldList = retrieveOriginatingList();
          var oldCard = retrieveOriginatingCard();
          var card = pullCardAt( oldList, oldCard );
          insertCardTo( newListIndex, newCardIndex, card );
        };

        function pullCardAt( listIndex, cardIndex ) {
          return $scope.lists[ listIndex ].cards.splice( cardIndex, 1 )[0];
        };

        function insertCardTo( listIndex, cardIndex, card) {
          $scope.lists[ listIndex ].cards.splice( cardIndex, 0, card );
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
