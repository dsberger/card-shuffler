cardShuffler.controller('ListsIndexCtrl',
    [ '$scope',
      'ListsAPI',
      function( $scope, ListsAPI ){

        $scope.lists = [];

        var createFrontEndPosition = function( lists ){
          lists.forEach( function(list) {
            if( !list.frontEndPosition ){
              list.frontEndPosition = list.order_on_board;
            }
          });
        };

        ListsAPI.index()
          .then( function( listsResponse ){
            $scope.lists.push.apply( $scope.lists, listsResponse );
            $scope.lists.sort(function(a,b){
              return parseInt(a.order_on_board) - parseInt(b.order_on_board)
            });
            createFrontEndPosition( $scope.lists )
          });

      }]);
