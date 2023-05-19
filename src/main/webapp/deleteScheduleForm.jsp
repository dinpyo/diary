<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 유효성 검사
	if(request.getParameter("scheduleNo") == null
		|| request.getParameter("scheduleNo").equals("")) {// null이거나 공백이면 코드 종료 후 이동
		response.sendRedirect("scheduleListByDate.jsp");
		return; // <-- 코드 종료하기 위해서 사용
	}
	
	// 받아온 값을 변수에 저장
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	System.out.println(scheduleNo + " <-- deleteScheduleForm scheduleNo");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div style="text-align: center">
<h1>스케줄 삭제</h1>
</div>
   <form action="./deleteScheduleAction.jsp" method="post">
      <table class="table">
         <tr class="table-primary">
            <th>스케줄 등록번호</th>
            <td>
               <input type="text" name="scheduleNo" value="<%=scheduleNo%>" readonly="readonly">
            </td>
         </tr>
         <tr class="table-success">
            <th>스케줄 비밀번호</th>
            <td>
               <input type="password" name="schedulePw">
            </td>
         </tr>
         <tr class="table-danger">
            <td colspan="2">
               <button type="submit" class="btn btn-secondary">삭제</button>
            </td>
         </tr>
      </table>
   </form>
</body>
</html>