var ToDoFilters=angular.module("ToDoFilters",[]);
ToDoFilters

    .filter('formatnumber', function () {
        return function (input) {
            return input.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        };
    })
    .filter('changedate', function () {
        return function (input) {


            return moment(input).format('YYYY-MM-DD HH:mm:ss');
        };
    })
    //.filter('nnnnnfilter', function () {
    //    return function (input) {
    //           console.log(input);
    //
    //        return input.replace(/\n/g,'');
    //    };
    //})
    .filter('changename', function () {
        return function (input) {


            return  input.split("(")[0] ;
        };
    })
    .filter('changedate2', function () {
        return function (input) {
            return input.split(" ")[0];
        };
    })
    .filter('trustAsResourceUrl', ['$sce', function($sce) {
        return function(val) {
            return $sce.trustAsResourceUrl(val);
        };
    }])