<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	// 인코딩 설정 (한글로 설정해서 깨짐을 방지함)
	request.setCharacterEncoding("utf-8");
	
	// 유효성 검사
	if(request.getParameter("scheduleNo")==null
		||request.getParameter("schedulePw")==null
		||request.getParameter("scheduleNo").equals("")
		||request.getParameter("schedulePw").equals("")){// null이거나 공백이면 코드 종료 후 이동
		
		response.sendRedirect("./deleteScheduleForm.jsp");
		return;	//<-- 코드 종료하기 위해서 사용 
	}
	
	// 받아온 값을 변수에 저장
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	String schedulePw = request.getParameter("schedulePw");
	// 받아온 값 확인
	System.out.println(scheduleNo + "<-- deleteScheduleAction scheduleNo");
	System.out.println(schedulePw + "<-- deleteScheduleAction schedulePw");
	
	// db 연결
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 확인");	
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	System.out.println(conn + "<-- conn 정상");
		
	// sql 작성 및 db 변환
	String sql = "delete from schedule where schedule_no=? and schedule_pw=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// ? 값을 설정
	stmt.setInt(1,scheduleNo);
	stmt.setString(2,schedulePw);
	System.out.println(stmt + "<-- deleteScheduleAction stmt");

	// 성공 여부 확인
	int row = stmt.executeUpdate();
	if(row==0){
		System.out.println("delete 실패");
		response.sendRedirect("./deleteScheduleForm.jsp?scheduleNo="+scheduleNo);
	}else{
		System.out.println("delete 성공");
		response.sendRedirect("./scheduleList.jsp");
	}

%>