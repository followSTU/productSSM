<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
    <style type="text/css">
        .box {
            margin: 0px auto;
            padding: 0px;
            width: 1100px;
            height: 30px;
            line-height: 30px;
            border: 1px dashed red;
            border-radius: 5px;
            background: lightgoldenrodyellow;
        }

        .wrap {
            white-space: nowrap;
            height: 20px;
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
    <script type="text/javascript">
        window.onload = function(){
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

        };

    </script>
</head>

<body>
<div id="demo">
    <div id="box" class="box">
        <div id="wrap" class="wrap">
            <div id="start" class="start">
                <span>1：</span> 人民网莫斯科10月12日电 （记者李明琪 实习生王尹励）据塔斯社报道，莫斯科中小学校学生即将能够通过“莫斯科电子校园”这一在线系统完成家庭作业。
                <span>2:</span>四川连曝“学生官” 省学联表态：必要时建议免职
                <span>3:</span>什么一部分青少年会沉迷网络？在寻找解决方案的时候，大连市教育部门首先选择走近这个群体和他们所“依赖”的游戏内容。


            </div>
            <div id="end" class="end">
                <span>1：</span> 人民网莫斯科10月12日电 （记者李明琪 实习生王尹励）据塔斯社报道，莫斯科中小学校学生即将能够通过“莫斯科电子校园”这一在线系统完成家庭作业。
                <span>2:</span>四川连曝“学生官” 省学联表态：必要时建议免职
                <span>3:</span>什么一部分青少年会沉迷网络？在寻找解决方案的时候，大连市教育部门首先选择走近这个群体和他们所“依赖”的游戏内容。
            </div>
        </div>
    </div>
</div>
 </body>
</html>