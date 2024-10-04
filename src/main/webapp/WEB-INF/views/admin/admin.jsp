<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
    
 body{
 	margin: 30vh;
 }
    /* 관리자 페이지 스타일 */
h1 {
    margin-top: 30px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
}

th {
    background-color: #f2f2f2;
}

#members, #reports {
    display: block; /* 기본적으로 표시되도록 설정 */
}

.hidden {
    display: none; /* 숨김 처리 */
}
    
    </style>
    
    <script type="text/javascript">
 // 회원 정보 토글
    document.getElementById('toggleMembers').addEventListener('click', function() {
        var membersDiv = document.getElementById('members');
        membersDiv.classList.toggle('hidden');
    });

    // 신고 내역 토글
    document.getElementById('toggleReports').addEventListener('click', function() {
        var reportsDiv = document.getElementById('reports');
        reportsDiv.classList.toggle('hidden');
    });

    </script>
    <title>관리자 페이지</title>
    <!-- 관리자 페이지 CSS -->
    <link rel="stylesheet" href="admin.css">
</head>
<body>
    <h1>회원 정보</h1>
    <button id="toggleMembers">회원 정보 보이기/숨기기</button>
    <div id="members">
        <!-- 여기에 회원 정보 테이블이 들어감 -->
        <table>
            <!-- 테이블 헤더 생략 -->
            <tr>
                <th>회원 ID</th>
                <th>이름</th>
                <th>이메일</th>
                <th>활성화 여부</th>
            </tr>
            <!-- 회원 정보를 서버에서 받아와서 출력 -->
        </table>
    </div>

    <h1>신고 내역</h1>
    <button id="toggleReports">신고 내역 보이기/숨기기</button>
    <div id="reports">
        <!-- 여기에 신고 내역 테이블이 들어감 -->
        <table>
            <!-- 테이블 헤더 생략 -->
            <tr>
                <th>신고 번호</th>
                <th>신고자 ID</th>
                <th>신고 대상 ID</th>
                <th>신고 사유</th>
                <th>처리 상태</th>
            </tr>
            <!-- 신고 내역을 서버에서 받아와서 출력 -->
        </table>
    </div>

</body>
</html>
