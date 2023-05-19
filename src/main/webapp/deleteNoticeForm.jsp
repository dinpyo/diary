<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   // 유효성 검사
	if(request.getParameter("noticeNo") == null
		|| request.getParameter("noticeNo").equals("")) { // null이나 공백이면 코드 종료후 이동
		response.sendRedirect("./noticeList.jsp");
		return; // 코드 종료하기 위해서 사용
	}
   
	// 받아온 값을 변수에 저장
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo + " <-- deleteNoticeForm noticeNo");
   
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
   	<h1>공지 삭제</h1>
	</div>
   	<form action="./deleteNoticeAction.jsp" method="post">
    <table class="table">
         <tr class="table-primary">
            <td>공지 등록 번호</td>
            <td>
               <input type="text" name="noticeNo" value="<%=noticeNo%>" readonly="readonly">
            </td>
         </tr>
         <tr class="table-success">
            <td>공지 비밀번호</td>
            <td>
               <input type="password" name="noticePw">
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