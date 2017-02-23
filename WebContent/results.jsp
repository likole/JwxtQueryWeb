<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page
	import="java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Map"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>查询结果</title>
<link href="css/bootstrap.css" rel="stylesheet" />
<style>
table.tablesorter thead tr .header {
	background-image: url(images/bg.gif);
	background-repeat: no-repeat;
	background-position: center right;
	cursor: pointer;
}

table.tablesorter thead tr .headerSortUp {
	background-image: url(images/asc.gif);
}

table.tablesorter thead tr .headerSortDown {
	background-image: url(images/desc.gif);
}

@media screen and (max-width: 767px) {
	.td-responsive {
		max-width: 200px;
		text-overflow: ellipsis;
		-o-text-overflow: ellipsis;
		overflow: hidden;
	}
}
</style>
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar-collapse-1"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">教务系统成绩查询</a>
			</div>
			<div class="collapse navbar-collapse" id="navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="index.jsp">首页</a></li>
					<li class="active"><a>查询结果</a></li>
					<li><a href="res/JwxtQuery.apk">Android版下载</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a><small>V1.0.0</small></a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="container" style="margin-top: 72px">
		<!-- 		<div class="alert alert-info alert-dismissable">
			<button type="button" class="close" data-dismiss="alert"
				aria-hidden="true">&times;</button>
			点击表格标题可进行排序
		</div> -->
		<div class="alert alert-info"><%=request.getAttribute("info")%></div>
	</div>
	<div class="container table-responsive">
		<table id="results"
			class="table table-striped table-hover table-bordered tablesorter">
			<thead>
				<th>课程名&nbsp;&nbsp;&nbsp;</th>
				<th>学分&nbsp;&nbsp;&nbsp;</th>
				<th>分数&nbsp;&nbsp;&nbsp;</th>
				<th>绩点&nbsp;&nbsp;&nbsp;</th>
			</thead>
			<tbody>
				<%
					List<Map<String, String>> list = (List<Map<String, String>>) request.getAttribute("data");
					for (Map<String, String> map : list) {
				%>
				<tr
					<%if ("0".equals(map.get("type"))) {
					if (Double.parseDouble(map.get("grade")) < 60) {
						out.print("class='danger'");
					}
					if ("true".equals(map.get("passed")) && "true".equals(map.get("unpassed"))) {
						out.print("class='warning'");
					}
				}%>>
					<td class="td-responsive"
						title="						<%if (map.get("name") != null) {
					out.print(map.get("name"));
				}%>">
						<%
							if (map.get("name") != null) {
									if ("0".equals(map.get("type"))) {
										if (Double.parseDouble(map.get("grade")) < 60) {
											out.print("【尚未及格】");
										}
										if ("true".equals(map.get("passed")) && "true".equals(map.get("unpassed"))) {
											out.print("【曾不及格】 ");
										}
									}
									out.print(map.get("name"));
								}
						%>
					</td>
					<td>
						<%
							if (map.get("credit") != null) {
									out.print(map.get("credit"));
								}
						%>
					</td>
					<td>
						<%
							if (map.get("grade") != null) {
									out.print(map.get("grade"));
								}
						%>
					</td>
					<td>
						<%
							if (map.get("jd") != null) {
									out.print(map.get("jd"));
								}
						%>
					</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/jquery.tablesorter.min.js"></script>
	<script>
		$(function() {
			$("#results").tablesorter();
		});
	</script>
</body>
</html>