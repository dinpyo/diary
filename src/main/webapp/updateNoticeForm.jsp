<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>

<%

	// 유효성 검사   
	if(request.getParameter("noticeNo")==null) {
	   response.sendRedirect("./noticeList.jsp");
  	   return; 
	}

	// 받아온 값을 변수에 저장
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
 	Class.forName("org.mariadb.jdbc.Driver");
 	Connection conn = DriverManager.getConnection(
         "jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
   /*
      select notice_no, notice_title, notice_content, notice_writer, createdate, updatedate 
      from notice 
      where notice_no = ?
   */
   String sql = "select notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, notice_writer noticeWriter, createdate, updatedate from notice where notice_no = ?";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setInt(1, noticeNo);
   System.out.println(stmt + " <-- stmt");
   ResultSet rs = stmt.executeQuery();      
   
	// 일반적인 자료구조타입으로 바꾸기
   ArrayList<Notice> noticeList = new ArrayList<Notice>();
   while(rs.next()) {
      Notice n = new Notice();
      n.noticeNo = rs.getInt("noticeNo");
      n.noticeTitle = rs.getString("noticeTitle");
      n.noticeContent = rs.getString("noticeContent");
      n.noticeWriter = rs.getString("noticeWriter");
      n.createdate = rs.getString("createdate");
      n.updatedate = rs.getString("updatedate");
      noticeList.add(n);
   }
  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div style="text-align: center">
	<h1>공지 수정</h1>
	</div>
	<div>
		<%
			if(request.getParameter("msg") != null) {
				
		%>	
			<%=request.getParameter("msg")%>
		<% 		
			}
		%>
	</div>
   <form action="./updateNoticeAction.jsp" method="post"> 
      <table class="table">
      	<%
      		for(Notice n : noticeList) {
		%>
         <tr class="table-primary">
            <td>
               공지 등록 번호
            </td>
            <td>
               <input type="number" name="noticeNo" 
                  value="<%=n.noticeNo%>" readonly="readonly"> 
            </td>
         </tr >
         <tr class="table-success">
            <td>
               공지 비밀번호
            </td>
            <td>
               <input type="password" name="noticePw"> 
            </td>
         </tr>
         <tr class="table-danger">
            <td>
               공지 이름
            </td>
            <td>
               <input type="text" name="noticeTitle" 
                  value="<%=n.noticeTitle%>"> 
            </td>
         </tr>
         <tr class="table-warning">
            <td>
               공지 내용
            </td>
            <td>
               <textarea rows="5" cols="80" name="noticeContent">
                  <%=n.noticeContent%>
               </textarea>
            </td>
         </tr>
         <tr class="table-active">
            <td>
               공지 작성자
            </td>
            <td>
               <%=n.noticeWriter%>
            </td>
         </tr>
         <tr class="table-info">
            <td>
               생성일
            </td>
            <td>
               <%=n.createdate%>
            </td>
         </tr>
         <tr class="table-info">
            <td>
               수정일
            </td>
            <td>
               <%=n.updatedate%>
            </td>
         </tr>
      </table>
      <% } %>
      <div>
      	<button type="submit" class="btn btn-secondary">수정</button>
      </div>
   </form>
</body>
</html>