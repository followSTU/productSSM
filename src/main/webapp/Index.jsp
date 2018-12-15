<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="static/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript"
            src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <title>Insert title here</title>
    <script type="text/javascript">
        window.onload = function () {
            var total;
            var editID;
			var updatePage;
            $(function () {
                showPage(1);
            })

            function showPage(n) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/products",
                    data: "page=" + n,
                    type: "get",
                    success: function (result) {
                        //显示商品数据
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
                var students = result.data.products.list;
                var tempPage = result.data.products.pageNum;
                $.each(students, function (index, item) {

                    var checkBox = $("<td><input type='checkbox' class='check_item' id='check' /></td>");
                    var idTD = $("<td></td>").append(item.productId);
                    var nameTD = $("<td></td>").append(item.name);
                    var priceTD = $("<td></td>").append(item.price);
                    var xiaoLiangTD = $("<td></td>").append(item.xiaoLiang);
                    var hotTD = $("<td></td>").append(item.hot);
                    var kuCunTD = $("<td></td>").append(item.kuCun);
                    var timeSaleTD = $("<td></td>").append(new Date(item.timeSale).toLocaleDateString());
                    var timeShengChanTD = $("<td></td>").append(new Date(item.timeShengChan).toLocaleDateString());
                    var typeNameTD = $("<td></td>").append(item.type.typeName);
                    var deleteD = $("<button></button>").addClass("btn btn-success btn-sm delete").append(
                        $("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                    deleteD.attr("deleteStudent", item.productId);
                    deleteD.attr("currPage", tempPage);
                    var Edit = $("<button></button>").addClass("btn btn-primary btn-sm edit").append(
                        $("<span></span>").addClass("glyphicon glyphicon-pencil")).append("更新");
                    Edit.attr("editStudent", item.productId);
                    Edit.attr("currPage", tempPage);
                    var deleteTD = $("<td></td>").append(deleteD);
                    var addTD = $("<td></td>").append(Edit);
                    $("<tr></tr>").append(checkBox)
                        .append(idTD)
                        .append(nameTD)
                        .append(priceTD)
                        .append(xiaoLiangTD)
                        .append(hotTD)
                        .append(kuCunTD)
                        .append(timeSaleTD)
                        .append(timeShengChanTD)
                        .append(typeNameTD)
                        .append(deleteTD)
                        .append(addTD)
                        .appendTo("#stu_table tbody");
                })
            }

            function build_page_info(result) {
                $("#page_info_area").empty();
                $("#page_info_area").append("当前第" + result.data.products.pageNum + "页/总共" + result.data.products.pages + "页，商品总数为："
                    + result.data.products.total
                )
                total = result.data.products.total;
            }

            function build_page_nav(result) {
                $("#page_nav_area").empty();
                var ul = $("<ul></ul>").addClass("pagination");
                var firstPageLi = $("<li></li>").append(
                    $("<a></a>").append("首页").attr("href", "#"));
                var previousPageLi = $("<li></li>").append(
                    $("<a></a>").append("&laquo;").attr("href", "#"));
                if (result.data.products.hasPreviousPage == false) {
                    firstPageLi.addClass("disabled");
                    previousPageLi.addClass("disabled");
                } else {
                    firstPageLi.click(function () {
                        showPage(1);
                    });
                    previousPageLi.click(function () {
                        showPage(result.data.products.pageNum - 1);
                    });
                }
                var nextPageLi = $("<li></li>").append(
                    $("<a></a>").append("&raquo;").attr("href", "#"));
                var lastPageLi = $("<li></li>").append(
                    $("<a></a>").append("末页").attr("href", "#"));
                if (result.data.products.hasNextPage == false) {
                    nextPageLi.addClass("disabled");
                    lastPageLi.addClass("disabled");
                } else {
                    nextPageLi.click(function () {
                        showPage(result.data.products.pageNum + 1);
                    });
                    lastPageLi.click(function () {
                        showPage(result.data.products.pages);
                    });
                }
                ul.append(firstPageLi).append(previousPageLi);
                $.each(result.data.products.navigatepageNums, function (index, item) {
                    var numLi = $("<li></li>").append(
                        $("<a></a>").append(item).attr("href", "#"));
                    if (result.data.products.pageNum == item) {
                        numLi.addClass("active");
                    }
                    numLi.click(function () {
                        showPage(item);
                    });
                    ul.append(numLi);
                });
                ul.append(nextPageLi).append(lastPageLi);
                var navElement = $("<nav></nav>").append(ul).appendTo(
                    "#page_nav_area");
            }

            //点击之前将表单数据删除
            function reset_Form(elem) {
                //清除表单数据
                $(elem)[0].reset();
                //清除校验状态
                $(elem).find("*").removeClass("has-success has-error");
                //清除提示信息
                $(elem).find(".help-block").text("");
            }

            //添加商品按钮事件
            $("#AddStu").click(function () {
                reset_Form("#stuAdd form");
                $("#majors").empty();
                getMajors("#majors");
                $('#stuAdd').modal();
            })
            //更新商品按钮事件majors_update
            $(document).on("click", ".edit", function () {
                $("#majors_update").empty();
                getMajors("#majors_update");
                updatePage=$(this).attr("currPage");
                var id = $(this).attr("editStudent");
                editID = id;
                getStudentById(id);
                $('#stuUpdate').modal();
            })
            //删除单个商品
            $(document).on("click", ".delete", function () {
                var id = $(this).attr("deleteStudent");
                var name = $(this).parent().parent().find("td:eq(2)").text();
                var page = $(this).attr("currPage");
                var isDelete = confirm("确定要删除[" + name + "]的商品信息吗？");
                if (isDelete) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/proDelete/" + id,
                        type: "DELETE",
                        success: function (result) {
                            if (result.code == 0) {
                                showPage(page);
                            } else {
                                alert("删除商品信息出错，请重试！！！");
                            }
                        }
                    })
                }
            })
            //删除多个商品信息
            $("#deleteMany").click(function () {
                var proName = "";
                var proIds = "";
                var Page;
                if($(".check_item:checked").length==0){
                    alert("还没选择要删除的商品哦！！");
                    return false;
                }
                $.each($(".check_item:checked"), function () {
                    Page = $(this).parents("tr").find("td:eq(10)").children("button:eq(0)").attr("currPage");
                    proName += $(this).parents("tr").find("td:eq(2)").text() + ',';
                    proIds += $(this).parents("tr").find("td:eq(1)").text() + ',';
                })
                proName = proName.substring(0, proName.length - 1);
                proIds = proIds.substring(0, proIds.length - 1);
                var flag = confirm("确定要删除[" + proName + "]的商品信息吗");
                if (flag) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/prosDelete/" + proIds,
                        type: "DELETE",
                        success: function (result) {
                            if (result.code == 0) {
                                showPage(Page);
                            } else {
                                alert(result.data.info);
                            }
                        }
                    })
                }
            })
            //保存修改过得商品信息
            $("#update_btn").click(function () {
                $.ajax({
                    //$("#UpdateForm").serialize()+"&_method=PUT"
                    url: "${pageContext.request.contextPath}/updatePro/" + editID,
                    type: 'PUT',
                    data: $("#UpdateForm").serialize(),
                    success: function (result) {
                        if (result.code == 0) {
                            $('#stuUpdate').modal('hide');
                            showPage(updatePage);
                        } 
                    }
                })
            })

            function getStudentById(id) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/proUpdate/" + id,
                    type: "GET",
                    success: function (result) {
                        if (result.code == 0) {
                            var product = result.data.product;
                            $("#productId").val(product.productId);
                            $("#name_update").val(product.name);
                            $("#price_update").val(product.price);
                            $("#xiaoLiang_update").val(product.xiaoLiang);
                            $("#hot_update").val(product.hot);
                            $("#kuCun_update").val(product.kuCun);
                            $("#timeSale_update").val(new Date(product.timeSale).toLocaleDateString());
                            $("#timeShengChan_update").val(new Date(product.timeShengChan).toLocaleDateString());
                            $("#type_update").val([product.typeId]);
                        } else {

                        }
                    }
                })
            }

            function getMajors(elem) {
                var flag= elem=='#majors_Search';

                $.ajax({
                    url: "${pageContext.request.contextPath}/getTypes",
                    type: "get",
                    success: function (result) {
                        if(flag){
                            $("<option></option>").append("类型").attr("value",-1).attr("name","typeId").appendTo(elem);
                            $("<option></option>").append("未知").attr("value",0).attr("name","typeId").appendTo(elem);
                        }
                        $.each(result.data.types, function () {
                            $("<option></option>").append(this.typeName).attr("value", this.typeId).attr("name", "typeId").appendTo(elem);
                        })
                    }
                })
            }

            //用户名与数据库匹配通过了才能保存
            //信息改变的时候的时候就调用检测的方法

            $("#name").change(function () {
                checkStuName();
                var name = $("#name").val();
                if (checkStuName()) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/checkProName",
                        data: "proName=" + name,
                        type: "get",
                        success: function (result) {
                            if (result.code == 0) {
                                validateParamsStatus("#name", "成功", "商品名可用");
                                $("#SaveStu").attr("isSuccess", "YES");

                            } else {
                                validateParamsStatus("#name", "失败", "商品名已被占用");
                                $("#SaveStu").attr("isSuccess", "NO");
                            }
                        }
                    })
                }
            })

        //添加一个新的商品信息
            $("#SaveStu").click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/AddPro",
                    data: $("#AddForm").serialize(),
                    type: "POST",
                    success: function (result) {
                        if (result.code == 0) {
                            $('#stuAdd').modal('hide');
                            showPage(total);
                        } else {
                            if (result.data.error.name != undefined) {
                                validateParamsStatus("#name", "失败", result.data.error.name);
                            }
                            if (result.data.error.phone != undefined) {
                                validateParamsStatus("#phone", "失败", result.data.error.phone);
                            }
                            if (result.data.error.email != undefined) {
                                validateParamsStatus("#email", "失败", result.data.error.email);
                            }
                            if (result.data.error.birth != undefined) {
                                validateParamsStatus("#birth", "失败", result.data.error.birth);
                            }
                            if (result.data.error.regTime != undefined) {
                                validateParamsStatus("#regTime", "失败", result.data.error.regTime);
                            }
                        }
                    }
                })
            })

            function checkStuName() {
                var name = $("#name").val();
                var nameCheck = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,8}$)/;
                if (!nameCheck.test(name)) {
                    //姓名只能是2~8位的汉子或3~16位的字符
                    validateParamsStatus("#name", "失败", "商品名只能是2-8位的汉子或3-16位的字符");
                    return false;
                } else {
                    validateParamsStatus("#name", "成功", "");
                    return true;
                }
            }

            function validateParams() {
                var dataCheck = /^\d{4}-\d{1,2}-\d{1,2}/;
                var zhengshu = /^([1-9][0-9]*){1,3}$/;
                var price = $("#price_update").val();
                var xiaoLiang = $("#xiaoLiang_update").val();
                var hot = $("#hot_update").val();
                var kuCun = $("#kuCun_update").val();
                var timeSale = $("#timeSale_update").val();
                var timeShengChan = $("#timeShengChan_update").val();
                alert(timeSale);
                if (!price<=0) {
                    validateParamsStatus("#price", "失败", "请填写大于0的整数");
                    return false;
                } else {
                    validateParamsStatus("#price", "成功", "");
                }
                if (!xiaoLiang<=0) {
                    validateParamsStatus("#xiaoLiang", "失败", "请填写大于0的整数");
                    return false;
                } else {
                    validateParamsStatus("#xiaoLiang", "成功", "");
                }
                if (!hot<=0) {
                    validateParamsStatus("#hot", "失败", "请填写大于0的整数");
                    return false;
                } else {
                    validateParamsStatus("#hot", "成功", "");
                }
                if (!kuCun<=0) {
                    validateParamsStatus("#kuCun", "失败", "日期格式不正确");
                    return false;
                } else {
                    validateParamsStatus("#kuCun", "成功", "");
                }
                if (!dataCheck.test(timeSale)) {
                    validateParamsStatus("#timeSale", "失败", "日期格式不正确");
                    return false;
                } else {
                    validateParamsStatus("#timeSale", "成功", "");
                }
                if (!dataCheck.test(timeShengChan)) {
                    validateParamsStatus("#timeShengChan", "失败", "日期格式不正确");
                    return false;
                } else {
                    validateParamsStatus("#timeShengChan", "成功", "");
                }

                return true;
            }

            //重写更新的query
            function validateParamsStatus(ele, status, msg) {
                $(ele).parent().removeClass("has-success has-error");
                if (status == "失败") {
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                } else {
                    $(ele).parent().addClass("has-success");
                    $(ele).next("span").text(msg);
                }
            }

            $(document).on("mouseover", "#stuInfo tr", function () {
                $.each($("#stuInfo tr"), function () {
                    $(this).css("background-color", "");
                })
                $(this).css("background-color", "rgb(217, 237, 247)");
            })
            $(document).on("mouseout", "#stuInfo tr", function () {
                $(this).css("background-color", "");
            })
            //全选checkbox的实现
            $(".check_all").click(function () {
                $(".check_item").prop("checked", $(this).prop("checked"));
            })
            $(document).on("click", ".check_item", function () {
                var flag = $(".check_item:checked").length == $(".check_item").length;
                $(".check_all").prop("checked", flag);
            })
            /**
             * 改造新鲜玩意的代码
             */
            $("#majors_Search").empty();
            getMajors("#majors_Search");
            $("#btn_Search").click(function () {
                $.ajax({
                    url:"${pageContext.request.contextPath}/searchProduct",
                    data:$("#form_Search").serialize(),
                    type:"POST",
                    success:function (result) {
                        if(result.code==0){
                           if(result.data.products.size == 0){
                               alert("没有此条件下的商品！！！");
                           }else{
                               $("#stuInfo").empty();
                               $("#page_info_area").empty();
                               $("#page_nav_area").empty();
                               build_stu_table(result);
                               //显示分页信息
                               build_page_info(result);
                               //显示页面导航信息
                               build_page_nav(result);
                           }
                        }else{
                            alert("发生错误，请稍后重试");
                        }
                    }
                })
            })
            var box = document.getElementById('box');
            var wrap = document.getElementById('wrap');
            var start = document.getElementById('start');
            var startWidth = getStyle(start, 'width');

            function move() {
                wrap.scrollLeft++;
                if (wrap.scrollLeft >= startWidth) {
                    wrap.scrollLeft = 0;
                }
            }
            var timer = window.setInterval(move, 20);
            box.onmouseover = function () {
                window.clearInterval(timer);
            };
            box.onmouseout = function () {
                timer = window.setInterval(move, 20);
            };

