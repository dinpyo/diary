<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>

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
<%
	//db 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
            "jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	System.out.println(conn + "<-- conn 정상");
     
	// 최근 공지 5개만 출력
	String sql1 = "select notice_no noticeNo, notice_title noticeTitle, createdate from notice order by createdate desc limit 0, 5";
	PreparedStatement stmt1 = conn.prepareStatement(sql1); // 
	System.out.println(stmt1 + " <-- stmt1");
	
	// 출력할 데이터 확인
	ResultSet rs1 = stmt1.executeQuery();
	
	// 일반적인 자료구조타입으로 변경
	// ResultSet -> ArrayList< > 로 변경
	ArrayList<Notice> noticeList = new ArrayList<Notice>();
	while(rs1.next()) {
		Notice n = new Notice();
		n.noticeNo = rs1.getInt("noticeNo");
		n.noticeTitle = rs1.getString("noticeTitle");
		n.createdate = rs1.getString("createdate");
		noticeList.add(n);
	}
      
	// 오늘 일정
	String sql2 = "select schedule_no scheduleNo, schedule_date scheduleDate, schedule_time scheduleTime, schedule_memo scheduleMemo from schedule where schedule_date = curdate() order by schedule_time asc";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	System.out.println(stmt2 + " <-- stmt2");
	
	// 출력할 데이터 확인
	ResultSet rs2 = stmt2.executeQuery();
	
	// 일반적인 자료구조타입으로 변경
	// ResultSet -> ArrayList< > 로 변경
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
	while(rs2.next()) {
		Schedule s = new Schedule();
		s.scheduleNo = rs2.getInt("scheduleNo");
		s.scheduleDate = rs2.getString("scheduleDate");
		s.scheduleTime = rs2.getString("scheduleTime");
		s.scheduleMemo = rs2.getString("scheduleMemo");
		scheduleList.add(s);
	}
      
%>
<div style="text-align: center">
	<h1>공지사항</h1>
</div>
<table class="table">
	<tr class="table-info">
		<th>공지 이름</th>
		<th>생성날짜</th>
	</tr>
	<%
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
   
<br>
   
<div style="text-align: center">
	<h1>오늘일정</h1>
</div>   
<table class="table">
	<tr class="table-info">
		<th>스케줄 날짜 </th>
		<th>스케줄 시간</th>
		<th>스케줄 메모</th>
	</tr>
	<%
		// for each 문 사용
		for(Schedule s : scheduleList) {
	%>
	<tr>
		<td>
			<%=s.scheduleDate%>
		</td>
		<td><%=s.scheduleTime%></td>
		<td>
			<a href="./scheduleOne.jsp?scheduleNo=<%=s.scheduleNo%>">
				<%=s.scheduleMemo%>
			</a>
		</td>
		</tr>
	<%   
		}
	%>
</table>
<div style="text-align: center">
<h1>다이어리 프로젝트</h1>
<h4>사용 언어 : HTML, JAVA, SQL, Bootstrap, Maria DB</h4> 
<h4>사용 프로그램 : Eclipse, HeidSQL</h4> 
<h4>
	MariaDB에서 데이터를 가져와 출력하기, CalebdarAPI를 이용하여 달력만들기 
</h4>
</div> 
</body>
</html>