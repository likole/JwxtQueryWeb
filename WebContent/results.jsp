<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Map" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>查询结果</title>
    <link href="css/bootstrap.css" rel="stylesheet"/>
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
		body{
			padding:30px 0 0 0;
		}
	</style>
  </head>
  <body>
	<div class="container table-responsive">
    	<table class="table table-striped table-hover">
        <thead>
        	<th>课程名</th>
            <th>学分</th>
            <th>分数</th>
            <th>绩点</th>
        </thead>
        <tbody>		
		<%
			List<Map<String,String>> list=(List<Map<String,String>>)request.getAttribute("data");
			for(Map<String,String> map:list){
				System.out.println(map);
		%>
		<tr >
        	<td><%if(map.get("name")!=null){out.print(map.get("name"));} %></td>
            <td><%if(map.get("credit")!=null){out.print(map.get("credit"));} %></td>
            <td><%if(map.get("grade")!=null){out.print(map.get("grade"));} %></td>
            <td><%if(map.get("jd")!=null){out.print(map.get("jd"));} %></td>
        </tr>
        <%}%>  
        </tbody>
        </table> 
    </div>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
  </body>
</html>