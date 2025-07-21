<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹 관리</title>
<style>
    table {
        width: 80%;
        border-collapse: collapse;
        margin: 20px auto;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }

    /* 모달 스타일 */
    .modal {
        display: none; /* 기본적으로 숨김 */
        position: fixed; /* 화면에 고정 */
        z-index: 1000; /* 다른 요소들 위에 표시 */
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto; /* 스크롤 가능하도록 */
        background-color: rgba(0,0,0,0.4); /* 반투명 배경 */
    }

    .modal-content {
        background-color: #fefefe;
        margin: 10% auto; /* 수직/수평 중앙 정렬 (상단에서 10%) */
        padding: 20px;
        border: 1px solid #888;
        width: 60%; /* 모달 너비 */
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        border-radius: 5px;
    }

    .close-button {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close-button:hover,
    .close-button:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
    .modal-content hr {
        margin-top: 5px;
        margin-bottom: 15px;
    }
    .modal-content p {
        margin-bottom: 10px;
    }
    .modal-content textarea {
        width: 95%;
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 3px;
        resize: vertical; /* 세로 크기만 조절 가능 */
    }
</style>
</head>
<body>
    <h1>그룹 목록</h1>

    <c:if test="${not empty artistGroupList}">
        <table>
            <thead>
                <tr>
                    <th>프로필 ID</th>
                    <th>그룹명</th>
                    <th>데뷔일자</th>
                    <th>최근 수정일</th>
                    <th>관리</th>
                    <%-- 기타 필요한 헤더 --%>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${artistGroupList}" var="group">
                    <tr>
                        <td>${group.artGroupNo}</td>
                        <td>${group.artGroupNm}</td>
                        <td>${group.artGroupDebutdate}</td>
                        <td>
				            <fmt:formatDate value="${group.artGroupModDate }" pattern="yyyy-MM-dd HH:mm:ss" />
				        </td>
				        <td>
				            <button class="edit-group-btn"
				                    data-group-no="${group.artGroupNo}"
				                    data-group-nm="${group.artGroupNm}"
				                    data-group-debutdate="${group.artGroupDebutdate}"
				                    data-group-moddate="<fmt:formatDate value="${group.artGroupModDate}" pattern="yyyy-MM-dd HH:mm:ss" />"
				                    data-group-typecode="${group.artGroupTypeCode}"
				                    data-group-empusername="${group.empUsername}"
				                    data-group-content="${group.artGroupContent}"
				                    data-group-profileimg="${group.artGroupProfileImg}">수정</button>
				        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty artistGroupList}">
        <p>등록된 그룹이 없습니다.</p>
    </c:if>
    <script>
	    // 모달 요소 가져오기
	    const modal = document.getElementById('groupModal');
	    const closeButton = document.querySelector('.close-button');
	
	    // 모든 '수정' 버튼에 이벤트 리스너 추가
	    const editButtons = document.querySelectorAll('.edit-group-btn');
	
	    editButtons.forEach(button => {
	        button.addEventListener('click', function() {
	            // 버튼의 data-* 속성에서 그룹 정보 가져오기
	            const artGroupNo = this.dataset.groupNo;
	            const artGroupNm = this.dataset.groupNm;
	            const artGroupDebutdate = this.dataset.groupDebutdate;
	            const artGroupModDate = this.dataset.groupModdate;
	            const artGroupTypeCode = this.dataset.groupTypecode;
	            const empUsername = this.dataset.groupEmpusername;
	            const artGroupContent = this.dataset.groupContent;
	            const artGroupProfileImg = this.dataset.groupProfileimg;
	
	
	            // 모달 내부의 해당 필드에 데이터 채우기
	            document.getElementById('modalArtGroupNo').textContent = artGroupNo;
	            document.getElementById('modalArtGroupNm').textContent = artGroupNm;
	            document.getElementById('modalArtGroupDebutdate').textContent = artGroupDebutdate;
	            document.getElementById('modalArtGroupModDate').textContent = artGroupModDate;
	            document.getElementById('modalArtGroupTypeCode').textContent = artGroupTypeCode;
	            document.getElementById('modalEmpUsername').textContent = empUsername;
	            document.getElementById('modalArtGroupContent').value = artGroupContent; // textarea는 .value
	            document.getElementById('modalArtGroupProfileImg').textContent = artGroupProfileImg;
	
	            // 모달 표시
	            modal.style.display = 'block';
	        });
	    });
	
	    // 닫기 버튼 클릭 시 모달 숨김
	    closeButton.addEventListener('click', function() {
	        modal.style.display = 'none';
	    });
	
	    // 모달 외부 클릭 시 모달 숨김
	    window.addEventListener('click', function(event) {
	        if (event.target == modal) {
	            modal.style.display = 'none';
	        }
	    });
	</script>
</body>
</html>