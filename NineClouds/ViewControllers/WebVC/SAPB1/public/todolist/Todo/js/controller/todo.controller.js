

// 待办列表和已办列表的事项
var TodoListController=angular.module("TodoListController",["config","murl"]);
TodoListController.controller("TodoListController",function($scope,TodoListService,$rootScope,TodoAlreadyService) {
    $scope.confighost=config.host;
    $scope.tabTitle="待办列表";
    $scope.showmore = true;
    $scope.showmore2 = true;
    $scope.puttext='';
    var pageNumCount=1;
    var chaxun = 0;
    var pageNumCount2=1;
    var chaxun2 = 0;
    $rootScope.$on('chongxinfasong', function(event, mass) {
        updateTodoList('1','',function(esp){
        });
    });
    updateTodoList('1','',function(esp){
    });

    function updateTodoList (pageNum,subject,callback){
		
        console.log("ksladjfldsajfl")



        if (subject == null){
            subject='';

        }
        if (pageNum == null){

            pageNum='1';
        }
        console.log(pageNum)
        // $scope.showmore = true;
        TodoListService.get({
            "approvalId" : userid,
            "pagerNum" :pageNum,
            "pagerCount":"10",
            "conDition":subject,
            "companyId":GetQueryString("companyId")
        }, function (resp) {
            console.log(resp)
            $scope.showmore = true;
           if(pageNum == 1){
               	$scope.gtasks=resp.content;
               if (resp.content.length==0){
                   $scope.showmore = false;
                   $(".refreshLetter").text("查询无结果");
               }else{
                   $(".refreshLetter").text("已加载全部");
               }
               if($scope.gtasks.length < 10){
                   $scope.showmore = false;
               }else{
                   $scope.showmore = true;
               }
           }else {
               $(".refreshLetter").text("已加载全部");
				if(resp.content){

                    if(!resp.content.length){
                        $scope.showmore = false;
                        callback(resp);
                        return false;
                    }
					for(var i=0;i<resp.content.length;i++){
	                    if (!$scope.gtasks.contains(resp.content[i])){
	
	                        $scope.gtasks.push(resp.content[i]);
	                    }
						
	              }
	               if (resp.content.length==0){
						$scope.showmore = false;
	               }
				}else{
					$scope.showmore = false;
				}
               

           }


            callback(resp);

        },function(err){

            callback(err);
        })
        $(".show").addClass('hidden');
    }

    function updateTodoList2 (pageNum,subject,callback){

        console.log("ksladjfldsajfl")



        if (subject == null){
            subject='';

        }
        if (pageNum == null){

            pageNum='1';
        }
        console.log(pageNum)
        // $scope.showmore = true;
        TodoAlreadyService.get({"approvalId" : userid,"pagerNum" :pageNum,"pagerCount":"10","conDition":subject,"companyId":GetQueryString("companyId")}, function (resp) {
            console.log(resp)
            $scope.showmore2 = true;
            if(pageNum == 1){
                $scope.gtasks2=resp.content;
                if (resp.content.length==0){
                    $scope.showmore2 = false;
                    $(".refreshLetter2").text("查询无结果");
                }else{
                    $(".refreshLetter2").text("已加载全部");
                }
                if($scope.gtasks2.length < 10){
                    $scope.showmore2 = false;
                }else{
                    $scope.showmore2 = true;
                }
            }else {
                $(".refreshLetter2").text("已加载全部");
                if(resp.content){

                    if(!resp.content.length){
                        $scope.showmore2 = false;
                        callback(resp);
                        return false;
                    }
                    for(var i=0;i<resp.content.length;i++){
                        if (!$scope.gtasks2.contains(resp.content[i])){

                            $scope.gtasks2.push(resp.content[i]);
                        }

                    }
                    if (resp.content.length==0){
                        $scope.showmore2 = false;
                    }
                }else{
                    $scope.showmore2 = false;
                }


            }


            callback(resp);

        },function(err){

            callback(err);
        })
        $(".show").addClass('hidden');
    }
    function GetQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    $(document).on("pageInit", "#page-ptr", function(e, id, page) {
        //下拉刷新页面
            var $content = $(page).find(".content").on('refresh', function(e) {
                if($("#todolist").css("display") == "block") {
                    console.log(77777)
                    pageNumCount = 1;
                    $scope.showmore = true;
                    updateTodoList('1', '', function (esp) {

                        $.pullToRefreshDone($content);
                    });
                }else{
                    console.log(2222)
                    pageNumCount2 = 1;
                    $scope.showmore2 = true;
                    updateTodoList2('1', '', function (esp) {

                        $.pullToRefreshDone($content);
                    });
                }
            });
    });
    $(document).on("pageInit", function(e, id, page) {
   //无限下拉

        var loading = false;

        var $content2 =  $(page).on('infinite', function()  {
            // 如果正在加载，则退出
            if (loading) {
                return;
            }
            loading = true;
            if($(this).find(".infinite-scroll").eq(1).css("display") == "none") {
                console.log("待办")
                pageNumCount++;
                // console.log($scope.showmore)
                //			if($scope.showmore){
                updateTodoList(pageNumCount, $scope.puttext, function (esp) {
                    loading = false;
                    $.refreshScroller();

                });
            }else{
                console.log("已办")
                pageNumCount2++;
                // console.log($scope.showmore2)
                //			if($scope.showmore){
                updateTodoList2(pageNumCount2, $scope.puttext, function (esp) {

                    loading = false;
                    $.refreshScroller();

                });

            }
        });
    })

    var watch = $scope.$watch('puttext',function(newValue,oldValue, scope){

            if($("#todolist").css("display") == "block"){
                updateTodoList("1",newValue,function(esp) {
                    if(	$scope.gtasks.length >= 10){
                        return false;
                    }
                    $scope.showmore = false;

                });
            }else{
                updateTodoList2("1",newValue,function(esp) {
                    if(	$scope.gtasks2.length >= 10){
                        return false;
                    }
                    $scope.showmore2 = false;

                });
            }



    });



    $scope.showdetail=function(data){

        $rootScope.$broadcast('someData', data);

        $.router.load("#router2");
    }

    $scope.showdetailAlready=function(data){

        $rootScope.$broadcast('someData2', data);

        $.router.load("#routerAlready");
    }


    // 切换内容
    $scope.tabClick = function (selector){
        $("#"+selector).show();
        $scope.puttext = "";
        if(selector == "todolist"){

            $(".bar-tab .tab-item").eq(0).addClass("active");
            $(".bar-tab .tab-item").eq(1).removeClass("active");
            $("#todolistAlready").hide();
            $scope.tabTitle="待办列表";

            $('#todolist').scrollTop(0);
            console.log($('.infinite-scroll').eq(0).find(".container").scrollTop())
            updateTodoList('1','',function(esp){
                pageNumCount = 1;
                $(".container").eq(1).find("li").remove();
            });


        }else{
            $(".bar-tab .tab-item").eq(1).addClass("active");
            $(".bar-tab .tab-item").eq(0).removeClass("active");
            $("#todolist").hide();
            $scope.tabTitle="已办列表";
            updateTodoList2('1','',function(esp){
                pageNumCount2 = 1;
                $(".container").eq(0).find("li").remove();
            });

        }
    }



})


