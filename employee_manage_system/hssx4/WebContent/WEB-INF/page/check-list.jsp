<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>考勤管理</title>
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
			<h2>考勤管理</h2>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item active"><a href="javasrcipt:window.location.href='findStatus.us'">考勤管理</a></li>
		</ul>
	</div>
	<div class="row">
	    <div class="col-md-12">
			<button class="btn btn-success btn-sm" type="button" onclick="outUserStatus()">发布</button>
			<button class="btn btn-info btn-sm" type="button" onclick="offUserStatus()">结束</button>
			<input type="hidden" id="checkstatus1" name="checkstatus1" value="未签到" >
			<input type="hidden" id="checkstatus2" name="checkstatus2" value="旷工" >
			<input type="hidden" id="checkstatus3" name="checkstatus3" value="已签到" >
			<!-- <button class="btn btn-info" style="margin-left: 235px;"
				type="button" onclick="addType()">录入数据</button>
			<button class="btn btn-success" type="button">导入数据</button>
			<button class="btn btn-success" type="button">导出数据</button> -->
		</div>

		<div class="col-md-12">
			<div class="tile">
				<div class="tile-body">
					<table class="table table-hover table-bordered" id="sampleTable">
						<thead>
							<tr>
								<th>员工编号</th>
								<th>签到状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<!-- el表达式-->
							<!-- varStatus  var的下标序号 -->
							<c:forEach items="${list}" var="us" varStatus="s">
								<tr>
									<%-- <td>${s.count}</td> --%>
									<td>${us.staffid}</td>
									<td>${us.checkstatus}</td>
									<td>
										<button class="btn btn-success" type="button"
											onclick="window.location.href='updateUserStatus.ck?staffid='+${us.staffid}">修改</button>
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
	<script type="text/javascript">
	function outUserStatus()
	{
		if(confirm("确认要发布签到吗？"))
			{
			var checkstatus1 = $("#checkstatus1").val();
			$.ajax({
				type: "post",
				url: "outUserStatus.ck",
				data: { "checkstatus":checkstatus1},
				// 回调方法
				success: function(data) {
					if (data=="no") {
						alert("发布签到失败");
					} else {
						// alert("修改成功");
						alert("发布签到成功！");
						location.reload();
					}
				},
				error: function() {
					alert("异常！");
				}
			});
			
			}else
				{return;}
	}
	</script>
	<script type="text/javascript">
	function offUserStatus()
	{
		if(confirm("确认要结束签到吗？"))
			{
			var checkstatus2 = $("#checkstatus2").val();
			var checkstatus3 = $("#checkstatus3").val();
			$.ajax({
				type: "post",
				url: "offUserStatus.ck",
				data: { "checkstatus1":checkstatus2,
					"checkstatus2":checkstatus3,
				},
				// 回调方法
				success: function(data) {
					if (data=="no") {
						alert("结束签到失败");
					} else {
						// alert("修改成功");
						alert("结束签到成功！");
						location.reload();
					}
				},
				error: function() {
					alert("异常！");
				}
			});
			
			}else
				{return;}
	}
	</script>
</body>
</html>