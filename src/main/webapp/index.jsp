<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script src="${APP_PATH }/statis/js/jquery-2.1.0.min.js"></script>
<script
	src="${APP_PATH }/statis/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

	<!-- 员工编辑的模态框 -->
	<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="updateForm">
						<div class="form-group">
							<label for="empName_input" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="empName_input" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@jiabaor.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="empName_input" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="empName_input" class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update_select">
									<!-- 部门提交部门id即可 -->
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="addForm" method="post">
						<div class="form-group">
							<label for="empName_input" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_input" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="empName_input" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@jiabaor.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="empName_input" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="empName_input" class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select">
									<!-- 部门提交部门id即可 -->
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">提交</button>
				</div>
			</div>
		</div>
	</div>

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
				<button class="btn btn-primary btn-block" id="emp_add_model_btn">新增</button>
				<button class="btn btn-danger btn-block" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!--显示表格数据-->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover table-striped" id="emps_table">
					<thead>
						<tr class="active">
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>ID</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!--显示分页信息-->
		<div class="row">
			<!--分页文字信息-->
			<div class="col-md-3" id="page_info_area"></div>
			<!--分页条信息-->
			<div class="col-md-offset-7" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord,currentPage;
		//1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
		$(function() {
			//去首页
			to_page(1);
		});
		function to_page(pn) {
			$.ajax({
				//请求路径
				url : "${APP_PATH}/emps",
				//请求要带的数据
				data : "pn=" + pn,
				//请求类型
				type : "GET",
				//请求成功的会调函数
				success : function(result) {
					console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//解析显示分页条
					build_page_nav(result);
				}
			});
		}
		//1.解析并显示员工数据
		function build_emps_table(result) {
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkBoxId=$("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var departmentTd = $("<td></td>").append(
						item.department.deptName);
				var editBtn = $("<button></button>")
						.addClass("btn btn-primary edit_btn").append(
								$("<span></span>").addClass(
										"glyphicon glyphicon-pencil")).append(
								"编辑");
				//为编辑按钮添加一个自定义的属性，来表示当前员工id
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger delete_btn")
						.append(
								$("<span></span>").addClass(
										"glyphicon glyphicon-trash")).append(
								"删除");
				//为删除按钮添加一个自定义属性来表示当前删除的员工id
				delBtn.attr("del-id",item.empId);
				$("<tr></tr>").append(checkBoxId).append(empIdTd).append(empIdTd)
						.append(empNameTd).append(genderTd).append(emailTd)
						.append(departmentTd).append(editBtn).append("&nbsp;")
						.append(delBtn).appendTo("#emps_table tbody");
			});
		}
		//2.解析并显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页, 总共"
							+ result.extend.pageInfo.pages + "页, 总共"
							+ result.extend.pageInfo.total + "条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage=result.extend.pageInfo.pageNum;
		}
		//解析显示分页条
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			//page_nav_area
			var ul = $("<ul></ul>").addClass("pagination");

			//首页
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			firstPageLi.click(function() {
				to_page(1);
			});
			//前一页
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append($("<span></span>").append("&laquo;"))
							.attr("href", "#"));
			prePageLi.click(function() {
				to_page(result.extend.pageInfo.pageNum - 1);
			});
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			//后一页	
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append($("<span></span>").append("&raquo;"))
							.attr("href", "#"));
			nextPageLi.click(function() {
				to_page(result.extend.pageInfo.pageNum + 1);
			});
			//末页
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			lastPageLi.click(function() {
				to_page(result.extend.pageInfo.pages);
			});
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			//添加首页和前一页的提示
			ul.append(firstPageLi).append(prePageLi);
			//1、2、3遍历给ul中添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				})
				ul.append(numLi);
			});
			//添加下一页和末页的提示
			ul.append(nextPageLi).append(lastPageLi);
			//把ul加入到nav元素中
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		//清空表单样式及内容 
		function reset_from(ele) {
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		//点击新增按钮弹出模态框
		$("#emp_add_model_btn").click(function() {
			//清除表单数据(表单完整重置(表单的数据，表单的样式))
			reset_from("#addForm");
			//$("#myform")[0].reset();
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#dept_add_select");
			//弹出模态框
			$("#empAddModel").modal({
				backdrop : "static"
			});
		});
		//查出所有的部门信息并显示在下拉列表中
		function getDepts(ele) {
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//console.log(result);
					//显示部门信息在下拉列表中
					//$("#dept_add_select").
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		//校验表单数据
		function validate_add_form() {
			//1.拿到要校验的数据，使用正则表达式
			var empName = $("#empName_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (!regName.test(empName)) {
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_input", "error",
						"用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			} else {
				show_validate_msg("#empName_input", "success", "");
			}
			//2.校验邮箱信息
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
				return true;
			}
		}
		//显示校验结果的提示信息
		function show_validate_msg(ele, status, msg) {
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		//校验用户名是否可用
		$("#empName_input").blur(
				function() {
					//发送ajax请求校验用户名是否可用
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "empName=" + empName,
						type : "POST",
						success : function(result) {
							if (result.code == 100) {
								show_validate_msg("#empName_input", "success",
										"用户名可用");
								$("#emp_save_btn").attr("ajax-va", "success");
							} else {
								show_validate_msg("#empName_input", "error",
										result.extend.va_msg);
								$("#emp_save_btn").attr("ajax-va", "error");
							}
						}

					});

				});
		$("#emp_save_btn").click(function() {
			//1.模态框中填写的表单数据提交给服务器进行保存
			//1.先对要提交给服务器的数据进行校验
			if (!validate_add_form()) {
				return false;
			};
			//1.判断之前的ajax用户名校验是否成功，如果成功
			if ($(this).attr("ajax-va") == "error") {
				return false;
			}
			//2.发送ajax请求保存员工
			$.ajax({
				url : "${APP_PATH}/emp",
				type : "POST",
				data : $("#addForm").serialize(),
				success : function(result) {
					//alert(result.msg);
					if (result.code == 100) {
						//员工保存成功
						//1.关闭模态框
						$("#empAddModel").modal("hide");
						//2.来到最后一页，显示刚才保存的数据
						//发送ajax请求显示最后一页数据即可
						to_page(totalRecord);
					} else {
						//显示失败信息
						//console.log(result);
						//有那个字段的错误信息就显示那个字段
						if (undefined != result.extend.errorFirlds.email) {
							//显示邮箱错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFirlds.email);
						}
						if (undefined != result.extend.errorFirlds.empName) {
							//显示员工的错误信息
							show_validate_msg("#empName_input","error",result.extend.errorFirlds.empName);
						}
					}
				}
			})
		});
		
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			//1.校验邮箱信息
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "");
			}
			//2.发送ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#updateForm").serialize(),
				success:function(result){
					//alert(result.msg);
					//关闭对话框
					$("#empUpdateModel").modal("hide");
					//回到本页面
					to_page(currentPage);
				}
			});
		});
		
		$(document).on("click",".edit_btn",function(){
			//alert("asd");
			reset_from("#updateForm");
			//1.查出部门信息，并显示部门列表
			getDepts("#dept_update_select");
			//0.查出员工信息，显示员工信息
			getEmp($(this).attr("edit-id"))
			//3、把员工的id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModel").modal({
				backdrop : "static"
			});
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData=result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModel input[name=gender]").val([empData.gender]);
					$("#empUpdateModel select").val([empData.dId]);
				}
			});
		}

		//根据id单个删除
		$(document).on("click",".delete_btn",function(){
			//弹出是否确认删除对话框
			var empName=$(this).parents("tr").find("td:eq(2)").text();
			var empId=$(this).attr("del-id");
			//alert($(this).parents("tr").find("td:eq(1)").text());
			if (confirm("确认删除【"+empName+"】吗？")) {
				//确认，发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页面
						to_page(currentPage);
					}
				});
			}
		});
		
		//完成全选。全不选功能
		$("#check_all").click(function(){
			//attr获取checked是undefind
			//我们这些dom原生的属性；attr获取自定义属性的值
			//prop修改和读取dom原生的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		$(document).on("click",".check_item",function(){
			//判断当前选择中的元素是否是5个
			var flag=$(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，就批量删除
		$("#emp_delete_all_btn").click(function(){
			var empNames="";
			var del_idstr="";
			$.each($(".check_item:checked"),function(){
				empNames +=$(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-"
			});
			//去除empNames多余的，
			empNames=empNames.substring(0,empNames.length-1);
			//去除del_idstr多余的-
			del_idstr=del_idstr.substring(0,del_idstr.length-1);
			if (confirm("确认删除【"+empNames+"】吗？")) {
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>