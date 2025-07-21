<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 등록 - DDTOWN 직원 포털</title>
    <%@ include file="../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
    /* ---------------------------------- */
    /* 공통 & 기본 설정                   */
    /* ---------------------------------- */
    body {
        font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
        margin: 0;
        background-color: #f4f6f9;
        color: #212529;
    }
    a { text-decoration: none; }
    a:hover { color: #007bff; }
    h4 { font-size: 1.2em; margin-bottom: 15px; color: #34495e; padding-bottom: 10px; border-bottom: 2px solid #34495e; }
    
    /* ---------------------------------- */
    /* 폼 페이지 레이아웃 (`form.jsp`, `mod.jsp`) */
    /* ---------------------------------- */
    .form-view-container {
        background: #fff; padding: 30px 35px; border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    }
    .form-header {
        padding-bottom: 20px; border-bottom: 1px solid #dee2e6; margin-bottom: 30px;
    }
    .form-title {
        font-size: 1.8em; font-weight: 600; margin-bottom: 0; color: #2c3e50;
    }
    .form-table {
        width: 100%; border-top: 2px solid #333; border-collapse: collapse;
    }
    .form-table th, .form-table td {
        border-bottom: 1px solid #dee2e6; padding: 15px;
        font-size: 0.95em; vertical-align: middle;
    }
    .form-table th {
        width: 20%; background-color: #f8f9fa; text-align: left; font-weight: 600;
    }
    .form-table input[type="text"],
    .form-table select,
    .form-table textarea {
        width: 100%; padding: 10px; border: 1px solid #ced4da;
        border-radius: 6px; font-size: 1em; box-sizing: border-box;
    }
    .form-table input:focus, .form-table select:focus, .form-table textarea:focus {
        outline: none; border-color: #80bdff; box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
    }
    .form-table textarea { min-height: 200px; resize: vertical; }
    .attachment-list-edit li { margin-bottom: 8px; }
    .attachment-list-edit img { vertical-align: middle; margin-right: 8px; width: 40px; height: 40px; object-fit: cover; }

    /* ---------------------------------- */
    /* 버튼 UI (공통)                   */
    /* ---------------------------------- */
    .actions-container { text-align: right; padding-top: 25px; margin-top: 20px; border-top: 1px solid #e9ecef; }
    .actions-container .btn { margin-left: 8px; }
    .btn {
        display: inline-block; padding: 10px 20px; font-size: 0.95em; font-weight: 500;
        text-align: center; text-decoration: none; border: none; border-radius: 6px;
        cursor: pointer; transition: all 0.2s ease-in-out;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
    .btn-submit, .btn-primary { background-color: #0d6efd; color: white; }
    .btn-submit:hover, .btn-primary:hover { background-color: #1a3c8a; color: white; }
    .btn-secondary { background-color: #6c757d; color: white; }
    .btn-secondary:hover { background-color: #5a6268; }
    .btn-warning { background-color: #ffc107; color: #212529; }
    .btn-danger { background-color: #dc3545; color: white; }

</style>
</head>
<body>
    <div class="emp-container">
    <%@ include file="../modules/header.jsp" %>
		<div class="emp-body-wrapper">
			<%@ include file="../modules/aside.jsp" %>
			<main class="emp-content" style="position:relative; min-height:600px;">
				<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
	                <ol class="breadcrumb">
	                    <li class="breadcrumb-item" style="color:black;">아티스트 커뮤니티 관리</li>
	                    <li class="breadcrumb-item"><a href="/emp/community/notice/list" style="color:black;">공지사항 관리</a></li>
	                    <li class="breadcrumb-item active" aria-current="page">새 공지사항 등록</li>
	                </ol>
	            </nav>
                <c:if test="${not empty errorMessage}"><div class="message error">${errorMessage}</div></c:if>

                <div class="form-view-container">
                    <div class="form-header">
                        <h2 class="form-title">새 공지사항 등록</h2>
                    </div>

                    <form method="post" action="<c:url value='/emp/community/notice/insert'/>" enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	                    <input type="hidden" name="searchType" value="${pagingVO.searchType}"/>
	                    <input type="hidden" name="searchWord" value="${pagingVO.searchWord}"/>
	                    <input type="hidden" name="currentPage" value="${pagingVO.currentPage}"/>
                        
                        <table class="form-table">
                            <tbody>
                                <tr>
                                    <th><label for="comuNotiCatCode">카테고리</label></th>
                                    <td>
                                        <select name="comuNotiCatCode" id="comuNotiCatCode">
                                            <option value="">-- 카테고리 선택 --</option>
                                            <option value="CNCC001" ${noticeVO.comuNotiCatCode == 'CNCC001' ? 'selected' : ''}>일반 공지</option>
                                            <option value="CNCC002" ${noticeVO.comuNotiCatCode == 'CNCC002' ? 'selected' : ''}>콘서트 공지</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                	<th><label for="artGroupNo">아티스트 그룹</label>
                                	<td>
                                		<select id="artGroupNo" name="artGroupNo">
                                			<option value="">-- 아티스트 그룹 선택 --</option>
                                			<c:forEach var="group" items="${artistGroups}">
                                				<option value="${group.artGroupNo}" ${noticeVO.artGroupNo == group.artGroupNo ? 'selected' : ''}>
                                					<c:out value="${group.artGroupNm}"/>
                                				</option>
                                			</c:forEach>
                                		</select>
                                	</td>
                                </tr>
                                <tr>
                                    <th><label for="comuNotiTitle">제목</label></th>
                                    <td><input type="text" id="comuNotiTitle" name="comuNotiTitle" placeholder="제목을 입력하세요" required></td>
                                </tr>
                                <tr>
                                    <th><label for="comuNotiContent">내용</label></th>
                                    <td><textarea id="comuNotiContent" name="comuNotiContent" placeholder="내용을 입력하세요" required></textarea></td>
                                </tr>
                                <tr>
                                    <th><label for="comuNotiFiles">첨부파일</label></th>
                                    <td><input type="file" id="comuNotiFiles" name="comuNotiFiles" multiple="multiple"></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="actions-container">
                            <c:url var="listUrl" value="/emp/community/notice/list">
                                <c:param name="searchType" value="${pagingVO.searchType}" />
                                <c:param name="searchWord" value="${pagingVO.searchWord}" />
                                <c:param name="currentPage" value="${pagingVO.currentPage}" />
                                <c:param name="artGroupNo" value="${pagingVO.artGroupNo}"/>
                            </c:url>
                            <a href="${listUrl}" class="btn btn-secondary">취소</a>
                            <button type="submit" class="btn btn-submit">등록하기</button>
                        </div>
                    </form>
                </div>
			</main>
		</div>
	</div>
	<%@ include file="../../modules/footerPart.jsp" %>
	<%@ include file="../../modules/sidebar.jsp" %>
</body>
<script>
// 취소 버튼 클릭 시 공지사항 관리로 이동
document.getElementById('cancelBtn').onclick = function() {
    window.location.href = '/emp/notice/list';
};

// 폼 제출 시(등록)
document.getElementById('noticeCreateForm').onsubmit = function(e) {
    e.preventDefault();
    // var noticeContent = CKEDITOR.instances.noticeContent.getData();
    alert('공지사항이 등록되었습니다. (실제 저장은 미구현)');
    window.location.href = '/emp/notice/detail';
};
</script>
</html> 