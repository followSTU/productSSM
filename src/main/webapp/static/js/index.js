window.onload = function () {
            var total;
            var editID;

            $(function () {
                showPage(1);
            })
            function showPage(n) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/ListByJson",
                    data:"page="+n ,
                    type:"get" ,
                    success: function (result) {
                        //显示学生数据
                        build_stu_table(result);
                        //显示分页信息
                        build_page_info(result);
                        //显示页面导航信息
                        build_page_nav(result);
                    }
                })
            }
            function build_stu_table(result) {
                $("#stu_table tbody").empty();
                var students=result.data.pageStu.list;
                var tempPage=result.data.pageStu.pageNum;
                $.each(students ,function (index ,item) {

                    var checkBox=$("<td><input type='checkbox' class='check_item' id='check' /></td>");
                    var idTD=$("<td></td>").append(item.id);
                    var nameTD=$("<td></td>").append(item.name);
                    var genderTD=$("<td></td>").append(item.gender);
                    var emailTD=$("<td></td>").append(item.email);
                    var phoneTD=$("<td></td>").append(item.phone);
                    var birthTD=$("<td></td>").append(new Date(item.birth).toLocaleDateString());
                    var regTimeTD=$("<td></td>").append(new Date(item.regTime).toLocaleDateString());
                    var majorTD=$("<td></td>").append(item.major.majorName);
                    var deleteD=$("<button></button>").addClass("btn btn-success btn-sm delete").append(
                        $("<span></span>").addClass("glyphicon glyphicon-trash" )).append("删除");
                    deleteD.attr("deleteStudent",item.id);
                    deleteD.attr("currPage",tempPage);
                    var Edit=$("<button></button>").addClass("btn btn-primary btn-sm edit").append(
                        $("<span></span>").addClass("glyphicon glyphicon-pencil")).append("更新");
                    Edit.attr("editStudent",item.id);
                    Edit.attr("currPage",tempPage);
                    var deleteTD=$("<td></td>").append(deleteD);
                    var addTD=$("<td></td>").append(Edit);
                    $("<tr></tr>").append(checkBox)
                        .append(idTD)
                        .append(nameTD)
                        .append(genderTD)
                        .append(emailTD)
                        .append(phoneTD)
                        .append(birthTD)
                        .append(regTimeTD)
                        .append(majorTD)
                        .append(deleteTD)
                        .append(addTD)
                        .appendTo("#stu_table tbody");
                })
            }
            function build_page_info(result) {
                $("#page_info_area").empty();
                $("#page_info_area").append("当前第"+result.data.pageStu.pageNum+"页/总共"+result.data.pageStu.pages+"页，学生总数为："
                    +result.data.pageStu.total
                )
                total=result.data.pageStu.total;
            }
            function build_page_nav(result) {
                $("#page_nav_area").empty();
                var ul = $("<ul></ul>").addClass("pagination");
                var firstPageLi = $("<li></li>").append(
                    $("<a></a>").append("首页").attr("href", "#"));
                var previousPageLi = $("<li></li>").append(
                    $("<a></a>").append("&laquo;").attr("href", "#"));
                if (result.data.pageStu.hasPreviousPage == false) {
                    firstPageLi.addClass("disabled");
                    previousPageLi.addClass("disabled");
                } else {
                    firstPageLi.click(function() {
                        showPage(1);
                    });
                    previousPageLi.click(function() {
                        showPage(result.data.pageStu.pageNum - 1);
                    });
                }
                var nextPageLi = $("<li></li>").append(
                    $("<a></a>").append("&raquo;").attr("href", "#"));
                var lastPageLi = $("<li></li>").append(
                    $("<a></a>").append("末页").attr("href", "#"));
                if (result.data.pageStu.hasNextPage == false) {
                    nextPageLi.addClass("disabled");
                    lastPageLi.addClass("disabled");
                } else {
                    nextPageLi.click(function() {
                        showPage(result.data.pageStu.pageNum + 1);
                    });
                    lastPageLi.click(function() {
                        showPage(result.data.pageStu.pages);
                    });
                }
                ul.append(firstPageLi).append(previousPageLi);
                $.each(result.data.pageStu.navigatepageNums, function(index, item) {
                    var numLi = $("<li></li>").append(
                        $("<a></a>").append(item).attr("href", "#"));
                    if (result.data.pageStu.pageNum == item) {
                        numLi.addClass("active");
                    }
                    numLi.click(function() {
                        showPage(item);
                    });
                    ul.append(numLi);
                });
                ul.append(nextPageLi).append(lastPageLi);
                var navElement = $("<nav></nav>").append(ul).appendTo(
                    "#page_nav_area");
            }
            //点击之前将表单数据删除
            function reset_Form(elem){
                //清除表单数据
                $(elem)[0].reset();
                //清除校验状态
                $(elem).find("*").removeClass("has-success has-error");
                //清除提示信息
                $(elem).find(".help-block").text("");
            }
            //添加学生按钮事件
            $("#AddStu").click(function () {
                reset_Form("#stuAdd form");
                $("#majors").empty();
                getMajors("#majors");
                $('#stuAdd').modal()
            })
            //更新学生按钮事件majors_update
            $(document).on("click",".edit",function () {
                $("#majors_update").empty();
                getMajors("#majors_update");
                var id=$(this).attr("editStudent");
                editID=id;
                getStudentById(id);
                $('#stuUpdate').modal();
            })
            //删除单个学生
            $(document).on("click",".delete",function () {
                var id=$(this).attr("deleteStudent");
                var name=$(this).parent().parent().find("td:eq(2)").text();
                var page=$(this).attr("currPage");
                var isDelete=confirm("确定要删除["+name+"]的学生信息吗？");
                if(isDelete){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/stuDelete/"+id,
                        type:"DELETE",
                        success:function (result) {
                            if(result.code==0){
                                showPage(page);
                            }else{
                                alert("删除学生信息出错，请重试！！！");
                            }
                        }
                    })
                }
            })
            //删除多个学生信息
            $("#deleteMany").click(function () {
                var stuName="";
                var stuIds="";
                var Page;
                $.each($(".check_item:checked"),function () {
                    Page=$(this).parents("tr").find("td:eq(9)").children("button:eq(0)").attr("currPage");
                    stuName+=$(this).parents("tr").find("td:eq(2)").text()+',';
                    stuIds+=$(this).parents("tr").find("td:eq(1)").text()+',';
                })
                stuName=stuName.substring(0,stuName.length-1);
                stuIds=stuIds.substring(0,stuIds.length-1);
                var flag=confirm("确定要删除["+stuName+"]的学生信息吗");
                if(flag){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/stusDelete/"+stuIds,
                        type:"DELETE",
                        success:function (result) {
                            if(result.code==0){
                                showPage(Page);
                            }else{
                                alert(result.data.info);
                            }
                        }
                    })
                }
            })
            //保存修改过得学生信息
            $("#update_btn").click(function () {
                $.ajax({
                    //$("#UpdateForm").serialize()+"&_method=PUT"
                    url:"${pageContext.request.contextPath}/updateStudent/"+editID ,
                    type:'PUT',
                    data:$("#UpdateForm").serialize(),
                    success:function (result) {
                        if(result.code==0){
                            $('#stuAdd').modal('hide');
                            showPage($(this).attr("currPage"));
                        }else{
                            if(result.data.error.name!=undefined){
                                validateParamsStatus("#name_update","失败",result.data.error.name);
                            }
                            if(result.data.error.phone!=undefined){
                                validateParamsStatus("#phone_update","失败",result.data.error.phone);
                            }
                            if(result.data.error.email!=undefined){
                                validateParamsStatus("#email_update","失败",result.data.error.email);
                            }
                            if(result.data.error.birth!=undefined){
                                validateParamsStatus("#birth_update","失败",result.data.error.birth);
                            }
                            if(result.data.error.regTime!=undefined){
                                validateParamsStatus("#regTime_update","失败",result.data.error.regTime);
                            }
                        }
                    }
                })
            })

            function getStudentById(id) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/stuUpdate/"+id ,
                    type:"GET",
                    success:function (result) {
                        if(result.code==0){
                            var student=result.data.student;
                            $("#name_update").val(student.name);
                            $("#birth_update").val(new Date(student.birth).toLocaleDateString());
                            $("#regTime_update").val(new Date(student.regTime).toLocaleDateString());
                            $("#phone_update").val(student.phone);
                            $("#email_update").val(student.email);
                            $("#majors_update").val([student.majorId]);
                            $("#genderCheck input[name=gender]").val([student.gender]);
                        }else{

                        }
                    }
                })
            }
            function getMajors(elem) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/Majors",
                    type:"get",
                    success:function (result) {
                        $.each(result.data.majors,function () {
                            $("<option></option>").append(this.majorName).attr("value",this.majorId).attr("name","majorId").appendTo(elem);
                        })
                    }
                })
            }
            //用户名与数据库匹配通过了才能保存
            //信息改变的时候的时候就调用检测的方法
            $("#name").change(function () {
                checkStuName();
                var name=$("#name").val();
                if(checkStuName()){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/checkStuName",
                        data:"stuName="+ name ,
                        type:"get",
                        success:function (result) {
                            if(result.code==0){
                                validateParamsStatus("#name","成功","用户名可用");
                                $("#SaveStu").attr("isSuccess","YES");

                            }else{
                                validateParamsStatus("#name","失败","用户名已被占用");
                                $("#SaveStu").attr("isSuccess","NO");
                            }
                        }
                    })
                }
            })
            $("#phone").change(function () {
                validateParams();
            })
            $("#email").change(function () {
                validateParams();
            })
            $("#birth").change(function () {
                validateParams();
            })
            $("#regTime").change(function () {
                validateParams();
            })

            $("#SaveStu").click(function () {
                if(!checkStuName()){
                    return false;
                }

                if(!validateParams()){
                    return false;
                }
                if($("#SaveStu").attr("isSuccess")=="NO"){
                    validateParamsStatus("#name","失败","用户名已被占用");
                    return false;
                }
                $.ajax({
                    url:"http://47.107.72.193:8080/ssmTest/AddStudent",
                    data:$("#AddForm").serialize(),
                    type:"POST",
                    success:function(result){
                        if(result.code==0){
                            $('#stuAdd').modal('hide');
                            showPage(total);
                        }else{
                            if(result.data.error.name!=undefined){
                                validateParamsStatus("#name","失败",result.data.error.name);
                            }
                            if(result.data.error.phone!=undefined){
                                validateParamsStatus("#phone","失败",result.data.error.phone);
                            }
                            if(result.data.error.email!=undefined){
                                validateParamsStatus("#email","失败",result.data.error.email);
                            }
                            if(result.data.error.birth!=undefined){
                                validateParamsStatus("#birth","失败",result.data.error.birth);
                            }
                            if(result.data.error.regTime!=undefined){
                                validateParamsStatus("#regTime","失败",result.data.error.regTime);
                            }
                        }
                    }
                })
            })
            function checkStuName() {
                var name=$("#name").val();
                var nameCheck=/(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,8}$)/;
                if(!nameCheck.test(name)){
                    //姓名只能是2~8位的汉子或3~16位的字符
                    validateParamsStatus("#name","失败","姓名只能是2-8位的汉子或3-16位的字符");
                    return false;
                }else{
                    validateParamsStatus("#name","成功","");
                    return true;
                }
            }
            function validateParams() {
                var dataCheck=/^\d{4}-\d{1,2}-\d{1,2}/;
                var emailCheck=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
                var phoneCheck=/^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
                var birth=$("#birth").val();
                var phone=$("#phone").val();
                var email=$("#email").val();
                var regTime=$("#regTime").val();

                if(!emailCheck.test(email)){
                    validateParamsStatus("#email","失败","邮箱格式不正确");
                    return false;
                }else{
                    validateParamsStatus("#email","成功","");
                }
                if(!phoneCheck.test(phone)){
                    validateParamsStatus("#phone","失败","电话号码格式不正确");
                    return false;
                }else{
                    validateParamsStatus("#phone","成功","");
                }
                if(!dataCheck.test(birth)){
                    validateParamsStatus("#birth","失败","日期格式不正确");
                    return false;
                }else{
                    validateParamsStatus("#birth","成功","");
                }

                if(!dataCheck.test(regTime)){
                    validateParamsStatus("#regTime","失败","日期格式不正确");
                    return false;
                }else{
                    validateParamsStatus("#regTime","成功","");
                }

                return true;
            }
            //重写更新的query
            function validateParamsStatus(ele,status,msg){
                $(ele).parent().removeClass("has-success has-error");
                if(status=="失败"){
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                }else{
                    $(ele).parent().addClass("has-success");
                    $(ele).next("span").text(msg);
                }
            }
            $(document).on("mouseover","#stuInfo tr",function () {
				$.each($("#stuInfo tr"),function () {
					$(this).css("background-color","");
                })
                $(this).css("background-color","rgb(217, 237, 247)");
            })
			$(document).on("mouseout","#stuInfo tr",function () {
                $(this).css("background-color","");
            })
            //全选checkbox的实现
            $(".check_all").click(function () {
                $(".check_item").prop("checked",$(this).prop("checked"));
            })
            $(document).on("click",".check_item",function () {
                var flag= $(".check_item:checked").length==$(".check_item").length ;
                $(".check_all").prop("checked",flag);
            })
}