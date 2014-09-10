# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

app = angular.module('TodoApp', [])
app.controller 'TodoCtrl', ['$scope', '$http', ($scope, $http) ->
  console.log 'Controller Loaded'
  token = $('body').data('private-token')
  $scope.editing = false
  $http.get("/api/users/#{token}")
    .success (data, status, headers, config) ->
      $scope.user = data
      console.log $scope
    .error (data, status, headers, config) ->
      console.log 'error'
  
  $http.get("/api/user_todos/#{token}")
    .success (data, status, headers, config) ->
      $scope.todos = data
      console.log $scope
    .error (data, status, headers, config) ->
      console.log 'error'
  
  $scope.new_todo = () ->
    $http.post '/api/todo/new',
      token: token
      todo: $('#new-todo').val()
    .success (data, status, headers, config) ->
      console.log data
      if data.success == true
        $scope.todos = data.todos
        $('#new-todo').val('')
    .error (data, status, header, config) ->
      console.log 'error'
  
  $scope.check_todo = () ->
    $http.put '/api/todo/check',
      token: token,
      todo: this.todo
    .success (data, s, h, c) ->
      console.log data
      if data.success == true
        console.log $scope
    .error (data, s,h, c) ->
      console.log 'error'

  $scope.delete_todo = () ->
    $http.post 'api/todo/delete',
      id: this.todo.id,
      token: token
    .success (data, s, h, c) ->
      console.log data
      if data.success == true
        $scope.todos = data.todos
      else
        console.log 'error'
    .error (d, s, h, c) ->
      console.log d
      console.log 'Error'
  ]  

