# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

app = angular.module('TodoApp', [])
app.controller 'TodoCtrl', ($scope, $http) ->
  console.log 'Controller Loaded'
  token = $('body').data('private-token')
  $http.get("/api/users/#{token}")
    .success (data, status, headers, config) ->
      $scope.user = data
      console.log $scope
    .error (data, status, headers, config) ->
      console.log 'error'
      #document.write data
  $http.get("/api/user_todos/#{token}")
    .success (data, status, headers, config) ->
      $scope.todos = data
      console.log $scope
    .error (data, status, headers, config) ->
      console.log 'error'
      #document.write data
  $scope.new_todo = () ->
    $http.post '/api/todo/new',
      token: token
      todo: $('#new-todo').val()
    .success (data, status, headers, config) ->
      console.log data
      if data.success == true
        $scope.todos = data.todos
    .error (data, status, header, config) ->
      console.log 'error'
  $scope.check_todo = () ->
    console.log this.todo.is_complete
#    $http.put '/api/todo/check',
#      token: token,
#      todo: todo
          

