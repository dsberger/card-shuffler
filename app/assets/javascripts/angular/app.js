var cardShuffler = angular.module(
    'cardShuffler',
    [ 'ui.router' ]);

cardShuffler.config(
    ['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider){

      $urlRouterProvider.otherwise('/')

      $stateProvider
        .state('board', {
          url: '/',
          templateUrl: 'templates/board.html'
        });
    }]);
