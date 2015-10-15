cardShuffler.factory( 'ListOrderAPI',
    [ 'Restangular',
      function( Restangular ){

        var update = function( list_id, destination ){
          return Restangular.one('list_order', list_id).patch( { destination: destination } );
        };

        return {
          update: update
        };

      }]);
