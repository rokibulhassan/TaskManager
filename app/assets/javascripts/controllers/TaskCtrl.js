app.controller('TaskCtrl', function ($scope, $http, $location, taskService, Notification) {

    getTasks();
    mangeDom(false, false);

    function clearTaskForm() {
        $scope.task.title = null;
        $scope.task.description = null;
    }

    function mangeDom(showEdit, showForm) {
        $scope.showEdit = showEdit;
        $scope.showForm = showForm;
    }

    function getTasks() {
        taskService.getTasks()
            .then(function (response) {
                $scope.myTasks = response.data;
            }, function (error) {
                Notification.error('Unable to load data: ' + error.statusText);
            });
    };

    $scope.createTask = function () {
        var task = $scope.task;
        taskService.createTask(task)
            .then(function (response) {
                Notification.success('Task has been created successfully.');
                $scope.myTasks.push(response.data);
                clearTaskForm();
            }, function (error) {
                Notification.error('Unable to create task: ' + error.statusText);
            });
    };


    $scope.addTask = function () {
        mangeDom(false, true);
    };

    $scope.editTask = function (task, index) {
        $scope.index = index;
        mangeDom(true, true);
        $scope.task = angular.copy(task);
    };

    $scope.updateTask = function () {
        var task = $scope.task;
        taskService.updateTask(task.id, {task: {title: task.title, description: task.description}})
            .then(function (response) {
                Notification.success('Task has been updated successfully.');
                for (i in $scope.myTasks) {
                    if ($scope.myTasks[i].id == task.id) {
                        $scope.myTasks[i] = task;
                    }
                }
            }, function (error) {
                Notification.error('Unable to update task: ' + error.statusText);
            });
    };

    $scope.toggleTask = function (task) {
        taskService.updateTask(task.id, {task: {completed: task.completed}})
            .then(function (response) {
                Notification.success('Task has been updated successfully.');
            }, function (error) {
                Notification.error('Unable to update task: ' + error.statusText);
            });
    };

    $scope.deleteTask = function (task, index) {
        confirmed = confirm('Confirm delete?');
        if (confirmed) {
            taskService.deleteTask(task.id)
                .then(function (response) {
                    Notification.success('Task has been deleted successfully.');
                    $scope.myTasks.splice(index, 1);
                }, function (error) {
                    Notification.error('Unable to delete task: ' + error.statusText);
                });
        }
    };

});