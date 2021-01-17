<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta name="description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
    <!-- Twitter meta-->
    <meta property="twitter:card" content="summary_large_image">
    <meta property="twitter:site" content="@pratikborsadiya">
    <meta property="twitter:creator" content="@pratikborsadiya">
    <!-- Open Graph Meta-->
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="Vali Admin">
    <meta property="og:title" content="Vali - Free Bootstrap 4 admin theme">
    <meta property="og:url" content="http://pratikborsadiya.in/blog/vali-admin">
    <meta property="og:image" content="http://pratikborsadiya.in/blog/vali-admin/hero-social.png">
    <meta property="og:description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
    <title>员工管理系统</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <style type="text/css">
  	.form-group div {
  		display: inline-block;
  	}
  	.form-group label {
  		text-align: right;
  	}
  	.form-group input {
 		margin: 8px;
  	}
  	a, a:active, a:hover, a:focus, a:visited, a:link, a:hover {
	  text-decoration: none;
	}
  </style>
  </head>
  <body class="app sidebar-mini rtl">
    <!-- Navbar-->
    <header class="app-header"><a class="app-header__logo" href="#" style="letter-spacing:4px;">员工管理系统</a>
      <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
      <!-- Navbar Right Menu-->
      <ul class="app-nav">
        <li class="app-search">
          <input class="app-search__input" type="search" id="wd" placeholder="Search">
          <button class="app-search__button" onclick="search()"><i class="fa fa-search"></i></button>
        </li>
        <!--Notification Menu-->
        <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Show notifications"><i class="fa fa-bell-o fa-lg"></i></a>
          <ul class="app-notification dropdown-menu dropdown-menu-right">
            <li class="app-notification__title">You have 4 new notifications.</li>
            <div class="app-notification__content">
              <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-primary"></i><i class="fa fa-envelope fa-stack-1x fa-inverse"></i></span></span>
                  <div>
                    <p class="app-notification__message">Lisa sent you a mail</p>
                    <p class="app-notification__meta">2 min ago</p>
                  </div></a></li>
              <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-danger"></i><i class="fa fa-hdd-o fa-stack-1x fa-inverse"></i></span></span>
                  <div>
                    <p class="app-notification__message">Mail server not working</p>
                    <p class="app-notification__meta">5 min ago</p>
                  </div></a></li>
              <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-success"></i><i class="fa fa-money fa-stack-1x fa-inverse"></i></span></span>
                  <div>
                    <p class="app-notification__message">Transaction complete</p>
                    <p class="app-notification__meta">2 days ago</p>
                  </div></a></li>
              <div class="app-notification__content">
                <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-primary"></i><i class="fa fa-envelope fa-stack-1x fa-inverse"></i></span></span>
                    <div>
                      <p class="app-notification__message">Lisa sent you a mail</p>
                      <p class="app-notification__meta">2 min ago</p>
                    </div></a></li>
                <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-danger"></i><i class="fa fa-hdd-o fa-stack-1x fa-inverse"></i></span></span>
                    <div>
                      <p class="app-notification__message">Mail server not working</p>
                      <p class="app-notification__meta">5 min ago</p>
                    </div></a></li>
                <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-success"></i><i class="fa fa-money fa-stack-1x fa-inverse"></i></span></span>
                    <div>
                      <p class="app-notification__message">Transaction complete</p>
                      <p class="app-notification__meta">2 days ago</p>
                    </div></a></li>
              </div>
            </div>
            <li class="app-notification__footer"><a href="#">See all notifications.</a></li>
          </ul>
        </li>
        <!-- User Menu-->
        <input type="hidden" id="userid" name="userid" value="${userInfo.id}">
        <input type="hidden" id="role" name="role" value="${userInfo.role}">
        <input type="hidden" id="checkstatus" name="checkstatus" value="${userInfo.checkstatus}">
        <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu">${userInfo.role}&nbsp;${userInfo.username}&nbsp;<i class="fa fa-user fa-lg"></i></a>
          <ul class="dropdown-menu settings-menu dropdown-menu-right">
            <li><a class="dropdown-item" href="javascript:changeMenu('getuserinfo.user')"><i class="fa fa-cog fa-lg"></i>&nbsp;个人信息</a></li>
            <li><a class="dropdown-item" href="javascript:changePassword(${userInfo.id})"><i class="fa fa-user fa-lg"></i>&nbsp;修改密码</a></li>
            <li><a class="dropdown-item" href="javascript:quit();"><i class="fa fa-sign-out fa-lg"></i>&nbsp;退出</a></li>
          </ul>
        </li>
      </ul>
    </header>
    <!-- Sidebar menu-->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
      <!-- <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/48.jpg" alt="User Image">
        <div>
          <p class="app-sidebar__user-name">John Doe</p>
          <p class="app-sidebar__user-designation">Frontend Developer</p>
        </div>
      </div> -->
      <ul class="app-menu">
        <li id="signin">
          <a class="app-menu__item" href="javascript: signin()">
            <i class="app-menu__icon fa fa-check-circle"></i>
            <span class="app-menu__label" id='signintext'>${userInfo.checkstatus}</span>
          </a>
        </li>
        <li id="staffMange">
          <a class="app-menu__item" href="javascript: changeMenu('findStaff.st')">
            <i class="app-menu__icon fa fa-id-card"></i>
            <span class="app-menu__label">员工管理</span>
          </a>
        </li>
        <li id="checkMange">
          <a class="app-menu__item" href="javascript: changeMenu('findStatus.ck')">
            <i class="app-menu__icon fa fa-edit"></i>
            <span class="app-menu__label">考勤管理</span>
          </a>
        </li>
        <li id="infoMange" style="display:none;">
          <a class="app-menu__item" href="#"> <!-- javascript: changeMenu('findAllStudent.st') -->
            <i class="app-menu__icon fa fa-file-text"></i>
            <span class="app-menu__label">信息发布</span>
          </a>
        </li>
        <!-- <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-laptop"></i><span class="app-menu__label">UI Elements</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="bootstrap-components.html"><i class="icon fa fa-circle-o"></i> Bootstrap Elements</a></li>
            <li><a class="treeview-item" href="https://fontawesome.com/v4.7.0/icons/" target="_blank" rel="noopener"><i class="icon fa fa-circle-o"></i> Font Icons</a></li>
            <li><a class="treeview-item" href="ui-cards.html"><i class="icon fa fa-circle-o"></i> Cards</a></li>
            <li><a class="treeview-item" href="widgets.html"><i class="icon fa fa-circle-o"></i> Widgets</a></li>
          </ul>
        </li>
        <li><a class="app-menu__item" href="charts.html"><i class="app-menu__icon fa fa-pie-chart"></i><span class="app-menu__label">Charts</span></a></li>
        <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-edit"></i><span class="app-menu__label">Forms</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="form-components.html"><i class="icon fa fa-circle-o"></i> Form Components</a></li>
            <li><a class="treeview-item" href="form-custom.html"><i class="icon fa fa-circle-o"></i> Custom Components</a></li>
            <li><a class="treeview-item" href="form-samples.html"><i class="icon fa fa-circle-o"></i> Form Samples</a></li>
            <li><a class="treeview-item" href="form-notifications.html"><i class="icon fa fa-circle-o"></i> Form Notifications</a></li>
          </ul>
        </li>
        <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-th-list"></i><span class="app-menu__label">Tables</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="table-basic.html"><i class="icon fa fa-circle-o"></i> Basic Tables</a></li>
            <li><a class="treeview-item" href="table-data-table.html"><i class="icon fa fa-circle-o"></i> Data Tables</a></li>
          </ul>
        </li>
        <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-file-text"></i><span class="app-menu__label">Pages</span><i class="treeview-indicator fa fa-angle-right"></i></a>
          <ul class="treeview-menu">
            <li><a class="treeview-item" href="blank-page.html"><i class="icon fa fa-circle-o"></i> Blank Page</a></li>
            <li><a class="treeview-item" href="page-login.html"><i class="icon fa fa-circle-o"></i> Login Page</a></li>
            <li><a class="treeview-item" href="page-lockscreen.html"><i class="icon fa fa-circle-o"></i> Lockscreen Page</a></li>
            <li><a class="treeview-item" href="userInfo.jsp"><i class="icon fa fa-circle-o"></i> User Page</a></li>
            <li><a class="treeview-item" href="page-invoice.html"><i class="icon fa fa-circle-o"></i> Invoice Page</a></li>
            <li><a class="treeview-item" href="page-calendar.html"><i class="icon fa fa-circle-o"></i> Calendar Page</a></li>
            <li><a class="treeview-item" href="page-mailbox.html"><i class="icon fa fa-circle-o"></i> Mailbox</a></li>
            <li><a class="treeview-item" href="page-error.html"><i class="icon fa fa-circle-o"></i> Error Page</a></li>
          </ul>
        </li> -->
      </ul>
    </aside>
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1 id="title-1" ><i class="fa fa-dashboard"></i> Dashboard</h1>
          <p>A free and open source Bootstrap 4 admin template</p>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item"><a href="#">Dashboard</a></li>
        </ul>
      </div>
      <div class="row">
        <div class="col-md-6 col-lg-3">
          <div class="widget-small primary coloured-icon"><i class="icon fa fa-users fa-3x"></i>
            <div class="info">
              <h4>Users</h4>
              <p><b>5</b></p>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="widget-small info coloured-icon"><i class="icon fa fa-thumbs-o-up fa-3x"></i>
            <div class="info">
              <h4>Likes</h4>
              <p><b>25</b></p>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="widget-small warning coloured-icon"><i class="icon fa fa-files-o fa-3x"></i>
            <div class="info">
              <h4>Uploades</h4>
              <p><b>10</b></p>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="widget-small danger coloured-icon"><i class="icon fa fa-star fa-3x"></i>
            <div class="info">
              <h4>Stars</h4>
              <p><b>500</b></p>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="tile">
            <h3 class="tile-title">Monthly Sales</h3>
            <div class="embed-responsive embed-responsive-16by9">
              <canvas class="embed-responsive-item" id="lineChartDemo"></canvas>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="tile">
            <h3 class="tile-title">Support Requests</h3>
            <div class="embed-responsive embed-responsive-16by9">
              <canvas class="embed-responsive-item" id="pieChartDemo"></canvas>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="tile">
            <h3 class="tile-title">Features</h3>
            <ul>
              <li>Built with Bootstrap 4, SASS and PUG.js</li>
              <li>Fully responsive and modular code</li>
              <li>Seven pages including login, user profile and print friendly invoice page</li>
              <li>Smart integration of forgot password on login page</li>
              <li>Chart.js integration to display responsive charts</li>
              <li>Widgets to effectively display statistics</li>
              <li>Data tables with sort, search and paginate functionality</li>
              <li>Custom form elements like toggle buttons, auto-complete, tags and date-picker</li>
              <li>A inbuilt toast library for providing meaningful response messages to user's actions</li>
            </ul>
            <p>Vali is a free and responsive admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.</p>
            <p>Vali is is light-weight, expendable and good looking theme. The theme has all the features required in a dashboard theme but this features are built like plug and play module. Take a look at the <a href="http://pratikborsadiya.in/blog/vali-admin" target="_blank">documentation</a> about customizing the theme colors and functionality.</p>
            <p class="mt-4 mb-4"><a class="btn btn-primary mr-2 mb-2" href="http://pratikborsadiya.in/blog/vali-admin" target="_blank"><i class="fa fa-file"></i>Docs</a><a class="btn btn-info mr-2 mb-2" href="https://github.com/pratikborsadiya/vali-admin" target="_blank"><i class="fa fa-github"></i>GitHub</a><a class="btn btn-success mr-2 mb-2" href="https://github.com/pratikborsadiya/vali-admin/archive/master.zip" target="_blank"><i class="fa fa-download"></i>Download</a></p>
          </div>
        </div>
        <div class="col-md-6">
          <div class="tile">
            <h3 class="tile-title">Compatibility with frameworks</h3>
            <p>This theme is not built for a specific framework or technology like Angular or React etc. But due to it's modular nature it's very easy to incorporate it into any front-end or back-end framework like Angular, React or Laravel.</p>
            <p>Go to <a href="http://pratikborsadiya.in/blog/vali-admin" target="_blank">documentation</a> for more details about integrating this theme with various frameworks.</p>
            <p>The source code is available on GitHub. If anything is missing or weird please report it as an issue on <a href="https://github.com/pratikborsadiya/vali-admin" target="_blank">GitHub</a>. If you want to contribute to this theme pull requests are always welcome.</p>
          </div>
        </div>
      </div>
    </main>
    <!-- Essential javascripts for application to work-->
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <!-- The javascript plugin to display page loading on top-->
    <script src="js/plugins/pace.min.js"></script>
    <!-- Page specific javascripts-->
    <script type="text/javascript" src="js/plugins/chart.js"></script>
    <script type="text/javascript">
      var data = {
      	labels: ["January", "February", "March", "April", "May"],
      	datasets: [
      		{
      			label: "My First dataset",
      			fillColor: "rgba(220,220,220,0.2)",
      			strokeColor: "rgba(220,220,220,1)",
      			pointColor: "rgba(220,220,220,1)",
      			pointStrokeColor: "#fff",
      			pointHighlightFill: "#fff",
      			pointHighlightStroke: "rgba(220,220,220,1)",
      			data: [65, 59, 80, 81, 56]
      		},
      		{
      			label: "My Second dataset",
      			fillColor: "rgba(151,187,205,0.2)",
      			strokeColor: "rgba(151,187,205,1)",
      			pointColor: "rgba(151,187,205,1)",
      			pointStrokeColor: "#fff",
      			pointHighlightFill: "#fff",
      			pointHighlightStroke: "rgba(151,187,205,1)",
      			data: [28, 48, 40, 19, 86]
      		}
      	]
      };
      var pdata = [
      	{
      		value: 300,
      		color: "#46BFBD",
      		highlight: "#5AD3D1",
      		label: "Complete"
      	},
      	{
      		value: 50,
      		color:"#F7464A",
      		highlight: "#FF5A5E",
      		label: "In-Progress"
      	}
      ]

      var ctxl = $("#lineChartDemo").get(0).getContext("2d");
      var lineChart = new Chart(ctxl).Line(data);

      var ctxp = $("#pieChartDemo").get(0).getContext("2d");
      var pieChart = new Chart(ctxp).Pie(pdata);
    </script>
    <!-- Google analytics script-->
    <div class="app-content">
    	<!-- 引入页面 -->
    	<iframe id="main" name="ifd" src="" onload="this.height=this.contentWindow.document.body.scrollHeight" width="100%" scrolling="no" frameborder="0"></iframe>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" name="id" id="id" value="${userInfo.id}">
                <input type="hidden" name="oldPwd" id="oldPwd" value="${userInfo.password}">
                用户名：<input type="text" name="name" id="name" value="${userInfo.username}" readonly>
            </div>
            <div class="modal-body">
                原密码：<input type="password" name="oldpassword" id="oldpassword">
            </div>
            <div class="modal-body">
                新密码：<input type="password" name="newpassword" id="newpassword">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onClick="updatePassword()">提交更改</button>
                <button type="button" class="btn btn-default" data-dismiss="modal" id="mexit">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

    <script type="text/javascript">
      /* if(document.location.hostname == 'pratikborsadiya.in') {
      	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      	ga('create', 'UA-72504830-1', 'auto');
      	ga('send', 'pageview');
      }*/
      window.onload = function() {
    	  // alert($("#userid").val());
    	  // alert(isEmpty($("#userid").val()));
    	  // alert($("#role").val()!="经理");
 	      if (isEmpty($("#userid").val())) {
    		  document.getElementById("signintext").innerHTML = "签到";
 	    	  javascript: changeMenu('findStaff.st');
 	      }
 	      if ($("#role").val()!="经理") {
 	    	  var demo1 = document.getElementById('staffMange'); // 找到元素
 	    	  demo1.style.display = "none"; // 改变样式
 	    	  var demo2 = document.getElementById('checkMange');
	    	  demo2.style.display = "none";
	    	  var demo3 = document.getElementById('infoMange');
 	    	  demo3.style.display = "none";
 	      }
      }
      function signin() {
    	  if (isEmpty($("#userid").val())) { // 未登录
    		  alert("请先登录");
  	      } else if ($("#checkstatus").val()=="未签到") { // 未签到
  	    	  window.location.href="signin.sign";
			  alert("签到成功");
  	      	  window.location.href="index";
			  // document.getElementById("signintext").innerHTML = "已签到";
		  } else { // 已签到
		      alert("您已签到");
		  }
      }
      function changeMenu(menuName) {
          document.getElementById("main").src = menuName;
          window.location.href='#main';
      }
      function changePassword(id) {
    	  if (isNaN(id)) {
    		  alert("请先注册");
    		  return;
    	  }
	      // 打开模态框
          $('#myModal').modal();
          // 设置模态框居中
          $('#myModal').on('show.bs.modai', function(){
        	 var $this = $(this);
        	 var $modai_dialog = $this.find('.modai-dailog');
        	 // 设置为块inline元素
        	 $this.css('display', 'block');
        	 //$modai_dialog.css('margin-top': Math.max(0, ($(window.parent).height() - $modai_dialog.)) 'block');
          });
   	  }
      function updatePassword() {
    	  if ($("#oldpassword").val()!=$("#oldPwd").val())
       	  {
    		  alert("原密码错误！");
       	  	//alert("新密码不能为空，请输入");
       	  } else {
       		$.ajax({
      			type: "post", // 方法类型
      			url: "changePassword.user", // url
      			cache: false,
      			data: {
      				"id": $("#id").val(), // 增加没有id
      				"newpassword": $("#newpassword").val(),
      			},
      			dataType: "text", // 数据；类型	string json xml
      			// 回调方法
      			success: function(data) {
      				if (data=="no") {
      					alert("修改失败");
      				} else {
      				    alert("修改成功");
      				    window.location.href='index';
      					//location.reload(); // 刷新
      				}
      			},
      			error: function() {
      				alert("请求失败！");
      			}
      		});
       	  }
      }
      function quit() {
      	if (isEmpty($("#userid").val())) {
      		window.location.href='login.jsp';
      	} else {
      		window.location.href='quit.user';
      	}
      }
	  function search() {
		  var sc = "https://www.baidu.com/s?wd=";
		  var wd = document.getElementById("wd").value;
		  window.location.href = sc + wd;
	  }
		// 判空函数
		// https://blog.csdn.net/qq_36150631/article/details/94553703
		function isEmpty(v) {
		    switch (typeof v) {
		    case 'undefined':
		        return true;
		    case 'string':
		        if (v.replace(/(^[ \t\n\r]*)|([ \t\n\r]*$)/g, '').length == 0) return true;
		        break;
		    case 'boolean':
		        if (!v) return true;
		        break;
		    case 'number':
		        if (0 === v || isNaN(v)) return true;
		        break;
		    case 'object':
		        if (null === v || v.length === 0) return true;
		        for (var i in v) {
		            return false;
		        }
		        return true;
		    }
		    return false;
		}
    </script>
  </body>
</html>