cardShuffler.controller('ListsIndexCtrl',
    [ '$scope',
      'ListsAPI',
      'ListOrderAPI',
      'CardOrderAPI',
      function( $scope, ListsAPI, ListOrderAPI, CardOrderAPI ){

        $scope.lists = [];

        $scope.saveCardAndListIndex = function( cardIndex, listIndex ){
          saveCardIndex( cardIndex );
          $scope.saveListIndex( listIndex );
        };

        $scope.onListDropComplete = function( moveToList, object ){
          if (object.type === "list") {
            rearrangeLists( moveToList );
            ListOrderAPI.update( object.id, moveToList + 1 )
              .then( function(response){
                $scope.lists = response;
                sortListsAndCards();
              });
          };
        };

        $scope.onCardDropComplete = function( moveToList, moveToCard, object ){
          if ( object.type === "card" ) {
            rearrangeCards( moveToList, moveToCard );
            CardOrderAPI.update( object.id, moveToList + 1, moveToCard + 1 )
              .then( function(response){
                $scope.lists = response;
                sortListsAndCards();
              });
          };
        };

        $scope.saveListIndex = function( listIndex ) {
          if ($scope.savedListIndex === undefined ){
            $scope.savedListIndex = listIndex;
          };
        };

        function oldListIndex(){
          var index = $scope.savedListIndex;
          $scope.savedListIndex = undefined;
          return index;
        };

        function saveCardIndex( cardIndex ) {
          if ($scope.savedCardIndex === undefined ){
            $scope.savedCardIndex = cardIndex;
          };
        };

        function oldCardIndex(){
          var index = $scope.savedCardIndex;
          $scope.savedCardIndex = undefined;
          return index;
        };

        function rearrangeLists( newListIndex ) {
          var list = $scope.lists.splice( oldListIndex(), 1 )[0];
          $scope.lists.splice( newListIndex, 0, list );
        };
        
        function rearrangeCards( newListIndex, newCardIndex ){
          var card = $scope.lists[ oldListIndex() ].cards.splice( oldCardIndex(), 1 )[0];
          $scope.lists[ newListIndex ].cards.splice( newCardIndex, 0, card );
        };

        function sortListsAndCards() {
          $scope.lists.sort(function(a,b){
            return parseInt(a.order_on_board) - parseInt(b.order_on_board)
          });
          $scope.lists.forEach( function( list ){
            list.cards.sort(function(a,b){
              return parseInt(a.order_on_list) - parseInt(b.order_on_list);
            });
          });
        };

        ListsAPI.index()
          .then( function( listsResponse ){
            $scope.lists.push.apply( $scope.lists, listsResponse );
            sortListsAndCards();
          });

      }]);
