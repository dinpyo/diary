<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	// 인코딩 설정 (한글 깨짐 방지)
	request.setCharacterEncoding("utf-8"); 
	
	// 유효성 검사
	if(request.getParameter("noticeTitle") == null
		|| request.getParameter("noticeContent") == null
		|| request.getParameter("noticeWriter") == null
		|| request.getParameter("noticePw") == null
		|| request.getParameter("noticeTitle").equals("")
		|| request.getParameter("noticeContent").equals("")
		|| request.getParameter("noticeWriter").equals("")
		|| request.getParameter("noticePw").equals("")) { // null이거나 공백이면 코드 종료 후 이동
		
		response.sendRedirect("./insertNoticeForm.jsp");
		return; //<-- 코드 종료하기 위해서 사용 
	}
	// 받아온 문자를 변수에 저장
	String noticeTitle = request.getParameter("noticeTitle"); 	
	String noticeContent = request.getParameter("noticeContent"); 	
	String noticeWriter = request.getParameter("noticeWriter"); 	
	String noticePw = request.getParameter("noticePw"); 	

	// 값들을 DB 테이블 입력
	/* 
	insert into notice(notice_title, notice_content, notice_writer, notice_pw, createdate, updatedate) 
	values(?,?,?,?,now(),now())
	*/	
	
	// db 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	// sql 작성 및 db 변환
	String sql = "insert into notice(notice_title, notice_content, notice_writer, notice_pw, createdate, updatedate) values(?,?,?,?,now(),now())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// ? 값을 설정
	stmt.setString(1, noticeTitle);
	stmt.setString(2, noticeContent);
	stmt.setString(3, noticeWriter);
	stmt.setString(4, noticePw);
	System.out.println(stmt + "<-- insertNoticeAction stmt");
	
	// 성공 여부 확인
	int row = stmt.executeUpdate();	// 디버깅 1(ex:2)이면 1행(ex:2행)입력성공, 0이면 입력된 행이 없다.
	System.out.println("row");
	// row값을 이용한 디버깅
	// conn.commit(); : 생략가능 // conn.setAutoCommit(true); : 디폴트 값이 true라 자동커밋 -> commit 생략가능
	// redirection
	response.sendRedirect("./noticeList.jsp");
	

%>