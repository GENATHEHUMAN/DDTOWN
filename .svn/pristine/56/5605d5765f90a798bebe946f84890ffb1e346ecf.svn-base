<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>문의 상세 내역</title>
<%@ include file="../../modules/headerPart.jsp" %> <%-- 실제 경로로 수정 필요 --%>
<style>
    html, body {
        height: 100%;
    }
    .wrapper {
        min-height: 100%;
        display: flex;
        flex-direction: column;
    }
    .content-wrapper.no-layout {
        margin-left: 0 !important;
        min-height: 100vh;
        flex-grow: 1;
        background-color: #f4f6f9; /* AdminLTE content-wrapper 기본 배경색과 유사하게 */
    }
    .page-main-title { /* 새로 추가된 페이지 제목 스타일 */
        font-size: 2.2rem; /* 이미지와 유사한 크기로 조정 */
        font-weight: 600; /* 조금 더 굵게 */
        color: #333; /* 제목 색상 */
    }
    .card-title { /* 카드 내 제목 스타일 */
        font-size: 1.5rem;
        font-weight: 600;
    }
    .content-area-text {
        min-height: 100px;
        white-space: pre-wrap;
        word-break: break-all;
        background-color: #f8f9fa;
    }
    .answer-area-text {
        min-height: 100px;
        white-space: pre-wrap;
        word-break: break-all;
        background-color: #e9ecef; /* 이전 스타일 유지 */
    }

    .col-md-10.offset-md-1 {
	    justify-items: center;
	}

	.card-body {
	    flex: 1 1 auto;
	    padding: var(--bs-card-spacer-y) var(--bs-card-spacer-x);
	    color: var(--bs-card-color);
	    max-width: 800px;
	}

	.titleArea {
	    display: flex;
	    justify-content: space-between;
	}

	div#detailActions {
	    margin-bottom: 10px;
	}

	a.btn.btn-secondary {
	    margin-left: auto;
	}
</style>
</head>
<body class="hold-transition">
<%@ include file="../../modules/communityHeader.jsp" %>
<div class="wrapper">
    <div class="content-wrapper no-layout">
        <%-- Content Header (Page header) 제거 --%>
        <%-- 대신 메인 콘텐츠 영역 상단에 제목 추가 --%>
        <section class="content pt-5 pb-3"> <%-- 위아래 패딩 조정 --%>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12 text-center mb-4">
                        <h1 class="page-main-title">문의 상세 내역</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-10 offset-md-1">
                        <div class="card card-outline card-primary shadow-sm"> <%-- shadow-sm 추가로 약간의 그림자 --%>
                            <div class="card-body">
                                <div class="pb-3 mb-4 border-bottom">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <h3 class="card-title mb-0" id="detailTitle"></h3>
                                        <span id="detailStatus" class="badge"></span>
                                    </div>
                                    <div class="text-muted">
                                        <small>
                                            <i class="far fa-calendar-alt mr-1"></i><span id="detailDate" class="mr-3"></span>
                                            <i class="far fa-folder mr-1"></i><span id="detailType"></span>
                                        </small>
                                    </div>
                                <y_bin_649>

                                <div class="mt-3">
                                    <div class="mb-4">
                                    	<div class="titleArea">
	                                        <h5><i class="fas fa-question-circle text-info mr-2"></i>문의 내용</h5>
	                                        <div id="detailActions">
		                                        <%-- 수정/삭제 버튼은 JavaScript로 이곳에 추가됨 --%>
		                                    </div>
                                    	</div>
                                        <div class="p-3 rounded content-area-text">
                                            <p id="inqContent" class="mb-0"></p>
                                        </div>
                                    </div>

                                    <div>
                                        <h5><i class="fas fa-reply text-success mr-2"></i>답변</h5>
                                        <div class="p-3 rounded answer-area-text">
                                            <p id="inqAnsContent" class="mb-0"></p>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4 pt-3 border-top d-flex justify-content-between align-items-center">

                                    <a href="/inquiry/main" class="btn btn-secondary"><i class="fas fa-list mr-1"></i> 목록으로</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%-- /.content --%>
    </div>
    <%-- /.content-wrapper --%>

</div>
<%-- ./wrapper --%>

<%-- (필수 JS 파일 로드 주석은 이전과 동일하게 유지) --%>
<%--
    예시 (실제 경로와 버전에 맞게 수정하여 headerPart.jsp 또는 여기에 추가):
    <script src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/adminlte.min.js"></script>
