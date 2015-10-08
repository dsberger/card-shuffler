cardShuffler.controller('ListsIndexCtrl',
    [ '$scope',
      'ListsAPI',
      function( $scope, ListsAPI ){

        $scope.lists = [];

        ListsAPI.index()
          .then( function( listsResponse ){
            lists.push.apply( lists, listsResponse );
          });


      }]);
