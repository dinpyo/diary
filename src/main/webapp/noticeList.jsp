<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>

<%
	// 요청 분석(currentPage, ....)
	// 현재페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <--currentPage");
   
	// 페이지당 출력할 행의 수
	int rowPerPage = 10;
   
	// 시작 행번호
	int startRow = (currentPage-1)*rowPerPage;
	/*
		< 규칙 찾기 >  
      currentPage      startRow(rowPerPage 10일때)   
      1            0   <-- (currentPage-1)*rowPerPage
      2            10
      3            20
      4            30
	*/

	// DB연결 설정  
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
         "jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	PreparedStatement stmt = conn.prepareStatement("select notice_no noticeNo, notice_title noticeTitle, createdate from notice order by createdate desc limit ?, ?"); // 
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	System.out.println(stmt + " <-- stmt");
   
	// 출력할 공지 데이터
	ResultSet rs = stmt.executeQuery();   
	// 자료구조 ResultSet타입을 일반적인 자료구조타입(자바 배열 or 기본API 자료구조타입 List, Set, Map)
	// ResultSet -> ArrayList<Notice>
	ArrayList<Notice> noticeList = new ArrayList<Notice>();
	while(rs.next()) {
		Notice n = new Notice();
		n.noticeNo = rs.getInt("noticeNo");
		n.noticeTitle = rs.getString("noticeTitle");
		n.createdate = rs.getString("createdate");
		noticeList.add(n);
	}
   
	// 마지막 페이지
	// select count(*) from notice
	PreparedStatement stmt2 = conn.prepareStatement("select count(*) from notice");
	ResultSet rs2 = stmt2.executeQuery();
	int totalRow = 0; // SELECT COUNT(*) FROM notice;
	if(rs2.next()) {
		totalRow = rs2.getInt("count(*)");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
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
   <div ><!-- 메인메뉴 -->
      <a class="btn btn-secondary" href="./home.jsp">홈으로</a>
      <a class="btn btn-secondary" href="./noticeList.jsp">공지 리스트</a>
      <a class="btn btn-secondary" href="./scheduleList.jsp">일정 리스트</a>
   </div>
   <!-- 날짜순 최근 공지 5개 -->
   <div style="text-align: center">
   <h1>공지사항 리스트</h1>
   </div>
   <a class="btn btn-secondary" href="./insertNoticeForm.jsp">공지추가</a>
   
   <table class="table">
      <tr class="table-info">
         <th>공지 이름</th>
         <th>생성날짜</th>
      </tr>
      <%
      	//	for each 문 사용
		for(Notice n : noticeList) {
      %>
         <tr class="table-warning">
            <td>
               <a href="./noticeOne.jsp?noticeNo=<%=n.noticeNo%>">
                  <%=n.noticeTitle%>
               </a>
            </td>
            <td><%=n.createdate.substring(0, 10)%></td>
         </tr>
      <%      
         }
      
      %>
   </table>
   <div style="text-align: center">
   <%
      if(currentPage > 1) {
   %>
         <a  class="btn btn-secondary" href="./noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
   <%      
      }
   %>
         <%=currentPage%>
   <%   
      if(currentPage < lastPage) {   
   %>
         <a  class="btn btn-secondary" href="./noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
   <%
      }
   %>
   </div>
</body>
</html>