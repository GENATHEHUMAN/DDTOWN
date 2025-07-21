<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>취소/환불 상세</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <%@ include file="../../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/admin_refund_detail.css">


    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
    <div class="emp-container">
        <!-- 헤더 -->
        <%@ include file="../../modules/header.jsp" %>

        <div class="emp-body-wrapper">
            <%@ include file="../../modules/aside.jsp" %>
            <main class="emp-content">
            	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/admin/goods/cancelRefund/list" style="color:black;">굿즈샵 관리</a></li>
                        <li class="breadcrumb-item"><a href="/admin/goods/cancelRefund/list" style="color:black;">주문 취소 관리</a></li>
                        <li class="breadcrumb-item active" aria-current="page">주문 취소 상세</li>
                    </ol>
                </nav>
                <div class="ea-section">
                    <div class="ea-section-header">
                        <h2>주문 취소 상세</h2>
                        <button type="button" class="ea-btn primary" onclick="saveDetail()">저장</button>
                    </div>
                    <form id="detailForm" class="ea-form">
                        <div class="form-group">
                            <label>취소번호</label>
                            <input type="text" id="cancelNo" readonly>
                        </div>
                        <div class="form-group">
                            <label>주문번호</label>
                            <input type="text" id="orderNo" readonly>
                        </div>
                        <div class="form-group">
                            <label>회원ID</label>
                            <input type="text" id="memUsername" readonly>
                        </div>
                        <div class="form-group">
                            <label>상품명</label>
                            <input type="text" id="goodsName" readonly>
                        </div>
                        <div class="form-group">
                            <label>유형</label>
                            <input type="text" id="cancelType" readonly>
                        </div>
						<div class="form-group">
                            <label>상태</label>
                            <select id="cancelStatCode" class="ea-filter-select" disabled>
							    <option value="CSC001">요청 접수</option>
							    <option value="CSC002">처리중</option>
							    <option value="CSC003">취소 완료</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>요청일</label>
                            <input type="text" id="cancelReqDate" readonly>
                        </div>
                        <div class="form-group">
                            <label>처리일</label>
                            <input type="text" id="cancelResDate" readonly>
                        </div>
                        <div class="form-group">
                            <label>환불 계좌번호</label>
                            <input type="text" id="cancelAccountNo" maxlength="60">
                        </div>
                        <div class="form-group">
                            <label>환불 계좌 예금주</label>
                            <input type="text" id="cancelAccountHol" maxlength="30">
                        </div>
                        <div class="form-group">
                            <label>상세 사유</label>
                            <textarea id="cancelReasonDetail" maxlength="1000" rows="3"></textarea>
                        </div>
                        <div class="ea-form-actions">

                            <a href="/admin/goods/cancelRefund/list" class="ea-btn outline">목록</a>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>
<%@ include file="../../../modules/footerPart.jsp" %>

<%@ include file="../../../modules/sidebar.jsp" %>
<script>
//CSRF 토큰과 헤더를 전역 변수로 선언 (DOMContentLoaded에서 초기화될 예정)
let csrfToken;
let csrfHeader;

// 쿼리스트링 파싱

function getQueryParam(name) {

const url = new URL(window.location.href);

return url.searchParams.get(name);

}

//DOMContentLoaded 이벤트 리스너: DOM이 완전히 로드된 후 실행
document.addEventListener('DOMContentLoaded', function() {
    // CSRF 토큰 초기화
    const csrfMeta = document.querySelector('meta[name="_csrf"]');
    const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
    if (csrfMeta && csrfHeaderMeta) {
        csrfToken = csrfMeta.content;
        csrfHeader = csrfHeaderMeta.content;
    } else {
        console.error("CSRF meta tags not found. POST 요청에 문제가 있을 수 있습니다.");
    }

    // --- 로그인 상태 관리 및 로그아웃 버튼 로직 (이전 코드 그대로 유지) ---
    // Spring Security context에서 isLoggedIn 변수가 넘어온다고 가정
    // JSP/EL 표현식: isLoggedIn 값이 null일 경우 'false' 문자열로 대체하여 JavaScript 오류 방지
    const isLoggedIn = ${isLoggedIn != null ? isLoggedIn : 'false'};

    const loggedOutNav = document.getElementById('loggedOutNav');
    const loggedInNav = document.getElementById('loggedInNav');
    if (isLoggedIn) {
        if(loggedOutNav) loggedOutNav.style.display = 'none';
        if(loggedInNav) loggedInNav.style.display = 'flex';
    } else {
        if(loggedOutNav) loggedOutNav.style.display = 'flex';
        if(loggedInNav) loggedInNav.style.display = 'none';
    }

    const logoutBtn = document.getElementById('logoutBtn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 링크 이동 방지
            alert("로그아웃되었습니다.");
            window.location.href = '${pageContext.request.contextPath}/logout'; // 실제 로그아웃 URL
        });
    }
    // --- 로그인 상태 관리 및 로그아웃 버튼 로직 끝 ---

    // 페이지 로드 시 상세 데이터 렌더링 함수 호출
    renderDetail();
}); // DOMContentLoaded 닫는 괄호


// saveDetail 함수 구현

