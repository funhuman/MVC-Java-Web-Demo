<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工信息管理</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
<style type="text/css">
body{
	padding:20px;
}

</style>
</head>
<body>
	<div class="app-title">
		<div>
			<h2>员工信息管理</h2>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item active"><a href="#">员工信息</a></li>
		</ul>
	</div>
	<div class="row">
		<div class="col-md-12">
			用户名：<input class="form-control" id="selectName" type="text" value="${selectName}" style="display: inline; width: 12%; height: 32px;">
			&nbsp;手机号码：<input class="form-control" id="selectPhone" type="text" value="${selectPhone}" style="display: inline; width: 12%; height: 32px;">
			<button class="btn btn-success" type="button" onclick="javascript:window.location.href='findStaff.st'" style="margin:0 10px 5px 20px; width: 100px;">查询全部</button>
			<button class="btn btn-success" type="button" onclick="selectStaff2()" style="margin:0 10px 5px 10px; width: 100px;">精确查询</button>
			<button class="btn btn-success" type="button" onclick="selectStaff()" style="margin:0 10px 5px 10px; width: 100px;">模糊查询</button>
			<button class="btn btn-primary" type="button" onclick="javascript:window.location.href='addStaff.st'" style="margin:0 10px 5px 10px; width: 100px;">添加</button>
			<!-- <button class="btn btn-info" style="margin-left: 235px;"
				type="button" onclick="addType()">录入数据</button>
			<button class="btn btn-success" type="button">导入数据</button>
			<button class="btn btn-success" type="button">导出数据</button> -->
		</div>
		<br />
		<div class="col-md-12">
			<div class="tile">
				<div class="tile-body">
					<table class="table table-hover table-bordered" id="sampleTable" style="text-align: center; vertical-align:middle; line-height: 40px;">
						<thead>
							<tr>
								<th>序号</th>
								<th>登录名</th>
								<th>姓名</th>
								<th>手机号码</th>
								<th>性别</th>
							    <th>年龄</th>
								<th>角色</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<!-- el表达式-->
							<!-- varStatus  var的下标序号 -->
							<c:forEach items="${list}" var="st" varStatus="s">
								<tr>
									<td>${s.count}</td>
									<td>${st.username}</td>
									<td>${st.name}</td>
									<td>${st.phone}</td>
									<td>${st.sex}</td>
									<td>${st.age}</td>
									<td>${st.role}</td>
									<td>
										<button class="btn btn-success" type="button"
											onclick="javascript:window.location.href='modStaff.st?id='+${st.id}">修改</button>
										<button class="btn btn-danger" type="button" onclick="del(${st.id})">删除</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
				    </table>
					<!-- 生成分页工具栏 -->
				<!-- 	<p:page action="typeList.do" /> -->
				</div>
			</div>
		</div>
	</div>



	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
	<script text="text/javascript">
	function changeMenu(menuName) {
    	  //alert(menuName);
          document.getElementById("main").src = menuName;
    }
	
	function del(id) {
		if (confirm("确定要删除吗？")) {
			$.ajax({
				type: "post", // 方法类型
				url: "delStudent.st", // url
				data: {id: id},
				// 回调方法
				success: function(data) {
					if (data=="no") {
						alert("删除失败");
					} else {
						// alert("删除成功");
						location.reload(); // 刷新
					}
				},
				error: function() {
					alert("异常请求！");
				}
			});
		}
	}

	function isnoabcnum(str) {
	  var pattern = new RegExp("[a-z0-9]+");
	  if(pattern.test(str)){
	    return false;
	  } else {
	    return true;
	  }
	}
	
	function selectStaff() {
		var selectName=$("#selectName").val();
		var selectPhone=$("#selectPhone").val();
		if (isnoabcnum(selectName) && !isEmpty(selectName)) {
			alert("请输入小写字母和数字的用户名");
			return;
		}
		if (isNaN(selectPhone) && !isEmpty(selectPhone)) {
			alert("请输入数字的手机号");
			return;
		}
		//alert("模糊查询" + selectName + " " + selectPhone);
		window.location.href='findStaff.st?mode=like&selectName='+selectName+'&selectPhone='+selectPhone;
	}
	
	function selectStaff2() {
		var selectName=$("#selectName").val();
		var selectPhone=$("#selectPhone").val();
		if (isnoabcnum(selectName) && !isEmpty(selectName)) {
			alert("请输入小写字母和数字的用户名");
			return;
		}
		if (isNaN(selectPhone) && !isEmpty(selectPhone)) {
			alert("请输入数字的手机号");
			return;
		}
		//alert("精确查询" + selectName + " " + selectPhone);
		window.location.href='findStaff.st?selectName='+selectName+'&selectPhone='+selectPhone;
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