//待办列表的详情
var TodoDetailController=angular.module("TodoDetailController",["config","murl"]);
TodoDetailController.controller("TodoDetailController",function($scope,TodoDetailService,TodoPostDetailService,PlusSignedService,$rootScope) {
    $scope.confighost=config.host;

    $rootScope.$on('someData', function(event, mass) {
        console.log(mass)
        //alert("传值"+mass.taskid);
    $scope.passvalue=mass;
        var  params={
            'ordertype':mass.ordertype,
             'docentry':mass.docentry
        };

        $scope.testvalue='';
        $scope.choiceDTOData=null;
        $scope.choicedPerData=null;
        $scope.inputvalue='';
        console.log(params)
        updateTodoDetail(params,function(resp){});
    });

    $rootScope.$on('choicePerData', function(event, mass) {

        $scope.choicedPerData={"approvaltypeDTO":[{"outcomes":"同意","typename":"同意","typevalue":"同意"},{"outcomes":"不同意","typename":" 不同意","typevalue":" 不同意"}]};
    });

    function updateTodoDetail (params,callback){


            $.showPreloader('加载数据中')


        TodoDetailService.get(params, function (resp) {
            console.log(resp)
            callback(resp);
            $scope.data=resp.content;
        //     for (var  u=0;u< $scope.data.nodeTable.length;u++){
        //        var applyvalue=  $scope.data.nodeTable[u].applyvalue;
        //         var applyvaluearr= applyvalue.trim().split("\n");
        //     $scope.data.nodeTable[u].applyvalue=applyvaluearr;
        //
        // }
            $scope.choicedPerData2={"approvaltypeDTO":[{"outcomes":"同意","typename":"同意","typevalue":"同意"},{"outcomes":"不同意","typename":" 不同意","typevalue":" 不同意"}]};


            $.hidePreloader();
        },function(err){

            callback(err);
            $.hidePreloader();
        })
    }
    $scope.choiceDTO=function(data){
        $scope.choicedPerData=null;
        $scope.choiceDTOData=data;
        console.log( $scope.choiceDTOData);

        // if($scope.choiceDTOData.typevalue == 'plusSigned'){
        //     $.router.load("#router4");
        //     $rootScope.$broadcast('choiceData',$scope.choiceDTOData);
        // }else if($scope.choiceDTOData.typevalue == 'countersign'){
        //     $.router.load("#router4");
        //     $rootScope.$broadcast('choiceData', $scope.choiceDTOData);
        //
        // }else if($scope.choiceDTOData.typevalue == 'transferPackage'){
        //     $.router.load("#router4");
        //     $rootScope.$broadcast('choiceData',$scope.choiceDTOData);
        //
        // }
    }

       var scopeData = $scope.$watch ("data",function (){
           if($scope.data){
               for(var j = 0; j < $scope.data.length;j ++){
                   $scope["kApplyInfoSection"+j] = true;
               }
               scopeData();
           }
       })
       $scope.kDetailInfoSection=true,
       $scope.kAttachmentSection=true;
       $scope.kSugestionSection=true;
       $scope.kApprovalResultSection=true;


    $scope.closeoropen=function(ind,index){

        switch(ind)
        {
            case 1:
                if (!$scope["kApplyInfoSection"+index]){
                    $(".rightIcon1"+index).css( "background","url('../../images/less.png')");
                }else {
                    $(".rightIcon1"+index).css( "background","url('../../images/add.png')");

                }

                $scope["kApplyInfoSection"+index]=!$scope["kApplyInfoSection"+index];

                break;
            case 2:

                $scope.kDetailInfoSection=!$scope.kDetailInfoSection;

                break;
            case 3:
                if (!$scope.kAttachmentSection){
                    $(".rightIcon2").css( "background","url('../../images/less.png')");
                }else {
                    $(".rightIcon2").css( "background","url('../../images/add.png')");

                }
                $scope.kAttachmentSection=!$scope.kAttachmentSection;
                break;
            case 4:
                if (!$scope.kSugestionSection){
                    $(".rightIcon3").css( "background","url('../../images/less.png')");
                }else {
                    $(".rightIcon3").css( "background","url('../../images/add.png')");

                }
                $scope.kSugestionSection=! $scope.kSugestionSection;
                break;
            case 5:
                if (!$scope. kApprovalResultSection){
                    $(".rightIcon4").css( "background","url('../../images/less.png')");
                }else {
                    $(".rightIcon4").css( "background","url('../../images/add.png')");

                }
                $scope. kApprovalResultSection=! $scope. kApprovalResultSection;
                break;
            default:break;
        }

    }

    function GetQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    $scope.submiit=function(){
         console.log($scope.choiceDTOData);
        if($scope.choiceDTOData){

            // if($scope.choiceDTOData.typevalue != 'agreed'&& $scope.inputvalue =='' ){
            //     $.alert( '请选输入审批意见','温馨提示',
            //         function () {
            //             console.log('确定');
            //         }
            //     );
            //     console.log(222)
            //
            // }else {
            //     $.confirm('审批意见:'+$scope.inputvalue+'\n审批结果:'+$scope.choiceDTOData.typename, '确认提交吗?',
            //         function () {
                    console.log($scope.choiceDTOData.typename)
                        var dicParameter = {
                            "orderType": $scope.passvalue.ordertype,
                            "docEntry": $scope.passvalue.docentry,
                            "userID": userid,
                            "approvalMemo": $scope.inputvalue,
                            "approvals": ($scope.choiceDTOData.typename == "同意" ? "Y" : "N"),
                            "companyId":GetQueryString("companyId")
                        };

                        console.log(dicParameter);
                        POSTTodoDetail(dicParameter, function (data) {

                        });
                    // },
                    // function () {
                    //
                    // }
                // );
            // }


        }else {

            $.alert( '请选择审批意见','温馨提示',
                function () {
                   console.log('确定');
                }
            );


        }

    }


    function POSTTodoDetail (params,callback){
        $.showPreloader('数据提交中');
        TodoPostDetailService.get(params, function (resp) {
                console.log(resp);
                $.hidePreloader();
                callback(resp);
                if(resp.code==0){
                    $.alert( '提交成功','温馨提示',
                        function () {

                            $.router.back();
                            $rootScope.$broadcast('chongxinfasong');
                        }
                    );
                }else {
                    $.alert( '服务器出错,请稍后提交','温馨提示',
                        function () {}
                    );

                }


            },function(err){
                console.log(err);
                $.hidePreloader();
                callback(err);
                $.alert( '服务器出错,请稍后提交','温馨提示',
                    function () {}
                );


            });


    }
});

