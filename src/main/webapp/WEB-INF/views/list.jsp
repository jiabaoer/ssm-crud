<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- 引入样式 -->
<link rel="stylesheet" type="text/css"
	href="${APP_PATH }/statis/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script src="${APP_PATH }/statis/js/jquery-1.4.2.min.js"></script>
<script
	src="${APP_PATH }/statis/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!--标题-->
		<div class="page-header ">
			<h1 class="active">
				家宝网&nbsp;<small>jiabaor.com</small>
			</h1>
		</div>
		<!--按钮-->
		<div class="row">
			<div class="col-md-2 col-md-offset-10">
				<button class="btn btn-primary btn-block">新增</button>
				<button class="btn btn-danger btn-block">删除</button>
			</div>
		</div>
		<!--显示表格数据-->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover table-striped">
					<tr class="active">
						<th>ID</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
					<tr class="success">
						<td>${emp.empId }</td>
						<td>${emp.empName }</td>
						<td>${emp.gender=="M"?"男":"女" }</td>
						<td>${emp.email }</td>
						<td>${emp.department.deptName }</td>
						<td>
							<button class="btn btn-primary">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								编辑
							</button>
							<button class="btn btn-danger">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除
							</button>
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!--显示分页信息-->
		<div class="row">
			<!--分页文字信息-->
			<div class="col-md-3">
			当前第${pageInfo.pageNum }页,
			总共${pageInfo.pages }页,
			总共${pageInfo.total }条记录
			</div>
			<!--分页条信息-->
			<div class="col-md-offset-7">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<c:if test="${pageInfo.pageNum==1 }">
						<li class="disabled"><a href="#">首页</a></li>
						</c:if>
						<c:if test="${pageInfo.pageNum!=1 }">
						<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.prePage}" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						</c:if>
						<c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
							<c:if test="${page_Num==pageInfo.pageNum }">
								<li class="active"><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
							</c:if>
							<c:if test="${page_Num!=pageInfo.pageNum }">
								<li><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pageInfo.pageNum==pageInfo.pages }">
						<li class="disabled"><a href="#">末页</a></li>
						</c:if>
						<c:if test="${pageInfo.pageNum!=pageInfo.pages }">
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.nextPage}" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>