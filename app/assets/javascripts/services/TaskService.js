app.service('taskService', function ($rootScope, $http) {

    var urlBase = '/tasks';
    var taskService = {};

    taskService.getTasks = function () {
        return $http.get(urlBase);
    };

    taskService.getTask = function (id) {
        return $http.get(urlBase + '/' + id);
    };

    taskService.createTask = function (task) {
        return $http.post(urlBase, task);
    };

    taskService.updateTask = function (id, attrs) {
        return $http.put(urlBase + '/' + id, attrs)
    };

    taskService.deleteTask = function (id) {
        return $http.delete(urlBase + '/' + id);
    };

    return taskService;
});