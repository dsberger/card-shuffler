var cardShuffler = angular.module(
    'cardShuffler',
    [ 'ui.router',
      'restangular' ]);

cardShuffler.config(
    ['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider){

      $urlRouterProvider.otherwise('/')

      $stateProvider
        .state('lists', {
          url: '/',
          templateUrl: 'templates/lists.html',
          controller: 'ListsIndexCtrl'
        });
    }]);

cardShuffler.config(
    ['RestangularProvider',
    function( RestangularProvider ) {
      RestangularProvider.setBaseUrl('api/v1');
      RestangularProvider.setRequestSuffix('.json');
    }]);


// Error handler
cardShuffler.run(function($rootScope){
  $rootScope.$on("$stateChangeError", console.log.bind(console));
})
