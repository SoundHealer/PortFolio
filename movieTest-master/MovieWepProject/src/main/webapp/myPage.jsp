<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resource/css/styles1.css" type="text/css">
<script src="resource/js/signin.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<%
Object useridobj = session.getAttribute("userId");
String userid = useridobj == null ? "" : (String) useridobj;
System.out.println("마이페이지 로드 : [" + userid + "]");
%>

<script type="text/javascript">
    //alert("마이페이지 스크립트 실행됨");
    var userId = '<%=userid%>';
    if (userId == 'null' || userId == '') {
        //alert("페이지 이동");
        window.location.href = 'signin.jsp';
    } else {
        //alert("페이지 유지[" + userId + "]");
    }
</script>
</head>
<body>
    <main>
        <header>
            <div id="top">
                <jsp:include page="loadFile/top.jsp" />
                <jsp:include page="loadFile/menuBar.jsp" />
            </div>
        </header>
        <div class="shadowBox myInfoBox">
            <!-- 내 정보 불러오기 load -->
            <!-- 내 정보 등록하기(회원가입) insert -->
            <%
            if (userid.length() > 0) {
            %>
            <jsp:include page="loadFile/myInfoBox.jsp">
                <jsp:param name="type" value="load" />
            </jsp:include>
            <%
            }
            %>
        </div>
        <footer>
			<div id="bottom">
				<jsp:include page="loadFile/bottom.jsp" />
			</div>
		</footer>
    </main>
</body>
</html>
