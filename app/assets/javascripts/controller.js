var controllers = angular.module('controllers', []);

controllers.controller('ArticleTreeCtrl', ['$scope', '$http', '$routeParams', 
    function($scope, $http, $routeParams) {
  // $scope.get_children = function(id) {
    // $http.get('/articles/' + id + '/children',
        // {headers: {'content-type': 'json'}}).success(function(data) {
      // alert(JSON.stringify(data));
    // });
  // };
  // $http.get('/articles/roots').success(function(data) {
    // $scope.articles = data.articles;
  // });
}]);
