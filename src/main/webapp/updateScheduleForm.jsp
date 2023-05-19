<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
 	// 유효성 검사 
	if(request.getParameter("scheduleNo") == null
		|| request.getParameter("scheduleNo").equals("")) {// null이거나 공백이면 코드 종료 후 이동
		response.sendRedirect("scheduleList.jsp");
		return; //<-- 코드 종료하기 위해서 사용 
	}

   	// 받아온 값을 변수에 저장
 	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
 	System.out.println(scheduleNo + "<-- updateScheduleForm scheduleNo");
   
 	// db 연결
 	Class.forName("org.mariadb.jdbc.Driver");
   	System.out.println("updateScheduleForm 드라이버 연결");
 	Connection conn = DriverManager.getConnection(
 			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
 	System.out.println(conn + "<-- conn 정상");
 	
 	// sql 작성 및 db 변환
  	String sql = "select schedule_no scheduleNo, createdate, updatedate from schedule where schedule_no= ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
   
	// ? 값 설정
	stmt.setInt(1, scheduleNo);
  	System.out.println(stmt + "<-- updateScheduleForm stmt");
  	
  	// 출력할 데이터 확인
   	ResultSet rs = stmt.executeQuery();  
   	System.out.println(rs + "<-- rs확인");
   	
   	// 일반적인 자료구조타입으로 바꾸기
   	// ResultSet -> ArrayList< > 로 변경
    ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
    while(rs.next()){
        Schedule s = new Schedule();
        s.scheduleNo = rs.getInt("scheduleNo");
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
	<form action="./updateScheduleAction.jsp">
		<div style="text-align: center">
		<h1>스케줄 수정</h1>
		</div>
		<table class="table">
			<%
				// for each 문 사용(arrayList와 주로 사용하는것 같다.)
				// while(rs.next()) {
				for(Schedule s : scheduleList){
			%>
			<tr class="table-primary">
				<th>스케줄 등록번호</th>
				<td><input type ="text" name="scheduleNo" readonly="readonly" value="<%=s.scheduleNo%>"></td>
			</tr>
			<tr class="table-success">
				<th>스케줄 비밀번호</th>
				<td><input type ="password" name="schedulePw"></td>
			</tr>
			<tr class="table-danger">
				<th>스케줄 날짜</th>
				<td><input type="date" name="scheduleDate">				
				</td>
			</tr>
			<tr class="table-warning">
				<th>스케줄 시간</th>
				<td><input type="time" name="scheduleTime">
				</td>
			</tr>
			<tr class="table-active">
				<th>스케줄 메모</th>
				<td>
					<textarea cols="80" rows="3" name="scheduleMemo"></textarea>
				</td>
			</tr>
			<tr class="table-info">
				<th>스케줄 색상</th>
				<td><input type="color" name="scheduleColor"></td>
			</tr>
			<tr class="table-primary">
				<th>생성일</th>
				<td><%=s.createdate%></td>
			</tr>
			<tr class="table-success">
				<th>수정일</th>
				<td><%=s.updatedate%></td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit" class="btn btn-secondary">수정</button>
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</form>
</body>
</html>