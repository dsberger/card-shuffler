cardShuffler.factory( 'CardOrderAPI',
    [ 'Restangular',
      function( Restangular ){

        var update = function( card_id, listDestination, cardDestination ){
          var params = { list_destination: listDestination, card_destination: cardDestination }
          return Restangular.one('card_order', card_id).patch( params )
        };

        return {
          update: update
        };
      }]);
