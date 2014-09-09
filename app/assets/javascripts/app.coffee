# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

app = angular.module('TodoApp', [])
app.controller 'TodoCtrl', ($scope, $http) ->
  console.log 'Controller Loaded'
  $http.get('/api/users/1')
    .success (data, status, headers, config) ->
      $scope.user = data
      console.log data
    .error (data, status, headers, config) ->
      console.log 'error'
      console.log data
  $http.get('/api/user_todos/1')
    .success (data, status, headers, config) ->
      $scope.todos = data
      console.log data
    .error (data, status, headers, config) ->
      console.log 'error'
      console.log data

