<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>

<%
	//y,m,d 값이 null or "'-> redrection
	// 유효성 검사
	if(request.getParameter("y")==null
		||request.getParameter("m")==null
		||request.getParameter("d")==null
		||request.getParameter("y").equals("")
		||request.getParameter("m").equals("")
		||request.getParameter("d").equals("")){
      
		response.sendRedirect("./scheduleList.jsp");
		return;	//<-- 코드 종료하기 위해서 사용 
	}
      
	// 받아온 문자를 정수로 변화 후 변수에 저장
	int y = Integer.parseInt(request.getParameter("y"));
	//자바 API 12월은 11이다, 마리아DB에서는 12월은 12이다
	int m = Integer.parseInt(request.getParameter("m"))+1;
	int d = Integer.parseInt(request.getParameter("d"));
   
	System.out.println(y + "<-- y");
	System.out.println(m + "<-- m");
	System.out.println(d + "<-- d");
   
	// 값이 안넘어오는걸 방지 하기 위해서 문자와 값을 더해서 문자로 만듬
	String strM = m+"";
	if(m<10){
      strM = "0"+strM;
	}
	String strD = d+"";
	if(d<10){
      strD = "0"+strD;
	}
   
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	//sql구문
	String sql = "select schedule_no scheduleNo, schedule_date scheduleDate, schedule_time scheduleTime, schedule_memo scheduleMemo, schedule_color scheduleColor,  createdate, updatedate from schedule where schedule_date=? order by schedule_time ASC";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// ? 값 설정
	stmt.setString(1,y+"-"+m+"-"+d);
   
	// 출력할 데이터 확인
	ResultSet rs = stmt.executeQuery();
	
	// 일반적인 자료구조타입으로 바꾸기
	// ResultSet - > ArrayList<Schedule> 
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
	while(rs.next()){
		Schedule s = new Schedule();
		s.scheduleNo = rs.getInt("scheduleNo");
		s.scheduleDate = rs.getString("scheduleDate");
		s.scheduleTime = rs.getString("scheduleTime");
		s.scheduleMemo = rs.getString("scheduleMemo");
		s.scheduleColor = rs.getString("scheduleColor");
		s.createdate = rs.getString("createdate");
		s.updatedate = rs.getString("updatedate");
		scheduleList.add(s);
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
<a href="./scheduleList.jsp" class="btn btn-secondary">홈으로</a>
<div style="text-align: center">
	<h1>스케줄 입력</h1>
</div>
<form action="./insertScheduleAction.jsp" method="post">
	<table class="table" style="width: 90%;">
		<tr class="table-primary">
			<th>스케줄 날짜</th>
			<td>
				<input type="date" name="scheduleDate"
				value="<%=y%>-<%=strM%>-<%=strD%>" 
				readonly="readonly">
			</td>
		</tr>
		<tr class="table-success">
            <th>스케줄 비밀번호</th>
			<td>
				<input type="password" 
				name="schedulePw">
			</td>
		</tr>
         <tr class="table-danger">
			<th>스케줄 시간</th>
            <td>
				<input type="time" 
				name="scheduleTime">
			</td>
		</tr>
		<tr class="table-warning">
			<th>스케줄 색상</th>
			<td>
				<input type="color" 
				value="#000000" 
				name="scheduleColor">
			</td>
		</tr>
		<tr class="table-active">
			<th>스케줄 메모</th>
			<td>
				<textarea rows="3" cols="80" name="scheduleMemo"></textarea>
			</td>
		</tr>
		<tr class="table-info">
			<td colspan="2">
				<button class="btn btn-secondary" type="submit">추가</button>
			</td>
		</tr>
	</table>
</form>
<div style="text-align: center">
	<h1><%=y %>년<%=m %>월<%=d %>일 스케줄 목록</h1>
</div>
	<%
   		// for each 문 사용
		for(Schedule s : scheduleList){
	%>
		<table class="table" style="width: 90%;">
			<tr class="table-primary">
				<th style="width: 20%;">schedule_no</th>
				<td><%=s.scheduleNo%></td>
			</tr>
			<tr class="table-success">
				<th>스케줄 날짜</th>
				<td><%=s.scheduleDate%></td>
			</tr>
			<tr class="table-danger">
				<th>스케줄 시간</th>
				<td><%=s.scheduleTime%></td>
			</tr>
			<tr class="table-warning">
				<th>스케줄 메모</th>
				<td><%=s.scheduleMemo %></td>
			</tr>
			<tr class="table-active">
				<th>스케줄 색상</th>
				<td><%=s.scheduleColor%></td>
			</tr>
			<tr class="table-info">
				<th>생성일</th>
				<td><%=s.createdate %></td>
			</tr>
			<tr class="table-info">
				<th>수정일</th>
				<td><%=s.updatedate%></td>
			</tr>
			<tr>
				<td colspan="2">
					<a class="btn btn-secondary" href="./updateScheduleForm.jsp?scheduleNo=<%=s.scheduleNo%>">수정</a>
					<a class="btn btn-secondary" href="./deleteScheduleForm.jsp?scheduleNo=<%=s.scheduleNo%>">삭제</a>
				</td>
			</tr>
	</table>
	<br>
	<%
		}
	%>

</body>
</html>