//已办列表的详情
var TodoDetailAlreadyController=angular.module("TodoDetailAlreadyController",["config","murl"]);
TodoDetailAlreadyController.controller("TodoDetailAlreadyController",function($scope,TodoAlreadyDetail,$rootScope) {
    $scope.confighost=config.host;

    $rootScope.$on('someData2', function(event, mass) {
        console.log(mass)
        //alert("传值"+mass.taskid);
        $scope.passvalue=mass;
        var  params={
            'ordertype':mass.ordertype,
            'docentry':mass.docentry
        };

        $scope.testvalue='';
        $scope.choiceDTOData=null;
        $scope.choicedPerData=null;
        $scope.inputvalue='';
        console.log(params)
        updateTodoDetail(params,function(resp){});
    });

    $rootScope.$on('choicePerData', function(event, mass) {

        $scope.choicedPerData={"approvaltypeDTO":[{"outcomes":"同意","typename":"同意","typevalue":"同意"},{"outcomes":"不同意","typename":" 不同意","typevalue":" 不同意"}]};
    });

    function updateTodoDetail (params,callback){


        $.showPreloader('加载数据中')


        TodoAlreadyDetail.get(params, function (resp) {
            console.log(resp)
            callback(resp);
            $scope.data=resp.content;
            //     for (var  u=0;u< $scope.data.nodeTable.length;u++){
            //        var applyvalue=  $scope.data.nodeTable[u].applyvalue;
            //         var applyvaluearr= applyvalue.trim().split("\n");
            //     $scope.data.nodeTable[u].applyvalue=applyvaluearr;
            //
            // }
            $scope.choicedPerData2={"approvaltypeDTO":[{"outcomes":"同意","typename":"同意","typevalue":"同意"},{"outcomes":"不同意","typename":" 不同意","typevalue":" 不同意"}]};


            $.hidePreloader();
        },function(err){

            callback(err);
            $.hidePreloader();
        })
    }
    $scope.choiceDTO=function(data){
        $scope.choicedPerData=null;
        $scope.choiceDTOData=data;
        console.log( $scope.choiceDTOData);
    }

    var scopeData = $scope.$watch ("data",function (){
        if($scope.data){
            for(var j = 0; j < $scope.data.length;j ++){
                $scope["kApplyInfoSection"+j] = true;
            }
            scopeData();
        }
    })
    $scope.kDetailInfoSection=true,
    $scope.kAttachmentSection=true;
    $scope.kSugestionSection=true;
    $scope.kApprovalResultSection=true;


    $scope.closeoropen=function(ind,index){

        switch(ind)
        {
            case 1:
                if (!$scope["kApplyInfoSection"+index]){
                    $(".rightIcon1"+index).css( "background","url('../../images/less.png')");
                }else {
                    $(".rightIcon1"+index).css( "background","url('../../images/add.png')");

                }

                $scope["kApplyInfoSection"+index]=!$scope["kApplyInfoSection"+index];

                break;
            case 2:

                $scope.kDetailInfoSection=!$scope.kDetailInfoSection;

                break;
            case 3:
                if (!$scope.kAttachmentSection){
                    $(".rightIcon2").css( "background","url('../../images/less.png')");
                }else {
                    $(".rightIcon2").css( "background","url('../../images/add.png')");

                }
                $scope.kAttachmentSection=!$scope.kAttachmentSection;
                break;
            case 4:
                if (!$scope.kSugestionSection){
                    $(".rightIcon3").css( "background","url('../../images/less.png')");
                }else {
                    $(".rightIcon3").css( "background","url('../../images/add.png')");

                }
                $scope.kSugestionSection=! $scope.kSugestionSection;
                break;
            case 5:
                if (!$scope. kApprovalResultSection){
                    $(".rightIcon4").css( "background","url('../../images/less.png')");
                }else {
                    $(".rightIcon4").css( "background","url('../../images/add.png')");

                }
                $scope. kApprovalResultSection=! $scope. kApprovalResultSection;
                break;
            default:break;
        }

    }

});