// saveDetail 함수 구현
    async function saveDetail() {
        // CSRF 토큰 정보는 이미 DOMContentLoaded에서 전역 변수로 초기화되었으므로,
        // 이 함수 내에서 다시 document.querySelector로 찾을 필요가 없습니다.
        // 바로 전역 변수인 csrfToken과 csrfHeader를 사용합니다.

        const cancelNo = document.getElementById('cancelNo').value;
        const cancelStatCode = document.getElementById('cancelStatCode').value;
        const cancelReasonDetail = document.getElementById('cancelReasonDetail').value;

        // 1. 클라이언트 측 유효성 검사 (필요시 추가)
        if (cancelStatCode === 'REJ' && !cancelReasonDetail.trim()) {
            alert('요청을 거부하는 경우 상세 사유는 필수입니다.');
            document.getElementById('cancelReasonDetail').focus();
            return;
        }

        // 2. 서버로 보낼 데이터 객체 생성
        const updateData = {
            cancelNo: cancelNo,
            cancelStatCode: cancelStatCode,
            cancelReasonDetail: cancelReasonDetail
        };

        // 3. fetch API를 이용한 서버 요청
        try {
            const response = await fetch('/admin/goods/cancelRefund/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    // ★★★ CSRF 헤더와 토큰을 여기에 추가합니다! ★★★
                    [csrfHeader]: csrfToken
                },
                body: JSON.stringify(updateData)
            });

            if (!response.ok) {
                const errorText = await response.text();
                // 서버에서 403 Forbidden 에러가 CSRF 때문이 아닐 수도 있으므로, 상세 메시지 확인
                if (response.status === 403 && errorText.includes("Invalid CSRF token")) {
                    alert('보안 토큰이 유효하지 않습니다. 페이지를 새로고침 후 다시 시도해주세요.');
                } else {
                    throw new Error(`업데이트 실패: ${response.status} ${errorText}`);
                }
            } else {
                const result = await response.json();

                if (result.success) {
                    alert(result.message || '성공적으로 저장되었습니다.');
                    renderDetail(); // 현재 페이지 데이터 새로고침
                } else {
                    alert(result.message || '저장에 실패했습니다.');
                    console.error("저장 실패 상세:", result.error);
                }
            }

        } catch (error) {
            console.error('데이터 저장 중 오류 발생:', error);
            alert('데이터 저장 중 오류가 발생했습니다: ' + error.message);
        }
    }





// 상세 데이터 렌더링

async function renderDetail() {

const cancelNo = getQueryParam('cancelNo');


if (!cancelNo) {

console.error("취소 번호가 URL에 없습니다.");

alert('유효하지 않은 접근입니다. 목록으로 돌아갑니다.');

window.location.href = '/admin/goods/cancelRefund/list';

return;

}



try {

// ★★★ 여기가 핵심 수정 부분입니다. /detailData 로 변경! ★★★

const response = await fetch(`/admin/goods/cancelRefund/detailData?cancelNo=\${cancelNo}`);


if (!response.ok) {

throw new Error('Network response was not ok ' + response.statusText);

}


const data = await response.json(); // JSON 응답 파싱

if (!data || Object.keys(data).length === 0) {

alert('해당 취소/환불 데이터를 찾을 수 없습니다.');

window.location.href = '/admin/goods/cancelRefund/list';

return;

}



// 필드 매핑 및 값 설정

document.getElementById('cancelNo').value = data.cancelNo || '';

document.getElementById('orderNo').value = data.orderNo || '';

document.getElementById('memUsername').value = data.memUsername || '';

document.getElementById('goodsName').value = data.goodsNm || '';

document.getElementById('cancelType').value = data.cancelTypeName || '';


const cancelStatSelect = document.getElementById('cancelStatCode');

if (cancelStatSelect) {

cancelStatSelect.value = data.cancelStatCode || '';

}



const formattedReqDate = data.cancelReqDate ? new Date(data.cancelReqDate).toISOString().slice(0, 10) : '';

const formattedResDate = data.cancelResDate ? new Date(data.cancelResDate).toISOString().slice(0, 10) : '';


document.getElementById('cancelReqDate').value = formattedReqDate;

document.getElementById('cancelResDate').value = formattedResDate;



document.getElementById('cancelAccountNo').value = data.cancelAccountNo || '';

document.getElementById('cancelAccountHol').value = data.cancelAccountHol || '';

document.getElementById('cancelReasonDetail').value = data.cancelReasonDetail || '';



} catch (error) {

console.error('상세 데이터를 가져오는 중 오류 발생:', error);

alert('상세 데이터를 가져오는 데 실패했습니다. 오류: ' + error.message);

window.location.href = '/admin/goods/cancelRefund/list';

}

}



// ... (로그아웃 기능 복사 및 렌더링 호출) ...

const logoutButton = document.querySelector('.emp-logout-btn');

if (logoutButton) {

logoutButton.addEventListener('click', function(e) {

e.preventDefault();

if (confirm('로그아웃 하시겠습니까?')) {

alert('로그아웃 되었습니다.'); // 실제 로그아웃 로직은 백엔드 연동 필요

// window.location.href = '/logout'; // 실제 로그아웃 경로
window.location.href = '${pageContext.request.contextPath}/logout';
}

});

}



// 페이지 로드 시 상세 데이터 렌더링 함수 호출

renderDetail();

</script>
</body>
</html>