var TodoRoutes=angular.module("TodoRoutes",["ngRoute"]);
TodoRoutes.config(function($routeProvider){
    $routeProvider
        .when("/",
            {
                templateUrl:"TodoList.html",
                controller:"TodoListController"


            })


        .when("/:params",
            {
                templateUrl:"TodoDetail.html",
                controller:"TodoDetailController"


            })



        .otherwise({

            redirectTo:"/"
        });
});
