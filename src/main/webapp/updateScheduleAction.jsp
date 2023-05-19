<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// 인코딩 설정   
	request.setCharacterEncoding("utf-8");

	// 유효성 검사
	if(request.getParameter("scheduleNo")==null
		||request.getParameter("schedulePw")==null
		||request.getParameter("scheduleDate")==null
		||request.getParameter("scheduleTime")==null
		||request.getParameter("scheduleMemo")==null
		||request.getParameter("scheduleColor")==null
		||request.getParameter("scheduleNo").equals("")
		||request.getParameter("schedulePw").equals("")
		||request.getParameter("scheduleDate").equals("")
		||request.getParameter("scheduleTime").equals("")
		||request.getParameter("scheduleMemo").equals("")
		||request.getParameter("scheduleColor").equals("")){
	
		response.sendRedirect("./scheduleList.jsp");
	}

	// 받아온 값과 문자를 변수에 저장
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	String schedulePw = request.getParameter("schedulePw");
	String scheduleDate = request.getParameter("scheduleDate");
	String scheduleTime = request.getParameter("scheduleTime");
	String scheduleMemo = request.getParameter("scheduleMemo");
	String scheduleColor = request.getParameter("scheduleColor");
	
	System.out.println(scheduleNo + "<-- updateScheduleAtion scheduleNo");
	System.out.println(schedulePw + "<-- updateScheduleAtion schedulePw");
	System.out.println(scheduleDate + "<-- updateScheduleAtion scheduleDate");
	System.out.println(scheduleTime + "<-- updateScheduleAtion scheduleTime");
	System.out.println(scheduleMemo + "<-- updateScheduleAtion scheduleMemo");
	System.out.println(scheduleColor + "<-- updateScheduleAtion scheduleColor");
	
	String y = scheduleDate.substring(0,4); 
	int m = Integer.parseInt(scheduleDate.substring(5,7))-1; 
	String d = scheduleDate.substring(8);
	
	System.out.println(y + "<-- insert.y");
	System.out.println(m + "<-- insert.m");
	System.out.println(d + "<-- insert.d");

	// db 연결
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 확인");
	
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	System.out.println(conn + "<-- conn");
	
	// sql 작성 및 db 변환
	String sql = "update schedule set schedule_date = ?, schedule_time = ?, schedule_memo = ?, schedule_color = ?, updatedate = now() where schedule_no = ? and schedule_pw = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// ? 값 넣기
	stmt.setString(1,scheduleDate);
	stmt.setString(2,scheduleTime);
	stmt.setString(3,scheduleMemo);
	stmt.setString(4,scheduleColor);
	stmt.setInt(5,scheduleNo);
	stmt.setString(6,schedulePw);
	System.out.println(stmt + "<-- updateScheduleAtion stmt");
	
	
	// 성공 여부 확인
	int row = stmt.executeUpdate();
	if(row==0){
		System.out.println("update 실패");
		response.sendRedirect("./scheduleListByDate.jsp?y="+y+"&m="+m+"&d="+d);
	} else{
		System.out.println("update 성공");
		response.sendRedirect("./scheduleListByDate.jsp?y="+y+"&m="+m+"&d="+d);
	}	
	
%>