--%>
	<div id="footer">
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/views/modules/communityFooter.jsp" />
        <script src="${pageContext.request.contextPath}/resources/js/pages/communityFooter.js"></script>
        <!-- FOOTER END -->
    </div>
<script type="text/javascript">
$(document).ready(function() {
    // ... (이하 JavaScript 코드는 이전과 동일) ...
    const currentUrl = location.href;
    const sliceUrl = currentUrl.split("/");
    const inqNo = sliceUrl[sliceUrl.length -1];

    function dateFormat(jsonDate){
        if (!jsonDate) return "날짜 정보 없음";
        let date = new Date(jsonDate);
        let month = date.getMonth() + 1;
        let day = date.getDate();
        let hour = date.getHours();
        let minute = date.getMinutes();
        let second = date.getSeconds();

        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        hour = hour >= 10 ? hour : '0' + hour;
        minute = minute >= 10 ? minute : '0' + minute;
        second = second >= 10 ? second : '0' + second;

        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
    }

    function detail(){
        $.ajax({
            url : "/inquiry/getData/" + inqNo,
            type : "get",
            contentType : "application/json; charset=utf-8",
            success : function(res){
                let regDate = dateFormat(res.inqRegDate);

                $("#detailTitle").html(res.inqTitle || "제목 없음");

                const statusBadge = $("#detailStatus");
                statusBadge.removeClass('badge-success badge-warning badge-secondary');
                if (res.statDetailCode && res.inqStatCodeDes) {
                    statusBadge.html(res.inqStatCodeDes);
                    if(res.inqStatCodeDes === '답변완료'){
                        statusBadge.addClass('badge-success');
                    } else if(res.inqStatCodeDes === '접수됨'){
                        statusBadge.addClass('badge-warning');
                    } else {
                        statusBadge.addClass('badge-secondary');
                    }
                } else {
                    statusBadge.html("상태 미확인").addClass('badge-secondary');
                }

                $("#inqContent").html(res.inqContent ? res.inqContent.replace(/\n/g, '<br>') : "내용 없음");
                $("#detailDate").html(regDate);
                $("#detailType").html(res.typeDetailCode ? res.inqTypeCodeDes : "유형 미확인");

                if(res.inqAnsContent == null){
                    $("#inqAnsContent").html("답변을 기다리고 있습니다. 관리자가 확인 후 신속히 답변드리겠습니다.");
                    let button = `<button class="btn btn-primary btn-sm mr-2" onclick="editInquiry()">수정하기 <i class="fas fa-edit"></i></button>`;
                    button += `<button class="btn btn-danger btn-sm" onclick="deleteInquiry()">삭제하기 <i class="fas fa-trash"></i></button>`;
                    $("#detailActions").html(button);
                }else{
                    $("#inqAnsContent").html(res.inqAnsContent.replace(/\n/g, '<br>'));
                    $("#detailActions").html('');
                }
            },
            error : function(error,status, xhr){
                console.log(error.status, xhr.responseText);
                Swal.fire({
                    icon: 'error',
                    title: '오류 발생',
                    text: '데이터를 불러오는데 실패했습니다. 잠시 후 다시 시도해주세요.'
                });
            }
        });
    }

    window.editInquiry = function (){
        location.href="/inquiry/update/" + inqNo;
    }

    window.deleteInquiry = function (){
        Swal.fire({
            title: '정말로 삭제하시겠습니까?',
            text: "삭제된 내용은 복구하실 수 없습니다.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '네, 삭제합니다!',
            cancelButtonText: '아니요'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url : "/inquiry/delete/" + inqNo,
                    type : "post",
                    beforeSend : function(xhr) {
                        xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
                    },
                    success : function(res){
                        if(res.status == "OK"){
                            Swal.fire(
                                '삭제 완료!',
                                '문의 내용이 성공적으로 삭제되었습니다.',
                                'success'
                            ).then(() => {
                                location.href = "/inquiry/main";
                            });
                        }else{
                             Swal.fire(
                                '삭제 실패',
                                res.message || '다시 시도해주세요!',
                                'error'
                            );
                        }
                    },
                    error : function(error, status, thrown){
                        console.log(error.status, thrown);
                        Swal.fire(
                            '요청 실패',
                            '삭제 처리 중 오류가 발생했습니다.',
                            'error'
                        );
                    }
                });
            }
        });
    }

    detail();
});
</script>
</body>
</html>