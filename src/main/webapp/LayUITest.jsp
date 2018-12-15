<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LayUI小测试</title>
<link rel="stylesheet" href="static/layui/css/layui.css" media="all" />
<script src="static/js/date-format.js" type="text/javascript" charset="utf-8"></script>
<script src="static/layui/layui.js"></script>
</head>
<body>
	<table id="demo" lay-filter="test"></table>
    <script id="birth" type="text/html">
    	{{#
		var date = new Date();
    	date.setTime(d.birth);
    	return date.Format("yyyy-MM-dd"); 
}}
   		
    </script>
    <script id="regTime" type="text/html">
    	{{#
		var date = new Date();
    	date.setTime(d.regTime);
    	return date.Format("yyyy-MM-dd hh:mm:ss"); 
}}
   		
    </script>
	<script type="text/javascript">

layui.use('table', function(){
  var table = layui.table;
  
  //第一个实例
   table.render({
    elem: '#demo'
    ,height: 312
    ,limit: 10 //每页默认显示的数量
    ,limits:[10,20,30,50]
    ,url:'http://localhost:8080/ssmTest/LayUI' //数据接口
    ,parseData: function(res){ //res 即为原始返回的数据
    	    return {
    	      "code": res.code, //解析接口状态
    	      "msg": res.msg, //解析提示文本
    	      "count": res.count, //解析数据长度
    	      "data": res.data //解析数据列表
    	    };
    	  }
    ,page: true //开启分页
    ,cols: [[ //表头
      {field: 'id', title: 'ID', width:80, fixed: 'left' ,sort: true}
      ,{field: 'name', title: '用户名', width:80}
      ,{field: 'gender', title: '性别', width:80}
      ,{field: 'email', title: '邮箱', width:150} 
      ,{field: 'phone', title: '电话', width: 150}
      ,{field: 'birth', title: '生日', width: 150,templet:'#birth'}
      ,{field: 'regTime', title: '注册时间', width: 200,templet:'#regTime'}
      ,{field: 'marjorName', title: '专业', width: 80}
    ]]
  });
  
});
</script>
</body>
</html>