// 获取css的值
            function getStyle(ele, attr) {
                var val = null, reg = null;
                if (window.getComputedStyle) {
                    val = window.getComputedStyle(ele, null)[attr];
                } else {
                    val = ele.currentStyle[attr];
                }
                reg = /^(-?\d+(\.\d+)?)(px|pt|rem|em)?$/i; // 正则匹配单位,若带有px等单位，将单位剔除掉
                return reg.test(val) ? parseFloat(val) : val;
            }
        }

    </script>
    <style type="text/css">
        .box {
            margin: 10px auto;
            width: 1100px;
            height: 30px;
            line-height: 30px;
            border: 1px dashed red;
            border-radius: 5px;
            background: lightgoldenrodyellow;
        }

        .wrap {

            white-space: nowrap;
            height: 30px;
            overflow: hidden;
        }

        .wrap span {
            color: #ff4343;
            font-weight: bold;
            font-size: 16px;
        }

        .start, .end {
            display: inline-block;
        }
    </style>
</head>
<body>
<!-- Modal 更新商品信息-->
<div class="modal fade" id="stuUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="UpdateModalLabel">更新商品信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="UpdateForm">
                	<input type="text" hidden name="productId" id="productId"/>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">商品名</label>
                        <div class="col-sm-10 ">
                            <input type="text" class="form-control" id="name_update" name="name" placeholder="商品名">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">单价</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="price_update" name="price" placeholder="单价">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label">销量</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="xiaoLiang_update" name="xiaoLiang" placeholder="销量" >
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label">热度</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="hot_update" name="hot" placeholder="热度" >
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label">库存</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="kuCun_update" name="kuCun" placeholder="库存" >
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="birth" class="col-sm-2 control-label">上架日期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="timeSale_update" name="timeSale"
                                   placeholder="上架日期" >
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="regTime" class="col-sm-2 control-label">生产日期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="timeShengChan_update" name="timeShengChan"
                                   placeholder="生产日期" >
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">类型</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="majors_update" name="typeId">
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
<!-- Modal 添加商品-->
<div class="modal fade" id="stuAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加商品</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="AddForm">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">商品名</label>
                        <div class="col-sm-10 ">
                            <input type="text" class="form-control" id="name" placeholder="商品名" name="name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">价格</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="price" placeholder="价格" name="price">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label">销量</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="xiaoLiang" placeholder="销量" name="xiaoLiang">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="birth" class="col-sm-2 control-label">热度</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="hot" placeholder="热度" name="hot">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="regTime" class="col-sm-2 control-label">库存</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="kuCun" placeholder="库存"
                                   name="kuCun">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="regTime" class="col-sm-2 control-label">上架日期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="timeSale" placeholder="上架日期"
                                   name="timeSale">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="regTime" class="col-sm-2 control-label">生产日期</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="timeShengChan" placeholder="生产日期"
                                   name="timeShengChan">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">类型</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="majors" name="typeId">
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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2 style="text-align: center">商品信息管理</h2>
        </div>
    </div>
    <div class="row col-md-12">
        <div id="demo">
            <div id="box" class="box">
                <div id="wrap" class="wrap">
                    <div id="start" class="start">
                        <span>1：</span> 人民网莫斯科10月12日电 （记者李明琪 实习生王尹励）据塔斯社报道，莫斯科中小学校商品即将能够通过“莫斯科电子校园”这一在线系统完成家庭作业。
                        <span>2:</span>四川连曝“商品官” 省学联表态：必要时建议免职
                        <span>3:</span>什么一部分青少年会沉迷网络？在寻找解决方案的时候，大连市教育部门首先选择走近这个群体和他们所“依赖”的游戏内容。
                    </div>
                    <div id="end" class="end">
                        <span>1：</span> 人民网莫斯科10月12日电 （记者李明琪 实习生王尹励）据塔斯社报道，莫斯科中小学校商品即将能够通过“莫斯科电子校园”这一在线系统完成家庭作业。
                        <span>2:</span>四川连曝“商品官” 省学联表态：必要时建议免职
                        <span>3:</span>什么一部分青少年会沉迷网络？在寻找解决方案的时候，大连市教育部门首先选择走近这个群体和他们所“依赖”的游戏内容。
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-9">
            <form class="form-inline" id="form_Search">
                <div class="form-group">
                    <label class="sr-only" for="exampleInputEmail3">商品名称</label>
                    <input type="text" class="form-control" id="exampleInputEmail3" placeholder="商品名称" name="name" >
                </div>
                <div class="form-group">
                        <select class="form-control" id="majors_Search" name="typeId">
                        </select>
                </div>
                <button type="button" class="btn btn-danger" id="btn_Search">
                    <span class="glyphicon glyphicon-search"></span>
                     查询
                </button>
            </form>
        </div>
        <div class="col-md-3 ">
            <button type="button" class="btn btn-primary btn-md" id="AddStu">
                <span class="glyphicon glyphicon-plus"></span>
                添加
            </button>
            <button type="button" class="btn btn-success btn-md" id="deleteMany">
                <span class="glyphicon glyphicon-trash"></span>
                多选删除
            </button>
        </div>
    </div>
    <div class="row" >
        <div class="col-md-12">
            <table class="table table-striped" id="stu_table">
                <thead>
                <tr>
                    <th><input type="checkbox" class="check_all"/></th>
                    <th>编号</th>
                    <th>名称</th>
                    <th>价格</th>
                    <th>销量</th>
                    <th>热度</th>
                    <th>库存</th>
                    <th>上架日期</th>
                    <th>生产日期</th>
                    <th>类型</th>
                    <th>Delete</th>
                    <th>Edit</th>
                </tr>
                </thead>
                <tbody id="stuInfo">
                </tbody>
            </table>
        </div>
    </div>
    <div class="row" >
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
}必须注释掉这个，如果不注释掉的话，更新后的商品闯入后端封装商品类会为空
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
网页端发出的请求类型忽略get请求，只有post（就为get一样），delete，put
范德萨发
法师打发士大夫
fdsafdsafdasfgdsa
发送到发放
-->
