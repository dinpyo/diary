<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertNoticeForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
   <div><!-- 메인메뉴 -->
      <a class="btn btn-secondary" href="./home.jsp">홈으로</a>
      <a class="btn btn-secondary" href="./noticeList.jsp">공지 리스트</a>
      <a class="btn btn-secondary" href="./scheduleList.jsp">일정 리스트</a>
   </div>
   <div style="text-align: center">
   <h1>공지 입력</h1>
   </div>
   <form action="./insertNoticeAction.jsp" method="post">
      <table class="table">
         <tr class="table-primary">
            <td>공지 이름</td>
            <td>
               <input type="text" name="noticeTitle">
            </td>
         </tr>
         <tr class="table-success">
            <td>공지 내용</td>
            <td>
               <textarea rows="5" cols="80" name="noticeContent"></textarea>
            </td>
         </tr>
         <tr class="table-danger">
            <td>공지 작성자</td>
            <td>
               <input type="text" name="noticeWriter">
            </td>
         </tr>
         <tr class="table-warning">
            <td>공지 비밀번호</td>
            <td>
               <input type="password" name="noticePw">
            </td>
         </tr>
         <tr class="table-active">
            <td colspan="2">
               <button type="submit">입력</button>
            </td>
         </tr>
      </table>
   </form>
</body>
</html>