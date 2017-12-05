

var TodoService = angular.module('TodoService',['ngResource','murl'])
TodoService.factory('TodoListService',["$resource",function($resource){
    return murl.header.get($resource,murl.orignite.TodoList)
}])
TodoService.factory('TodoAlreadyService',["$resource",function($resource){
    return murl.header.get($resource,murl.orignite.TodoAlreadyService)
}])


TodoService.factory('TodoDetailService', ["$resource",function($resource){
    return murl.header.get($resource,murl.orignite.TodoDetail)
}])

TodoService.factory('TodoPostDetailService', ["$resource",function($resource){
    return murl.header.get($resource,murl.orignite.TodoPostDetail)
}])

TodoService.factory('TodoAlreadyDetail', ["$resource",function($resource){
    return murl.header.get($resource,murl.orignite.TodoAlreadyDetail)
}])

TodoService.factory('GetOrganizationService', ["$resource",function($resource){
    return murl.header.get($resource,murl.orignite.GetOrganization)
}])
TodoService.factory('PlusSignedService', ["$resource",function($resource){
    return murl.header.post($resource,murl.orignite.PlusSigned)
}])






