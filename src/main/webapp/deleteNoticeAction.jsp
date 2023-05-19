<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
   // 유효성 검사
	if(request.getParameter("noticeNo") == null 
		|| request.getParameter("noticePw") == null
		|| request.getParameter("noticeNo").equals("")
		|| request.getParameter("noticePw").equals("")) {// null이거나 공백이면 코드 종료 후 이동
		response.sendRedirect("./noticeList.jsp");
		return; // <-- 코드 종료하기 위해서 사용 
	}
   
	// 받아온 값을 변수에 저장함
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticePw = request.getParameter("noticePw");
	// 받아온 값을 확인(디버깅)
	System.out.println(noticeNo + " <-- deleteNoticeAction noticeNo");
	System.out.println(noticePw + " <-- deleteNoticeAction noticePw");
   
	// db 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	System.out.println(conn + "<-- conn 정상");
	
 	// sql 작성 및 db 변환
  	String sql = "delete from notice where notice_no=? and notice_pw=?";
  	PreparedStatement stmt = conn.prepareStatement(sql);
  	
  	// ? 값 설정
	stmt.setInt(1, noticeNo);
	stmt.setString(2, noticePw);
	System.out.println(stmt + " <-- deleteNoticeAction stmt");

	// 성공 여부 확인
	int row = stmt.executeUpdate();
	if(row == 0) { 
		System.out.println("delete 실패");
		response.sendRedirect("./deleteNoticeForm.jsp?noticeNo="+noticeNo);
      // response.sendRedirect("./noticeOne.jsp?noticeNo="+noticeNo);
	} else {
		System.out.println("delete 성공");
		response.sendRedirect("./noticeList.jsp");
	}
%>