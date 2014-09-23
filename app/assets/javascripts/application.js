// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require articles
//= require angular/angular
//= require angular/angular-route
//= require controller
var lawApp = angular.module('lawApp', ['ngRoute', 'controllers']);
lawApp.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
    when('/trees/:id', {
      templateUrl: '/views/tree.html',
      controller: 'ArticleTreeCtrl'
    }).
    otherwise({
      redirectTo: '/tree'
    });
}]);
lawApp.directive('articleTree', ['$compile', '$http', function($compile, $http) {
  return {
    restrict: 'E',
    scope: {
      pid: '=pid'
    },
    controller: function($scope, $attrs, $http) {
      $http.get('/articles/' + $scope.pid + '/children',
          {headers: {'content-type': 'json'}}).success(function(data) {
        $scope.children = data.children;
        angular.forEach($scope.children, function(child) {
          if (child.has_children) {
            $scope['has_children_' + child.id] = true;
            $scope['isOpen_' + child.id] = false;
          } else {
            $scope['has_children_' + child.id] = false;
          }
        });
      });
    },
    link: function(scope, element, attrs, ctrl) {
      scope.show_children = function(id) {
        scope['isOpen_' + id] = true;
        if (element.find('article-tree[pid="' + id + '"]').length == 0) {
          var newElement = '<article-tree pid="' + id + '"></article-tree>';
          newElement = $compile(newElement)(scope);
          $("#subtree_" + id).append(newElement);
        }
      };
      scope.hide_children = function(id) {
        scope['isOpen_' + id] = false;
      };
    },
    templateUrl: '/views/tree.html'
    //template: '<ul aid="{{pid}}" class="tree"><li ng-repeat="article in children" id="article_{{article.id}}"><span class="to_edit">{{article.content}}</span><a href="#" ng-click="show_children(article.id)">Open</a></li></ul>'
  };
}]);
