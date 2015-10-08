cardShuffler.factory('ListsAPI',
    [ 'Restangular',
      function( Restangular ){

        var index = function(){
          return Restangular.all('lists').getList();
        }

        return {
          index: index
        }
      }]);
