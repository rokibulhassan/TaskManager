var app = angular.module("taskManager", ['ui-notification']);

app.config(function ($httpProvider) {
    var authToken = $("meta[name=\"csrf-token\"]").attr("content");
    return $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
});
