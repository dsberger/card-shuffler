cardShuffler.controller('ListsIndexCtrl',
    [ '$scope',
      'ListsAPI',
      function( $scope, ListsAPI ){

        $scope.lists = [];

        ListsAPI.index()
          .then( function( listsResponse ){
            $scope.lists.push.apply( $scope.lists, listsResponse );
          });


      }]);
