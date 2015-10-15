cardShuffler.controller('ListsIndexCtrl',
    [ '$scope',
      'ListsAPI',
      function( $scope, ListsAPI ){

        $scope.lists = [];

        $scope.onDropComplete = function( moveTo, list ){
          rearrangeList( moveTo, list );
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
