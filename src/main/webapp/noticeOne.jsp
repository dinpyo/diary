<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>

<%   
	// 유효성 검사
	if(request.getParameter("noticeNo")==null) {
		response.sendRedirect("./noticeList.jsp");
		//나중에 응답할 내용을 공유:response
		return; //1) 코드진행종료 2) 반환값을 남길때 
	}
    
	// 받아온 값은 변수에 저장
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
   
	//	db 연결
	Class.forName("org.mariadb.jdbc.Driver"); //드라이버 부르기
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "select notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, notice_writer noticeWriter, createdate, updatedate from notice where notice_no=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// ? 값 설정
	stmt.setInt(1, noticeNo);	//stmt에 첫번째 ? 값을 noticeNo로 바꿀것이다 //String값일 경우 작은 따옴표도 출시
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + "<-- rs확인");
	
	// 일반적인 자료구조타입으로 바꾸기
   	// ResultSet -> ArrayList< > 로 변경
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
<title>Insert title here</title>
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
	<h1>공지 상세 설명</h1>
</div>
<%
	for(Notice n : noticeList) {
%>
         
<table class="table">
	<tr class="table-primary">
		<td>공지 번호</td>
		<td><%=n.noticeNo%></td>
	</tr>
	<tr class="table-success">
		<td>공지 이름</td>
		<td><%=n.noticeTitle%></td>
	</tr>
	<tr class="table-danger">
		<td>공지 내용</td>
		<td><%=n.noticeContent%></td>
	</tr>
	<tr class="table-warning">
		<td>공지 작성자</td>
		<td><%=n.noticeWriter%></td>
	</tr>
	<tr class="table-active">
		<td>생성일</td>
		<td><%=n.createdate.substring(0, 10)%></td>
	</tr>
	<tr class="table-info">
		<td>수정일</td>
		<td><%=n.updatedate.substring(0, 10)%></td>
	</tr>
</table>
	<%
		}
	%>
<div>
	<a class="btn btn-secondary" href="./updateNoticeForm.jsp?noticeNo=<%=noticeNo%>">수정</a>
	<a class="btn btn-secondary" href="./deleteNoticeForm.jsp?noticeNo=<%=noticeNo%>">삭제</a>
</div>
</body>
</html>