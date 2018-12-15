<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="static/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript"
			src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
		  rel="stylesheet" />
	<title>Insert title here</title>
	<script type="text/javascript">
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
                    url:"${pageContext.request.contextPath}/AddStudent",
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

	</script>
</head>
<body>
<!-- Modal 更新学生信息-->
<div class="modal fade" id="stuUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="UpdateModalLabel">更新学生信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="UpdateForm">
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">用户名</label>
						<div class="col-sm-10 " >
							<input type="text" class="form-control" id="name_update" name="name" placeholder="用户名">
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">性别</label>
						<div class="col-sm-10" id="genderCheck">
							<label class="radio-inline">
								<input type="radio" name="gender" id="inlineRadio3" value="男" > 男
							</label>
							<label class="radio-inline">
								<input type="radio" name="gender" id="inlineRadio4" value="女" > 女
							</label>
						</div>

					</div>
					<div class="form-group">
						<label for="email" class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="email_update"  name="email" placeholder="Email">
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="phone" class="col-sm-2 control-label">电话</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="phone_update"  name="phone" placeholder="Phone">
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="birth" class="col-sm-2 control-label">生日</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="birth_update"  name="birth" placeholder="yyyy-mm-dd格式">
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="regTime" class="col-sm-2 control-label">注册时间</label>
						<div class="col-sm-10">
							<input type="text" class="form-control"  id="regTime_update"  name="regTime" placeholder="yyyy-mm-dd格式">
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">专业</label>
						<div class="col-sm-6">
							<select class="form-control" id="majors_update" name="majorId">
							</select>
						</div>

					</div>

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="update_btn">更新</button>
			</div>
		</div>
	</div>
</div>


<div class="container">

	<div class="row">
		<div class="col-md-12">
			<h2>显示所有学生信息</h2>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-8">

			<!-- Modal 添加学生-->
			<div class="modal fade" id="stuAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title" id="myModalLabel">添加学生</h4>
						</div>
						<div class="modal-body">
							<form class="form-horizontal" id="AddForm">
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">用户名</label>
									<div class="col-sm-10 " >
										<input type="text" class="form-control" id="name" placeholder="用户名" name="name">
										<span class="help-block"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">性别</label>
									<div class="col-sm-10">
										<label class="radio-inline">
											<input type="radio" name="gender" id="inlineRadio1" value="男"> 男
										</label>
										<label class="radio-inline">
											<input type="radio" name="gender" id="inlineRadio2" value="女"> 女
										</label>
									</div>

								</div>
								<div class="form-group">
									<label for="email" class="col-sm-2 control-label">邮箱</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="email" placeholder="Email" name="email">
										<span class="help-block"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="phone" class="col-sm-2 control-label">电话</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="phone" placeholder="Phone" name="phone">
										<span class="help-block"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="birth" class="col-sm-2 control-label">生日</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="birth" placeholder="yyyy-mm-dd格式" name="birth">
										<span class="help-block"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="regTime" class="col-sm-2 control-label">注册时间</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="regTime" placeholder="yyyy-mm-dd格式" name="regTime">
										<span class="help-block"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label">专业</label>
									<div class="col-sm-6">
										<select class="form-control" id="majors" name="majorId">
										</select>
									</div>

								</div>

							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary" id="SaveStu">保存</button>
						</div>
					</div>
				</div>
			</div>


			<button type="button" class="btn btn-primary btn-md" id="AddStu" >
				<span class="glyphicon glyphicon-plus" ></span>
				添加
			</button>
			<button type="button" class="btn btn-success btn-md" id="deleteMany">
				<span class="glyphicon glyphicon-trash" ></span>
				删除
			</button>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<table class="table table-striped" id="stu_table">
				<thead>
				<tr >
					<th><input type="checkbox" class="check_all"  /></th>
					<th>ID</th>
					<th>Name</th>
					<th>Gender</th>
					<th>Email</th>
					<th>Phone</th>
					<th>Birth</th>
					<th>RegTime</th>
					<th>Major</th>
					<th>Delete</th>
					<th>Edit</th>
				</tr>
				</thead>
				<tbody id="stuInfo">
				</tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6" id="page_info_area"></div>
		<div class="col-md-6" id="page_nav_area"></div>
	</div>

	</div>
</div>
</body>
</html>
<!-- 姓名校验：1：entity层配置vilidated校验规则，当姓名发生变化的时候，首先回去校验姓名是不是符合正则，如果符合，再去
校验用户名是否可用，最终返回信息
2：或者query前端首先去校验姓名是否符合规范，如果符合再去校验用户名是否可用
用户保存问题：（根据用户名）如果用户名都符合了两种情况，则在按钮上添加属性status：设置不同的属性值，然后在提交保存前
去校验属性值从而去提交数据（但是可以人为的去改便属性值，不安全）。
这时候就要用到jsr303校验了
1:在元素创建之前绑定了这个元素的时间的处理方法：$(document).on("click","",function(){})这个解决方法
2：表单数据取值只能用val
3:url中带参数和请求中把参数放进data里面的后台handler的处理方式是不同的
4:注意this的使用范围，尤其是用在点击事件的函数里面
5:全选框的问题
1.prop属性来确定(checkbox设置checked属性时)这一系列的类似的标签时
2分割的问题，就是,的问题，网页端和java后端要保持一致
3PUT请求实现的注意事项
@InitBinder
protected void initBinder(WebDataBinder binder) {
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
}必须注释掉这个，如果不注释掉的话，更新后的学生闯入后端封装学生类会为空
还有一个就是日期的转换（重要问题）
//处理阿里云返回json数据时的下载问题
<!-mvc:message-converters>
	<bean class="org.springframework.http.converter.json.MappingJackson2HttpMessageConverter">
	<property name="supportedMediaTypes">
	<list>
	<value>text/html;charset=UTF-8</value><!-- 避免IE出现下载JSON文件的情况 -->
	<!--</list>
	</property>
	</bean>
/mvc:message-converters
-->