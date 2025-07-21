<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>나의 프로필</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/pages/my_profile.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/pages/communityModal.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
	$(function(){
		<c:if test="${not empty message }">
			Swal.fire({
					title : "${message }",
					icon : "success",
					draggable : true
				});
			<c:remove var="message" scope="request"/>
			<c:remove var="message" scope="session"/>
		</c:if>

		// 알림에서 온 경우 URL 파라미터 처리
		const urlParams = new URLSearchParams(window.location.search);
		const refreshParam = urlParams.get('refresh');
		const hash = window.location.hash;

		if (refreshParam && hash.startsWith('#post-')) {
// 			console.log("알림에서 온 프로필 페이지 감지, 게시물 모달 열기 중...");

			// 특정 게시물 모달 열기
			const postNo = hash.replace('#post-', '');
			setTimeout(function() {
				displayPostModal(postNo);
				const postModal = new bootstrap.Modal(document.getElementById('postDetailModal'));
				postModal.show();
// 				console.log("게시물 모달 열기 완료: " + postNo);
			}, 300);

			// 파라미터 제거하여 깔끔한 URL 유지
			const cleanUrl = window.location.pathname + hash;
			history.replaceState(null, null, cleanUrl);
		}
	})
	function sweetAlert(type, msg){
		return Swal.fire({
			title : msg,
			icon : type,
			showConfirmButton: false,
            timer: 2000,
			draggable : true
		});
	}

</script>

<style type="text/css">
body{
	background: linear-gradient(135deg, #1a1a2e 0%, #2a1e4a 50%, #8a2be2 100%); /* 중간색을 약간 더 보라색 계열로 조정 */
    background-attachment: fixed; /* 배경을 뷰포트에 고정 */
    background-size: cover; /* 배경이 전체 영역을 커버하도록 */
    min-height: 100vh;
    margin: 0;
    font-family: "Noto Sans KR", 돋움, Dotum, 굴림, Gulim, Tahoma, Verdana, sans-serif;
    color: #ffffff;
    overflow-x: hidden;
}
.apt-header {
    /* 기존 스타일 재정의 또는 제거 */
    background: rgba(255, 255, 255, 0.08); /* 연보라 느낌의 투명한 배경 */
    backdrop-filter: blur(15px); /* 블러 강도 증가로 깊이감 강조 */
    border: 1px solid rgba(255, 255, 255, 0.2); /* 은은하고 고급스러운 테두리 */
    border-radius: 18px; /* 더 둥근 모서리 */
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4); /* 더욱 강하고 넓은 그림자로 입체감 */
    padding: 25px 30px; /* 패딩 증가로 여유 공간 확보 */
    display: flex;
    align-items: center;
    gap: 25px; /* 요소 간 간격 증가 */
    margin-bottom: 25px; /* 하단 마진 증가 */
    transition: all 0.4s ease; /* 부드러운 전환 효과 */
    position: relative; /* 의사 요소의 기준점 */
    overflow: hidden; /* 배경 애니메이션이 밖으로 나가지 않도록 */
}
.apt-header:hover {
    box-shadow: 0 12px 45px rgba(138, 43, 226, 0.5); /* 호버 시 그림자 강조 및 색상 변화 */
    transform: translateY(-5px); /* 살짝 위로 떠오르는 효과 */
    border-color: rgba(138, 43, 226, 0.4); /* 호버 시 테두리 색상 변화 */
}
.apt-header h2,
.apt-header .artist-stats {
    color: #ffffff; /* 내부 텍스트를 흰색으로 변경 */
    text-shadow: 0 1px 4px rgba(0, 0, 0, 0.2); /* 텍스트 그림자 추가 */
}
.apt-header h2 img {
    width: 25px;
    height: 25px;
    vertical-align: middle; /* 텍스트와 이미지 정렬 */
}
.apt-header::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle at 50% 50%, rgba(255, 255, 255, 0.1), transparent);
    transform: rotate(45deg);
    opacity: 0.8;
    transition: all 0.8s ease;
    z-index: 1; /* 콘텐츠보다 뒤에 오도록 */
    pointer-events: none; /* 클릭 이벤트 방지 */
}
.apt-header:hover::before {
    transform: rotate(0deg);
    opacity: 1;
    background: radial-gradient(circle at 50% 50%, rgba(255, 255, 255, 0.2), transparent);
}
.apt-header > div {
    position: relative; /* 콘텐츠가 의사 요소 위에 오도록 z-index 부여 기준점 */
    z-index: 2;
}
.apt-header-actions .btn-apt-action {
    background: linear-gradient(45deg, #8a2be2, #da70d6); /* 그라데이션 버튼 */
    color: #ffffff;
    border: none;
    border-radius: 25px;
    padding: 10px 20px;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;
}
.apt-header-actions .btn-apt-action:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(138, 43, 226, 0.4);
    background: linear-gradient(45deg, #da70d6, #8a2be2);
}
.apt-header-actions .btn-apt-action.following {
    background: rgba(255, 255, 255, 0.2);
    border: 1px solid rgba(255, 255, 255, 0.4);
    color: #fff;
    box-shadow: none;
}
.apt-header-actions .btn-apt-action.following:hover {
    background: rgba(255, 255, 255, 0.3);
    transform: translateY(0);
    box-shadow: none;
}
.carousel-item-title {
    max-width: 100%;
    border-bottom: 1px solid aliceblue;
    margin-bottom: 10pt;
    padding-bottom: 5pt;
    color: black;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    font-weight: 600;
}
body .apt-tabs {
    display: flex;
    justify-content: center;
    padding: 0;
    margin-bottom: 30px; /* 고정될 때도 하단 여백 필요 */
    background: rgba(255, 255, 255, 0.08);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
    overflow: hidden;
    width: auto;
    gap: 30px;
}
/* 개별 탭 버튼 */
body .apt-tabs .tab-item {
    background: none; /* 기본 배경 제거 */
    border: none; /* 기본 테두리 제거 */
    padding: 15px 25px; /* 패딩 증가 */
    color: rgba(255, 255, 255, 0.7); /* 기본 텍스트 색상 (약간 투명한 흰색) */
    font-size: 1.05em; /* 폰트 크기 약간 증가 */
    font-weight: 600; /* 폰트 두께 */
    cursor: pointer;
    transition: all 0.3s ease; /* 부드러운 전환 효과 */
    white-space: nowrap; /* 텍스트가 줄바꿈되지 않도록 */
    position: relative; /* 하단 밑줄 애니메이션 기준점 */
    text-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* 텍스트 그림자 */
    margin: 0;
}
body .apt-tabs .tab-item:hover {
    color: #ffffff; /* 호버 시 흰색 */
    background-color: rgba(255, 255, 255, 0.05); /* 호버 시 약간 밝아지는 배경 */
}
body .apt-tabs .tab-item.active {
    color: #ffffff; /* 활성화 시 흰색 */
    background: linear-gradient(90deg, #8a2be2, #da70d6); /* 그라데이션 배경 */
    box-shadow: 0 2px 10px rgba(138, 43, 226, 0.4); /* 그림자 추가 */
    font-weight: 700; /* 더 두꺼운 폰트 */
    /* 활성화된 탭 하단 강조 효과 */
    border-bottom: 3px solid #f0f0f0; /* 강한 하단 테두리 */
}
body .apt-tabs .tab-item.active:active {
    transform: translateY(0); /* 클릭 시 원위치 */
    box-shadow: 0 1px 8px rgba(138, 43, 226, 0.3); /* 그림자 약화 */
}
.artist-avatar-placeholder {
    /* 1. 컨테이너 기본 스타일 설정 */
    width: 60px; /* 원하는 크기로 조절하세요 */
    height: 60px; /* width와 동일한 값으로 설정 */
    position: relative; /* 자식 요소의 기준점이 됨 */

    /* 2. 원형으로 만들기 */
    border-radius: 50%;

    /* 3. 내부 이미지가 원을 벗어나지 않도록 설정 */
    overflow: hidden;

    /* 이미지가 로드되기 전이나 없을 때를 위한 배경색 (선택 사항) */
    background-color: #f0f0f0;
}
.artist-avatar-placeholder img {
    /* 4. 이미지가 컨테이너를 꽉 채우도록 설정 */
    width: 100%;
    height: 100%;

    /* 5. 이미지 비율을 유지하면서 잘리지 않도록 채우기 (가장 중요한 속성) */
    object-fit: cover;
}
.entertainment-goods-sidebar {
    background: linear-gradient(135deg, #8B5CF6 0%, #A855F7 50%, #9333EA 100%);
    border-radius: 20px;
    padding: 0;
    box-shadow: 0 20px 40px rgba(139, 92, 246, 0.3);
    overflow: hidden;
    position: relative;
    margin-bottom: 20px;
    border: 2px solid rgba(255, 255, 255, 0.1);
}
.entertainment-goods-sidebar::before {
    content: "";
    position: absolute;
    top: -50%;
    right: -50%;
    width: 100%;
    height: 100%;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
    animation: floatAnimation 6s ease-in-out infinite;
    pointer-events: none;
}
@keyframes floatAnimation {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    50% { transform: translateY(-10px) rotate(5deg); }
}
.goods-sidebar-header {
    padding: 20px 20px 15px;
    text-align: center;
    position: relative;
    z-index: 2;
}
.sidebar-title {
    color: white;
    font-size: 18px;
    font-weight: 700;
    margin: 0 0 5px 0;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}
.sidebar-title i {
    color: #FCD34D;
    animation: sparkle 2s ease-in-out infinite;
}
@keyframes sparkle {
    0%, 100% { transform: scale(1) rotate(0deg); }
    50% { transform: scale(1.2) rotate(180deg); }
}
.sidebar-subtitle {
    color: rgba(255, 255, 255, 0.8);
    font-size: 12px;
    font-weight: 400;
}
.enhanced-carousel {
    margin: 0 15px;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    background: white;
    position: relative;
}
.enhanced-carousel-inner {
    border-radius: 15px;
}
.enhanced-carousel-item {
    position: relative;
    transition: all 0.5s ease;
}
.goods-link {
    display: block;
    text-decoration: none;
    color: inherit;
    transition: all 0.3s ease;
}

.goods-link:hover {
    text-decoration: none;
    color: inherit;
    transform: scale(1.02);
}
.goods-image-container {
    position: relative;
    overflow: hidden;
    height: 250px;
}
.goods-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}
.goods-link:hover .goods-image {
    transform: scale(1.1);
}
.image-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(139, 92, 246, 0.8), rgba(168, 85, 247, 0.8));
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: all 0.3s ease;
}
.goods-link:hover .image-overlay {
    opacity: 1;
}
.overlay-content {
    color: white;
    text-align: center;
    transform: translateY(20px);
    transition: transform 0.3s ease;
}
.goods-link:hover .overlay-content {
    transform: translateY(0);
}
.overlay-content i {
    font-size: 24px;
    margin-bottom: 8px;
    display: block;
}
.overlay-content span {
    font-size: 14px;
    font-weight: 600;
}
/* 상품명 영역 */
.enhanced-title {
    background: linear-gradient(135deg, #FFFFFF 0%, #F8FAFC 100%);
    padding: 15px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-top: 1px solid rgba(139, 92, 246, 0.1);
    min-height: 60px;
}
.title-content {
    color: #1F2937;
    font-weight: 600;
    font-size: 14px;
    line-height: 1.4;
    flex: 1;
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}
.title-decoration {
    margin-left: 10px;
    color: #8B5CF6;
    font-size: 16px;
    opacity: 0.7;
    transition: all 0.3s ease;
}
.goods-link:hover .title-decoration {
    opacity: 1;
    transform: scale(1.2);
    color: #EC4899;
}
/* 인디케이터 */
.entertainment-indicators {
    bottom: -35px;
    margin-bottom: 0;
}
.entertainment-indicators button {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background-color: rgba(255, 255, 255, 0.5);
    border: 2px solid rgba(255, 255, 255, 0.7);
    margin: 0 4px;
    transition: all 0.3s ease;
}
.entertainment-indicators button.active {
    background-color: #000;
    border-color: #000;
    transform: scale(1.2);
    box-shadow: 0 0 10px rgba(252, 211, 77, 0.5);
}
/* 컨트롤 버튼 */
.entertainment-control {
    width: 40px;
    height: 40px;
    background: rgba(255, 255, 255, 0.9);
    border-radius: 50%;
    border: none;
    opacity: 0;
    transition: all 0.3s ease;
    backdrop-filter: blur(10px);
}
.enhanced-carousel:hover .entertainment-control {
    opacity: 1;
}
.entertainment-control:hover {
    background: white;
    box-shadow: 0 5px 15px rgba(139, 92, 246, 0.3);
    transform: scale(1.1);
}
.control-icon {
    color: #8B5CF6;
    font-size: 18px;
    font-weight: bold;
}
/* 사이드바 푸터 */
.goods-sidebar-footer {
    padding: 15px 20px 20px;
    text-align: center;
    position: relative;
    z-index: 2;
}
.footer-sparkles {
    color: white;
    font-size: 12px;
    font-weight: 500;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    padding: 8px 15px;
    border-radius: 20px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
}
.footer-sparkles:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-2px);
}
.footer-sparkles i:first-child {
    color: #FCD34D;
    animation: twinkle 1.5s ease-in-out infinite;
}
@keyframes twinkle {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.5; transform: scale(0.8); }
}
.footer-sparkles i:last-child {
    transition: transform 0.3s ease;
}
.footer-sparkles:hover i:last-child {
    transform: translateX(3px);
}
.entertainment-goods-sidebar:hover {
    transform: translateY(-3px);
    box-shadow: 0 25px 50px rgba(139, 92, 246, 0.4);
}
/* 반응형 디자인 */
@media (max-width: 768px) {
    .entertainment-goods-sidebar {
        border-radius: 15px;
    }

    .goods-sidebar-header {
        padding: 15px 15px 10px;
    }

    .sidebar-title {
        font-size: 16px;
    }

    .enhanced-carousel {
        margin: 0 10px;
    }

    .goods-image-container {
        height: 200px;
    }

    .enhanced-title {
        padding: 12px;
        min-height: 50px;
    }

    .title-content {
        font-size: 13px;
    }
}

/* 로딩 애니메이션 */
.enhanced-carousel-item.active .goods-image {
    animation: slideInFade 0.8s ease-out;
}

@keyframes slideInFade {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
.sidebar-widget {
    /* --- ↓↓↓ 변경 시작 ↓↓↓ --- */
    background: rgba(255, 255, 255, 0.1); /* 연한 투명 배경 */
    backdrop-filter: blur(10px); /* 배경 블러 효과 추가 */
    border: 1px solid rgba(255, 255, 255, 0.2); /* 은은한 흰색 테두리 */
    border-radius: 15px; /* 더 둥근 모서리로 부드러운 느낌 */
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3); /* 더 깊고 넓은 그림자 */
   	box-shadow: 0 10px 40px rgba(138, 43, 226, 0.3), /* 보라색 계열의 더 넓고 깊은 그림자 */
                0 0 15px rgba(255, 255, 255, 0.1) inset; /* 위젯 내부에 은은한 빛 효과 */
    transition: all 0.3s ease-out;
    padding: 20px; /* 기존 패딩 유지 */
    margin-bottom: 20px; /* 기존 하단 마진 유지 */
    overflow: hidden; /* 내부 요소가 넘치지 않도록 */
}
.sidebar-widget h3 { font-size: 1.3em; color: #ffffff; margin-top: 0; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid rgba(255, 255, 255, 0.3); text-shadow: 0 1px 3px rgba(0, 0, 0, 0.2); }
.apt-level-widget .apt-floor-display { font-size: 1.5em; font-weight: bold; color: #ffffff; text-align: center; margin-bottom: 5px; text-shadow: 0 0 10px rgba(138, 43, 226, 0.7), 0 0 20px rgba(138, 43, 226, 0.5);}
.fan-count-tooltip-wrapper { position: relative; text-align: center; }
.apt-level-widget .fan-count-display { font-size: 1em; color: rgba(255, 255, 255, 0.7); cursor: default; display: inline-block; }
.fan-count-tooltip {
    visibility: hidden;
    width: auto;
    min-width: 100px;
    background-color: rgba(0, 0, 0, 0.7); /* 더 투명한 검은색 배경 */
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 8px 10px;
    position: absolute;
    z-index: 10;
    bottom: 125%;
    left: 50%;
    transform: translateX(-50%);
    opacity: 0;
    transition: opacity 0.2s, visibility 0s linear 0.2s;
    white-space: nowrap;
    font-size: 0.85em;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4); /* 그림자 강조 */
    border: 1px solid rgba(255, 255, 255, 0.1); /* 은은한 테두리 추가 */
}
.fan-count-tooltip::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: rgba(0, 0, 0, 0.7) transparent transparent transparent; /* 배경색과 동일하게 변경 */
}
.fan-count-tooltip-wrapper:hover .fan-count-tooltip {
    visibility: visible;
    opacity: 1;
    transition: opacity 0.2s;
}
.membership-widget { text-align: center;
    background: rgba(255, 255, 255, 0.15); /* 조금 더 불투명한 투명 배경 */
    border: 1px solid rgba(255, 255, 255, 0.3); }
.membership-widget .membership-icon { font-size: 1.8em; color: #ffffff; margin-bottom: 8px; text-shadow: 0 0 15px rgba(138, 43, 226, 0.8), 0 0 25px rgba(138, 43, 226, 0.6); }
.membership-widget h3 { font-size: 1.3em; color: #ffffff; margin-bottom: 8px; border-bottom: none; }
.membership-widget p { font-size: 1.1em; color: rgba(255, 255, 255, 0.9); margin-bottom: 15px; line-height: 1.5; }
.membership-widget .btn-join-membership {
    display: block;
    width: 100%;
    padding: 12px;

    /* 기본 배경을 요청하신 밝은 그라데이션으로 변경 */
    background: linear-gradient(45deg, #e6b3ff, #8a2be2); /* 원래 hover에 있던 밝은 그라데이션 */

    color: white; /* 텍스트 흰색 */
    text-decoration: none;
    border-radius: 8px;
    font-weight: bold;
    font-size: 1em;
    border: 1px solid #ffffff; /* 흰색 테두리 추가 */

    /* 그림자를 더 강조하고 보라색 계열로 변경 */
    box-shadow: 0 5px 15px rgba(138, 43, 226, 0.5); /* 그림자 강조 및 색상 변경 */

    transition: all 0.3s ease; /* 부드러운 전환 효과 */
}

/* 호버 효과는 더 강조되도록 변경 (선택 사항, 필요에 따라 조정) */
.membership-widget .btn-join-membership:hover {
    background: linear-gradient(45deg, #a855f7, #9333ea); /* 호버 시 살짝 더 진한 그라데이션 */
    box-shadow: 0 10px 30px rgba(138, 43, 226, 0.8); /* 호버 시 그림자 더 강조 */
    transform: translateY(-3px); /* 살짝 떠오르는 효과 */
    border-color: rgba(255, 255, 255, 0.8); /* 호버 시 테두리 선명하게 */
}
.membership-widget .btn-join-membership span.arrow { margin-left: 5px; }
.btn-view-membership {
    background: linear-gradient(135deg, #e6b3ff 0%, #8a2be2 100%);
    border: 1px solid #ffffff;
    border-radius: 10px; /* 둥근 모서리 */
    color: white; /* 텍스트 색상 흰색 */
    font-weight: bold; /* 텍스트 두껍게 */
    font-size: 1.05em; /* 글자 크기 살짝 키움 */
    text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3); /* 텍스트 그림자 */
    padding: 12px 25px; /* 패딩으로 버튼 크기 조절 */
    display: inline-flex; /* 내부 요소 정렬을 위해 flexbox 사용 */
    align-items: center; /* 세로 중앙 정렬 */
    gap: 8px; /* 텍스트와 화살표 사이 간격 */
    cursor: pointer;
    text-decoration: none; /* 밑줄 제거 (a 태그일 경우) */
    transition: all 0.3s ease; /* 모든 속성에 부드러운 전환 효과 */
    box-shadow: 0 5px 15px rgba(138, 43, 226, 0.5);
    margin-top: 10px;
}
.btn-view-membership .arrow {
    font-size: 1.2em; /* 화살표 크기 조절 */
    transition: transform 0.3s ease; /* 화살표 이동 애니메이션 */
}
.btn-view-membership:hover {
    background: linear-gradient(135deg, #a855f7 0%, #9333ea 100%);
    border-color: rgba(255, 255, 255, 0.8); /* 호버 시 테두리 더 선명하게 */
    box-shadow: 0 8px 30px rgba(138, 43, 226, 0.7); /* 호버 시 보라색 그림자 강조 */
    transform: translateY(-3px); /* 버튼 살짝 위로 떠오르는 효과 */
}
.btn-view-membership:hover .arrow {
    transform: translateX(5px); /* 호버 시 화살표 살짝 오른쪽으로 이동 */
}
body .post-card, .comment-list-item, .comment-list-item .card{
    background: rgba(255, 255, 255, 0.08);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    margin-bottom: 20px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.25);
    border: 1px solid rgba(255, 255, 255, 0.15);
    padding: 20px;
    transition: all 0.3s ease;
    overflow: hidden;
    position: relative;
    z-index: 1;
}
body .post-card .post-body img {
	width: auto;
    max-width: 100%; /* 이미지가 부모 요소(feed-item)의 너비를 넘지 않도록 합니다. */
    height: 400px; /* 이미지의 원래 비율을 유지하며 높이를 자동 조정합니다. */
    display: block; /* 이미지 하단에 불필요한 여백을 제거합니다. */
    margin: 0 auto 5px auto;
    border-radius: 10px; /* (선택 사항) 피드 아이템의 둥근 모서리와 어울리게 이미지도 둥글게 */
    object-fit: contain;
    z-index: 2;
    position: relative;
}
body .post-card .card-header{
	display: flex;
    align-items: center;
    margin-bottom: 15px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    padding-bottom: 15px;
    font-size: medium;
}
body .post-card p,
body .post-card strong,
body .post-card small,
body .post-card span,
body .comment-list-item p,
body .comment-list-item strong,
body .comment-list-item small,
body .comment-list-item span{
	color : #fff;
}
</style>
</head>

<body>
	<sec:authorize access="hasAnyRole('MEMBER','ARTIST')">
		<sec:authentication property="principal" var="user"/>
	</sec:authorize>
	<%@ include file="../../modules/communityHeader.jsp"%>
	<ul class="nav apt-tabs" id="comuTab" role="tabList">
		<li class="nav-item" role="presentation"><a class="tab-item"
			href="${pageContext.request.contextPath}/community/gate/${artGroupNo}/apt#artistPostList">아티스트</a>
		</li>
		<li class="nav-item" role="presentation"><a class="tab-item"
			href="${pageContext.request.contextPath}/community/gate/${artGroupNo}/apt#fanPostList">팬</a>
		</li>
		<li class="nav-item" role="presentation"><a class="tab-item"
			href="${pageContext.request.contextPath}/community/gate/${artGroupNo}/apt#liveArea">라이브</a>
		</li>
		<li class="nav-item" role="presentation"><a class="tab-item"
			href="${pageContext.request.contextPath}/community/gate/${artGroupNo}/apt#scheduleList">스케쥴</a>
		</li>
		<li class="nav-item" role="presentation"><a class="tab-item"
			href="${pageContext.request.contextPath}/community/gate/${artGroupNo}/apt#noticeAptList">공지사항</a>
		</li>
	</ul>

	<main class="profile-main container py-4 d-flex gap-3">
		<aside class="apt-sidebar">
		    <div class="sidebar-widget goods-widget entertainment-goods-sidebar pt-3">
		        <!-- 헤더 추가 -->

		        <div id="carouselExampleFade" class="carousel slide carousel-fade enhanced-carousel" data-bs-ride="carousel" data-bs-interval="4000">

		            <div class="carousel-inner enhanced-carousel-inner">
		                <c:forEach items="${thumnailImages }" var="img" varStatus="i">
		                    <a href="${pageContext.request.contextPath}/goods/detail?goodsNo=${img.goodsNo }" class="goods-link">
		                        <div class="carousel-item enhanced-carousel-item <c:if test="${i.index == 0 }">active</c:if>" data-bs-interval="5000">
		                            <div class="goods-image-container">
		                                <img src="${img.representativeImageFile.webPath }" class="d-block w-100 goods-image" alt="${img.goodsNm}">
		                                <div class="image-overlay">
		                                    <div class="overlay-content">
		                                        <i class="bi bi-eye-fill"></i>
		                                        <span>자세히 보기</span>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="carousel-item-title enhanced-title">
		                                <div class="title-content">
		                                    <c:out value="${img.goodsNm }" />
		                                </div>
		                            </div>
		                        </div>
		                    </a>
		                </c:forEach>
		            </div>

		            <!-- 컨트롤 버튼 추가 -->
		            <button class="carousel-control-prev entertainment-control" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev" style="top: 40%">
		                <i class="bi bi-chevron-left control-icon"></i>
		                <span class="visually-hidden">이전</span>
		            </button>
		            <button class="carousel-control-next entertainment-control" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next" style="top: 40%">
		                <i class="bi bi-chevron-right control-icon"></i>
		                <span class="visually-hidden">다음</span>
		            </button>
		        </div>

		        <!-- 푸터 추가 -->
		        <div class="goods-sidebar-footer" onclick="toGoodsShop()">
		            <div class="footer-sparkles">
		                <i class="bi bi-stars"></i>
		                <span>더 많은 굿즈 보러가기</span>
		                <i class="bi bi-arrow-right"></i>
		            </div>
		        </div>
		    </div>
		</aside>
		<div class="row g-4 w-100">

			<div class="col-12 col-md">
				<header class="apt-header">
	                <div class="apt-header-avatar">
	                    <div class="artist-avatar-placeholder"><img alt="" src="${profileVO.comuProfileImg}"> </div>
	                </div>
	                <div class="apt-header-info">
	                	<input type="hidden" id="artistGroupProfileImg" value="${profileVO.comuProfileImg}">
	                    <h2 class="d-flex gap-2">
	                    	<c:out value="${profileVO.comuNicknm }" />
	                   	</h2>
						<sec:authorize access="hasRole('MEMBER')">
							<c:if test="${myComuProfileNo eq profileVO.comuProfileNo}">
								<button class="btn btn-warning btn-sm"
									data-comu-profile-no="${profileVO.comuProfileNo}"
									data-comu-nicknm="${profileVO.comuNicknm}"
									data-comu-profile-img="${profileVO.comuProfileImg}"
									data-art-group-no="${profileVO.artGroupNo}"
									data-bs-target="#commProfileModal" data-bs-toggle="modal">
									프로필 수정
								</button>
							</c:if>
						</sec:authorize>
	                </div>
	            </header>

				<nav class="profile-tabs mb-4">
					<div class="nav nav-pills nav-fill" id="nav-tab" role="tablist">
						<button class="nav-link active" id="posts-tab"
							data-bs-toggle="tab" data-bs-target="#postsTabContent"
							type="button" role="tab" aria-controls="postsTabContent"
							aria-selected="true" data-tab="posts">포스트</button>
						<button class="nav-link" id="comments-tab" data-bs-toggle="tab"
							data-bs-target="#commentsTabContent" type="button" role="tab"
							aria-controls="commentsTabContent" aria-selected="false"
							data-tab="comments">댓글</button>
					</div>
				</nav>

				<div class="tab-content" id="nav-tabContent">
					<section class="profile-tab-content tab-pane fade show active"
						id="postsTabContent" role="tabpanel" aria-labelledby="posts-tab">
						<c:choose>
							<c:when
								test="${empty profileVO.postList or profileVO.postList[0].comuPostNo eq 0}">
								<div class="alert alert-info text-center py-4" role="alert">아직
									작성한 포스트가 없습니다.</div>
							</c:when>
							<c:otherwise>
								<div class="posts-list-container">
									<c:forEach items="${profileVO.postList}" var="post">
										<div class="card post-card mb-4"
											id="post-${post.comuPostNo}">
											<div class="card-header pb-0 pt-3 px-3">
												<div
													class="d-flex align-items-center justify-content-between w-100">
													<a
														href="${pageContext.request.contextPath}/community/${post.artGroupNo}/profile/${post.writerProfile.comuProfileNo}"
														style="text-decoration: none; color: black;">
														<div class="d-flex align-items-center">
															<img src="${post.writerProfile.comuProfileImg}"
																class="rounded-circle comment-avatar" alt="프로필 이미지"
																style="width: 40px; height: 40px; object-fit: cover;">
															<div class="ms-2">
																<div>
																	<strong >${post.writerProfile.comuNicknm}</strong>
																	<c:if test="${post.comuPostMbspYn eq 'Y' }">
																		<span class="ml-2 badge text-bg-purple rounded-pill">멤버쉽전용</span>
																	</c:if>
																</div>
																<small> <fmt:formatDate value="${post.comuPostModDate}" pattern="yyyy.MM.dd HH:mm" /> </small>
															</div>
														</div>
													</a>
													<div class="dropdown">
														<c:if test="${not( post.comuPostMbspYn eq 'Y' and post.writerProfile.comuProfileNo ne myComuProfileNo and (not membershipFlag)) }">
														<button class="btn btn-link text-secondary p-0"
															type="button" data-bs-toggle="dropdown"
															aria-expanded="false">
															<i class="bi bi-three-dots-vertical"></i>
														</button>
														<ul class="dropdown-menu">
															<c:if
																test="${post.writerProfile.comuProfileNo == myComuProfileNo}">
																<li>
																	<button class="dropdown-item postUpdateBtn"
																		data-bs-toggle="modal"
																		data-bs-target="#postUpdateModal"
																		data-comu-post-no="${post.comuPostNo}"
																		data-comu-post-content="${post.comuPostContent}"
																		data-file-group-no="${post.fileGroupNo}">수정</button>
																</li>
																<li><button
																		class="dropdown-item text-danger postDeleteBtn"
																		data-comu-post-no="${post.comuPostNo}">삭제</button></li>
															</c:if>
															<c:if test="${post.writerProfile.comuProfileNo != myComuProfileNo}">

																<li>
																	<button class="dropdown-item text-danger postReportBtn"
																			data-comu-post-no="${post.comuPostNo}"
																			data-bs-comuPostNo="${post.comuPostNo}"
																			data-bs-boardType="${post.boardTypeCode}"
																			data-bs-comuProfileNo="${post.writerProfile.comuProfileNo}"
																			data-bs-comuNick="${post.writerProfile.comuNicknm}"
																			data-bs-comuContent="${post.comuPostContent}"
																			data-bs-toggle="modal" data-bs-target="#reportModal"
																			data-bs-selectType="RTTC001"
																	>
																		신고
																	</button>
																</li>

															</c:if>
														</ul>
														</c:if>
													</div>
												</div>
											</div>

											<div class="card-body detailBox"
											<c:if test="${not( post.comuPostMbspYn eq 'Y' and post.writerProfile.comuProfileNo ne myComuProfileNo and (not membershipFlag)) }">
												style="cursor: pointer;"
												data-comu-post-no="${post.comuPostNo}"
												data-comu-post-mbsp-yn="${post.comuPostMbspYn}"
												data-comu-profile-no="${post.comuProfileNo}"
												data-bs-toggle="modal" data-bs-target="#postModal"
											</c:if>
											>
												<c:if test="${post.comuPostMbspYn eq 'Y' and post.writerProfile.comuProfileNo ne myComuProfileNo and (not membershipFlag) }">
													<div style="position: absolute; width:100%; height:100%; backdrop-filter:blur(10px); border-radius:10px; z-index:100;"></div>
												</c:if>
												<c:if test="${not empty post.postFiles}">
													<div
														class="post-images-container ${fn:length(post.postFiles) == 1 ? 'single-img' : ''} mb-2">
														<c:forEach items="${post.postFiles}" var="file" begin="0"
															end="1">
															<img src="${file.webPath}"
																class="post-single-img img-fluid rounded" alt="게시물 이미지">
														</c:forEach>
													</div>
												</c:if>
												<p class="card-text post-content post-content-text mb-0">
													<c:if test="${fn:length(post.comuPostContent) > 100}">
                                                    ${fn:substring(post.comuPostContent,0,100)}... <span
															class="text-primary small fw-bold">더 보기</span>
													</c:if>
													<c:if test="${fn:length(post.comuPostContent) <= 100}">
                                                    ${post.comuPostContent}
                                                </c:if>
												</p>
											</div>

											<hr class="my-3 mx-3">

											<div
												class="post-meta-bottom d-flex justify-content-start align-items-center px-3 pb-3">
												<span
													class="post-likes text-danger me-4 icon-text <c:if test="${post.likeYn eq 'Y'}">active</c:if>"
													style="cursor: pointer;"
													data-comu-post-no="${post.comuPostNo}"
													data-comu-writer-profile-no="${post.writerProfile.comuProfileNo}"
													data-comu-profile-no="${myComuProfileNo}"
													data-comu-post-mbsp-yn="${post.comuPostMbspYn}"
													<c:if test="${not( post.comuPostMbspYn eq 'Y' and post.writerProfile.comuProfileNo ne myComuProfileNo and (not membershipFlag)) }">
													data-board-type-code="${post.boardTypeCode}"
													data-art-group-no="${post.artGroupNo}"
													data-like-yn="${post.likeYn}"
													</c:if>
													>
													<c:set var="heart" value="bi-heart" />
													<c:if
														test="${post.likeYn eq 'Y' }">
														<c:set var="heart" value="bi-heart-fill" />
													</c:if>
													<i class="bi ${heart}"></i>
													<span class="ms-1 likeCount">${post.comuPostLike}</span>
												</span>
												<span class="post-comments text-info icon-text"
												<c:if test="${not( post.comuPostMbspYn eq 'Y' and post.writerProfile.comuProfileNo ne myComuProfileNo and (not membershipFlag)) }">
													style="cursor: pointer;" data-bs-toggle="modal"
													data-bs-target="#postModal"
													data-comu-post-no="${post.comuPostNo}"
													data-comu-post-mbsp-yn="${post.comuPostMbspYn}"
													data-comu-profile-no="${post.comuProfileNo}"
												</c:if>
												>
													<i class="bi bi-chat"></i> <span class="ms-1">${post.comuPostReplyCount}</span>
												</span>
											</div>
										</div>
									</c:forEach>
								</div>
							</c:otherwise>
						</c:choose>
					</section>

					<section class="profile-tab-content tab-pane fade"
						id="commentsTabContent" role="tabpanel"
						aria-labelledby="comments-tab">
						<c:choose>
							<c:when test="${empty profileVO.replyList}">
								<div class="alert alert-info text-center py-4" role="alert">아직
									작성한 댓글이 없습니다.</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${profileVO.replyList}" var="reply">
									<div class="comment-list-item mb-3">
										<div class="card">
											<div class="card-body detailBox"
												id="reply-${reply.comuReplyNo}" style="cursor: pointer;"
												data-comu-post-no="${reply.comuPostNo}"
												data-comu-reply-no="${reply.comuReplyNo}"
												data-bs-toggle="modal" data-bs-target="#postModal">
												<div
													class="d-flex align-items-start mb-2 p-2 rounded">
													<span> <i
														class="bi bi-chat-square-text-fill text-primary me-2"></i>
													</span>
													<div class="d-flex flex-column flex-grow-1">
														<span class="fw-bold mb-1">${reply.comuPostContent}</span>
														<small class="fw-normal">${reply.postMember.comuNicknm}</small>
													</div>
												</div>
												<hr class="my-2" />
												<div class="p-2">
													<p class="card-text mb-0">
														<i class="bi bi-reply-fill text-info me-2"></i>
														${reply.comuReplyContent}
													</p>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</section>
				</div>
			</div>

			<div class="col-lg-4 d-md-block">
				<aside class="apt-sidebar">
		            <div class="sidebar-widget apt-level-widget">
		                <h3>APT 현황</h3>
		                <div class="apt-floor-display" id="aptFloorDisplay">
		                	<!-- 1. div 연산자를 사용하여 10명당 1층으로 계산 (정수 나눗셈) -->
		                	<c:set var="aptFloor" value="${artistGroupVO.communityVO.totalFan div 10 } "/>

		                	<fmt:formatNumber value="${aptFloor }" pattern="#,###,###"/>층
		                </div>


		                <div class="fan-count-tooltip-wrapper"> <p class="fan-count-display">팬 <span id="sidebarFanCountApprox">
		                	<fmt:formatNumber value="${artistGroupVO.communityVO.totalFan}" pattern="#,###,###"></fmt:formatNumber> </span>명</p>
		                </div>
		            </div>
		            <c:if test="${not empty membershipInfo }">
			            <div class="sidebar-widget membership-widget">
			                <div class="membership-icon">🛡️</div>
			                <h3>Membership</h3>
			                <c:choose>
			                	<c:when test="${hasMembership }">
			                		<p><strong>멤버십에 가입되어 있습니다!</strong></p>
			                		<p>특별한 컨텐츠를 즐겨보세요.</p>
			                		<button class="btn-view-membership" onclick="location.href='${pageContext.request.contextPath}/mypage/memberships'" style="cursor:pointer;">
					                나의 멤버십 보기 <span class="arrow">&gt;</span>
					            </button>
			                	</c:when>
			                	<c:otherwise>
			                		<p>지금 멤버십에 가입하고, 특별한 혜택을 누려보세요.</p>
					                <button class="btn-join-membership" id="openMembershipModalBtn" data-bs-toggle="modal" data-bs-target="#membershipModalOverlay">
					                    멤버십 가입하기 <span class="arrow">&gt;</span>
					                </button>
			                	</c:otherwise>
			                </c:choose>
			            </div>
					</c:if>
		         </aside>
			</div>
		</div>
	</main>

	<div id="footer-placeholder"></div>
	<div class="modal fade" id="postModal" tabindex="-1"
		aria-labelledby="postModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen-custom">
			<button type="button" class="btn-close btn-close-white"
				data-bs-dismiss="modal" aria-label="Close"></button>

			<div class="modal-content">
				<div class="modal-body p-0">
					<div class="d-flex h-100">

						<div class="post-pane" id="postBox"></div>

						<div class="comment-pane">
							<div class="comment-pane-header">
								<strong class="mx-auto" id="replyCount"></strong>
							</div>

							<div class="comment-pane-body" id="replyContent"></div>

							<div class="comment-pane-footer">
								<form id="replyForm">
									<input type="hidden" id="myComuProfileNo"
										name="myComuProfileNo" value="${myComuProfileNo}" /> <input
										type="hidden" id="boardTypeCode" name="boardTypeCode" /> <input
										type="hidden" id="comuPostNo" name="comuPostNo" /> <input
										type="hidden" id="artGroupNo" name="artGroupNo" />
									<div class="input-group">
										<textarea class="form-control" id="comuReplyContent"
											placeholder="댓글을 입력하세요." aria-label="댓글 입력" rows="1"
											style="resize: none;"></textarea>
										<button class="btn btn-primary" type="button"
											id="commentSubmitBtn">등록</button>
									</div>
								</form>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 본문 수정 모달 -->
	<div class="modal fade" id="postUpdateModal" tabindex="-1"
		aria-labelledby="postUpdateModal" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen-custom">
			<button type="button" class="btn-close btn-close-white"
				data-bs-dismiss="modal" aria-label="Close"></button>

			<div class="modal-content">
				<div class="modal-body p-0">
					<div class="h-100">
						<div class="post-pane" id="postUpdateModalContentBox">
							<form id="updateForm">
								<div class="p-3">
									<h4>게시물 수정</h4>
									<input type="hidden" name="comuPostNo" id="updatePostNo">
									<input type="hidden" name="fileGroupNo" id="fileGroupNo">
									<div class="mb-3">
										<label for="updatePostContent" class="form-label">내용</label>
										<div id="previewContainer"></div>
										<textarea class="form-control" id="updatePostContent"
											name="comuPostContent" rows="10"></textarea>
									</div>
									<div class="form-check form-check-reverse mb-3">
										<label class="form-check-label" for="checkMbspYn"> 멤버쉽 전용 여부</label>
										<input class="form-check-input" type="checkbox"
											value="" name="comuPostMbspYn" id="checkMbspYn">
									</div>
									<div class="mb-3">
										<label for="updatePostFiles" class="form-label">첨부파일</label> <input
											type="file" class="form-control" id="updatePostFiles"
											name="files" accept="image/*" multiple />
									</div>

									<div class="d-flex justify-content-end gap-2">
										<button type="button" class="btn btn-success"
											id="savePostUpdateBtn">저장</button>
										<button type="button" class="btn btn-secondary"
											data-bs-toggle="modal" id="cancelPostUpdateBtn">취소</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 신고모달 -->
	<div class="modal fade" id="reportModal" tabindex="-1"
		aria-labelledby="reportModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<div class="modal-header bg-light">
					<h5 class="modal-title primary fw-bold" id="reportModalLabel">신고하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div class="modal-body pb-0">
					<form id="reportForm" method="post">
						<input type="hidden" name="targetComuPostNo" id="targetComuPostNo">
						<input type="hidden" name="targetBoardTypeCode"
							id="targetBoardTypeCode"> <input type="hidden"
							name="targetComuReplyNo" id="targetComuReplyNo" value="">
						<input type="hidden" name="artGroupNo" id="reportArtGroupNo">
						<input type="hidden" name="targetComuProfileNo"
							id="targetComuProfileNo"> <input type="hidden"
							name="reportTargetTypeCode" id="reportTargetTypeCode">

						<div class="mb-4">
							<label class="form-label fw-bold mb-2">신고 사유를 선택해주세요:</label>
							<div class="radioArea d-flex gap-2 flex-wrap ">
								<!--
					<div class="form-check">
		                <input class="btn-check" type="radio" name="reportReasonCode" id="\${reasonCode.commCodeDetNm}" value="\${reasonCode.commCodeDetNo}">
		                <label class="btn btn-outline-primary" for="\${reasonCode.commCodeDetNm}">\${reasonCode.description}</label>
		            </div>
				 -->
							</div>
						</div>

						<div class="mb-3">
							<label for="targetNick" class="form-label text-muted">신고
								처리 대상:</label> <input type="text" class="form-control" id="targetNick"
								disabled />
						</div>

						<div class="mb-4">
							<label for="targetContent" class="form-label text-muted">처리
								내용:</label>
							<textarea class="form-control" id="targetContent" rows="3"
								disabled></textarea>
						</div>
					</form>
				</div>

				<div class="modal-footer justify-content-end border-top-0">
					<button type="button" class="btn btn-primary px-4"
						id="reportSendBtn">신고하기</button>
					<button type="button" class="btn btn-outline-secondary px-4"
						data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 닉네임 입력 모달 -->
	<div class="modal fade" id="commProfileModal" tabindex="-1"
		aria-labelledby="nicknameModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="commProfileModalLabel">새로운 프로필로 바꿔보세요!</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3 d-flex justify-content-center align-items-center">
						<div class="profile-img-box" id="previewImgBox"
							style="width: 100px; height: 100px; border-radius: 50%; cursor: pointer; overflow: hidden;">
							<img alt="프로필이미지"
								src="${pageContext.request.contextPath}/upload/profile/base/defaultImg.png"
								id="previewImg" style="height: 100px; width:100%;">
						</div>
					</div>
					<div class="mb-3">
						<label for="comuNicknm" class="form-label">닉네임</label> <input
							type="text" class="form-control" id="comuNicknm"
							name="comuNicknm" maxlength="12" placeholder="12자 이내로 입력하세요">
					</div>

					<div class="mb-3">
						<label for="imgFile" class="form-label">프로필 이미지</label> <input
							class="form-control" type="file" id="imgFile" name="imgFile"
							accept="image/*">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="profileSubmitBtn">저장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 멤버쉽 가입 -->
	<div class="modal fade" id="membershipModalOverlay" tabindex="-1" aria-labelledby="membershipModalLabel" aria-hidden="true"
     	data-artist-group-no="${membershipInfo.artGroupNo }"
     	data-membership-goods-no="${artistGroupVO.membershipGoodsNo}">
        <div class="modal-dialog modal-xl">
	        <div class="modal-content membership-modal">
	            <button class="modal-close-btn" id="closeMembershipModalBtn" aria-label="Close" data-bs-dismiss="modal">&times;</button>
	            <div class="modal-header">
	                <h2>${membershipInfo.mbspNm }</h2>
	                <p class="membership-duration">이용 기간: 결제일로부터 ${membershipInfo.mbspDuration}일</p>
	            </div>
	            <div class="modal-body">
	                <div class="membership-main-image">
	                </div>
	                <h3>주요 혜택 안내</h3>
	                <ul class="modal-benefits-list">
	                    <li>✔️ 멤버십 전용 콘텐츠 이용 가능 (일부 블러 처리된 콘텐츠 즉시 해제!)</li>
	                    <li>🗓️ APT 메인 상단에서 아티스트 구독일 D-Day 확인</li>
	                    <li>🎤 콘서트/팬미팅 선예매 및 특별 이벤트 참여 기회</li>
	                    <li>🎁 한정판 멤버십 키트 제공 (별도 구매 또는 등급에 따라)</li>
	                </ul>

	                <h3>이용 안내 및 유의사항</h3>
	                <ul class="modal-notes-list">
	                    <li>본 멤버십은 비용을 선지불하여 이용하는 유료 서비스입니다.</li>
	                    <li>멤버십은 아티스트(솔로, 그룹)별로 별도 운영되며, 본 멤버십은 [${artistGroupVO.artGroupNm }] 전용입니다.</li>
	                    <li>그룹 내 솔로 활동 멤버 발생 시, 해당 멤버의 커뮤니티는 별도 생성/운영될 수 있습니다.</li>
	                    <li>자세한 내용은 구매 페이지의 약관을 참고해주세요.</li>
	                </ul>
	            </div>
	            <div class="modal-footer">
	                <div class="membership-price">₩ <fmt:formatNumber value="${membershipInfo.mbspPrice}" pattern="###,###"></fmt:formatNumber> <span class="vat-notice">(VAT 포함)</span></div>
	                <button class="btn-modal-purchase" id="goToPurchasePageBtn">멤버십 구매하기</button>
	            </div>
	        </div>
        </div>
    </div>
	<div id="footer">
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/views/modules/communityFooter.jsp" />
        <script src="${pageContext.request.contextPath}/resources/js/pages/communityFooter.js"></script>
        <!-- FOOTER END -->
    </div>
</body>
<script type="text/javascript">

// 탭 전환
document.querySelectorAll('.profile-tabs .tab').forEach(tab => {
  tab.addEventListener('click', function() {
    document.querySelectorAll('.profile-tabs .tab').forEach(t => t.classList.remove('active'));
    this.classList.add('active');
    document.getElementById('postsTab').style.display = this.dataset.tab === 'posts' ? 'block' : 'none';
    document.getElementById('commentsTab').style.display = this.dataset.tab === 'comments' ? 'block' : 'none';
  });
});


//멤버십 가입하기 버튼 이벤트
document.addEventListener('DOMContentLoaded', function () {
	// 멤버십 구매하기 버튼
	const mbspBtn = document.getElementById('openMembershipModalBtn');
	const membershipModal = document.getElementById('membershipModalOverlay');
	const closeModalBtn = document.querySelector('#closeMembershipModalBtn');
	const goToPurchasePageBtn = document.getElementById('goToPurchasePageBtn');
	let artistGroupNo = membershipModal.dataset.artistGroupNo;
	let membershipGoodsNo = parseInt(membershipModal.dataset.membershipGoodsNo);
	// 결제 구현
	goToPurchasePageBtn.addEventListener('click', function() {
		requestKakaoPaySubscription(membershipGoodsNo, artistGroupNo);
	});

	function requestKakaoPaySubscription(goodsNo, artistGroupNo) {
		// 1. 결제할 멤버십 상품 정보 정의
		const orderData = {
				orderItems: [
					{
						goodsNo: goodsNo,
						goodsOptNo: null,
						qty: 1,
						goodsNm: "DDTOWN 아티스트 멤버십",
					}
				],
				singleGoodsName: "DDTOWN 아티스트 멤버십",
				totalAmount: "${membershipInfo.mbspPrice}",
				isFromCart: false,
				orderTypeCode: "OTC001", // 멤버십
				orderPayMethodNm: "카카오페이",
				orderRecipientNm: "${user.memberVO.peoName}",
	            orderRecipientPhone: "${user.memberVO.peoPhone}", // 유효하지 않은 전화번호
	            orderZipCode: "${user.memberVO.memZipCode}", // 더미 우편번호
	            orderAddress1: "${user.memberVO.memAddress1}", // 더미 주소
	            orderAddress2: "${user.memberVO.memAddress2}", // 더미 상세 주소
	            orderEmail: "${user.memberVO.peoEmail}", // 더미 이메일
	            orderMemo: `멤버십 상품 구매 - 아티스트 그룹 번호 : \${artistGroupNo}`
		};

// 		console.log("카카오페이 결제 준비 요청 데이터 : ", orderData);

		const headers = {
				'Content-Type':'application/json',
				'${_csrf.headerName}' : '${_csrf.token}'
		};

		// 2. 백엔드 API 호출
		fetch('/goods/order/pay/ready', {
			method: 'POST',
			headers: headers,
			body: JSON.stringify(orderData)
		})
		.then(response => {
			if(!response.ok) {
				return response.text().then(errorMessage => {
					console.error("백엔드 오류 응답: ", errorMessage);
				});
			}
			return response.json();
		})
		.then(data => {
			const nextRedirectUrl = data.next_redirect_pc_url;

			if(nextRedirectUrl) {
// 				console.log("카카오페이 결제 페이지로 리다이렉트: ", nextRedirectUrl);
				window.location.href = nextRedirectUrl;
				localStorage.setItem("url",window.location.href);
			} else {
// 				console.log("카카오페이 리다이렉트 URL을 받지 못했습니다. 데이터: ", data);
			}
		})
		.catch(error => {
			console.log("카카오페이 결제 준비 중 예외 발생: ", error.message);
		})
	};

});


$(function(){
	const postModal = $("#postModal"); // 해당 포스트 혹은 댓글이달린 원본글을 보여줄 모달

	const hash = window.location.hash;

	if(hash && hash.startsWith("#post-")){
		let comuPostNo = hash.substring(6);
		displayPostModal(comuPostNo)
		postModal.modal("show");
	}

	// 닉네임 및 프로필 사진 수정
	const profileModal = $("#commProfileModal")
	const previewImgBox = $("#previewImgBox");
	const imgFile = $("#imgFile");
	const previewImg = $("#previewImg")
	let file = null;
	profileModal.on("show.bs.modal",function(e){
		let target = e.relatedTarget
		let comuProfileNo = target.getAttribute("data-comu-profile-no");
		let comuNicknm = target.getAttribute("data-comu-nicknm");
		let comuProfileImg = target.getAttribute("data-comu-profile-img");
		let artGroupNo = target.getAttribute("data-art-group-no");

		previewImg.attr("src",comuProfileImg);
		$("#comuNicknm").val(comuNicknm);
		$("#comuProfileNo").val(comuProfileNo);
		profileModal.data("dataInfo",{
			comuProfileNo,comuProfileImg,artGroupNo
		})
	})

	// 프로필 이미지 박스 클릭시 이미지파일 선택
	previewImgBox.on("click",function(){
		imgFile.click();
	})

	// 프로필 이미지 이벤트
	imgFile.on("change",function(){
		let dataInfo = profileModal.data("dataInfo")
		let {comuProfileImg} = dataInfo
// 		const defaultPath = "${pageContext.request.contextPath}/upload/profile/base/defaultImg.png";
		const maxSize = 2 * 1024 * 1024;
		file = this.files[0];

		if(file == null){
			previewImg.attr("src", comuProfileImg);
			return false;
		}

		if(file.size > maxSize){
			sweetAlert("error", "파일 사이즈는 2MB 미만으로 선택해주세요!");
			$(this).val("");
			file = null;
			previewImg.attr("src", comuProfileImg);
			return false;
		}

		if(!file.type.startsWith("image/")){
			sweetAlert("error", "이미지파일만 선택해주세요");
			$(this).val("");
			file = null;
			previewImg.attr("src", comuProfileImg);
			return false;
		}

		let fileReader = new FileReader();
		fileReader.onload = function(e){
			previewImg.attr("src", e.target.result);
		};

		fileReader.readAsDataURL(file);
	})

	$("#profileSubmitBtn").on("click",function(){
		let dataInfo = profileModal.data("dataInfo")
		let {comuProfileImg,comuProfileNo,artGroupNo} = dataInfo
		let comuNicknm = $("#comuNicknm").val();
		if(comuNicknm == null || comuNicknm.trim() == ''){
			sweetAlert("error","닉네임을 입력해주세요");
			return false;
		}
		if(comuNicknm.length > 12){
			sweetAlert("error","닉네임은 12자 이내로 입력해주세요");
			return false;
		}

		let formData = new FormData();
		formData.append("comuProfileNo",comuProfileNo);
		formData.append("comuNicknm",comuNicknm);
		formData.append("comuProfileImg",comuProfileImg);
		formData.append("artGroupNo",artGroupNo);
		if(file != null){
			formData.append("imgFile", file);
		}

		$.ajax({
			url : "/api/community/updateProfile",
			type : "post",
			processData : false,
			contentType : false,
			data : formData,
			beforeSend : function(xhr){
				xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}')
			},
			success : function(res){
				sweetAlert("success","프로필를 변경했습니다").then(res =>{
					location.reload();
				});

			},
			error : function(err){
				console.log(err);
				sweetAlert("error","프로필 변경 도중 에러가 발생했습니다. 다시 시도해주세요!");
			}
		})
	})

	profileModal.on('hide.bs.modal',function(){
		previewImg.attr("src","");
		$("#comuNicknm").val("");
		$("#comuProfileNo").val("");
		profileModal.removeData("dataInfo")
	})


	const postUpdateModal = $("#postUpdateModal"); // 해당 포스트 혹은 댓글이달린 원본글을 보여줄 모달
	const detailBox = $(".detailBox"); // 자신이 쓴 글이나 댓글 div
	const commentSubmitBtn = $("#commentSubmitBtn");

	postModal.on("show.bs.modal",function(e){
		let comuPostNo = e.relatedTarget.getAttribute("data-comu-post-no");
		let comuPostMbspYn = e.relatedTarget.getAttribute("data-comu-post-mbsp-yn");// 멤버쉽 전용 여부
		let comuProfileNo = e.relatedTarget.getAttribute("data-comu-profile-no");//해당 포스트작성 커뮤번호
		let membershipFlag = "${membershipFlag}"
		let myComuProfileNo = "${myComuProfileNo}"

		if(comuPostMbspYn == 'Y' && comuProfileNo != myComuProfileNo && !membershipFlag){
			sweetAlert("warning","멤버쉽 전용 게시글입니다.");
			return;
		}

		displayPostModal(comuPostNo);
	});

	// 날짜 포맷팅 함수
	function padTwoDigits(num) {
	  return num.toString().padStart(2, "0");
	}

	/**
	* 시간.분.초 형식으로 바꾸기 (예: 2024.01.01 10:30)
	*/
	function getFormattedDate(time) {
	  const date = new Date(time);

	  return (
	    [
	      date.getFullYear(),
	      padTwoDigits(date.getMonth() + 1),
	      padTwoDigits(date.getDate()),
	    ].join(".") +
	    " " +
	    [
	      padTwoDigits(date.getHours()),
	      padTwoDigits(date.getMinutes())
	    ].join(":")
	  );
	}


	function reportModalInfo(info){

		let postNo = info.postNo;
		let boardType = info.boardType;
		let comuProfileNo = info.comuProfileNo;
		let reasonCodeList = info.reasonCode;
		let reportTarCode = info.reportTarCode;
		let artGroupNo = "${artGroupNo}"; // JSP EL로 바로 값 가져오기
		let comuReplyNo = info.comuReplyNo;

		let targetNick = info.comuNick;
		let targetContent = info.comuContent;

		let radioHtml = ``;
		for(let i=0; i<reasonCodeList.length; i++){
			let reasonCode = reasonCodeList[i];
			radioHtml += `
				<div class="form-check">
					<input class="btn-check" type="radio" name="reportReasonCode" id="\${reasonCode.commCodeDetNm}" value="\${reasonCode.commCodeDetNo}" autocomplete="off">
					<label class="btn btn-sm btn-outline-primary" for="\${reasonCode.commCodeDetNm}">\${reasonCode.description}</label>
	            </div>
			`;
		}

		$(".radioArea").html(radioHtml);

		$("#targetNick").val(targetNick);
		$("#targetContent").html(targetContent);

		$("#targetComuPostNo").val(postNo);
		$("#targetBoardTypeCode").val(boardType);
		$("#reportArtGroupNo").val(artGroupNo);
		$("#targetComuProfileNo").val(comuProfileNo);
		$("#reportTargetTypeCode").val(reportTarCode);

		if(comuReplyNo != null){
			$("#targetComuReplyNo").val(comuReplyNo);
		}

	}

	/**
	* 게시글 모달을 띄우고 내용 불러오는 공통 함수
	*/
	function displayPostModal(comuPostNo){
		$.ajax({
			url : `/api/community/getPost?comuPostNo=\${comuPostNo}&myComuProfileNo=${myComuProfileNo}`,
			type : "get",
			success : function(postVO){
				$("#boardTypeCode").val(postVO.boardTypeCode);
				$("#comuPostNo").val(comuPostNo);
				$("#artGroupNo").val(postVO.artGroupNo);
				let {artGroupNo, comuPostContent, writerProfile,
					comuPostLike, comuPostReplyCount, comuPostReplyList,
					postFiles, comuPostRegDate, likeYn, comuProfileNo,
					comuPostModDate, fileGroupNo, boardTypeCode, comuPostMbspYn} = postVO;


				// 본문 영역
				let postHtml = ``;
				postHtml = `
					<div class="post-pane-header">
						<a href="${pageContext.request.contextPath}/community/\${artGroupNo}/profile/\${writerProfile.comuProfileNo}" style="text-decoration:none; color:black;">
	                	<div class="d-flex align-items-center">
	                        <img src="\${writerProfile.comuProfileImg}" class="rounded-circle comment-avatar">
	                        <div class="ms-2">
	                        	<div>
		                            <strong>\${writerProfile.comuNicknm}</strong>
		             			`;
	             			if(comuPostMbspYn == 'Y'){
								postHtml += `
		                            <span class="ml-2 badge text-bg-purple rounded-pill">멤버쉽전용</span>
								`;
	             			}
	                        postHtml +=	`
	                        	</div>
	                            <small class="text-muted">\${getFormattedDate(comuPostModDate)}</small>
	                        </div>
	                	</div>
	                	</a>
	                	<div class="dropdown">
					        <button class="btn btn-link text-secondary p-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					            <i class="bi bi-three-dots-vertical"></i>
					        </button>
					        <ul class="dropdown-menu"
					`;
				if(writerProfile.comuProfileNo == "${myComuProfileNo}"){
					postHtml += `
						<li><button class="dropdown-item postUpdateBtn" data-bs-toggle="modal"
							data-bs-target="#postUpdateModal"
							data-comu-post-no="\${comuPostNo}"
							data-comu-post-content="\${comuPostContent}"
							data-file-group-no="\${fileGroupNo}"
							>수정</button></li>
			            <li><button class="dropdown-item text-danger postDeleteBtn" data-comu-post-no="\${comuPostNo}" >삭제</button></li>
					`;
				}else{
					postHtml += `
						<li><button class="dropdown-item text-danger postReportBtn" data-comu-post-no="\${comuPostNo}"
							data-bs-toggle="modal"
							data-bs-target="#reportModal"
							data-bs-comuPostNo="\${comuPostNo}"
							data-bs-boardType="\${boardTypeCode}"
							data-bs-comuProfileNo="\${writerProfile.comuProfileNo}"
							data-bs-comuNick="\${writerProfile.comuNicknm}"
							data-bs-comuContent="\${comuPostContent}"
							data-bs-selectType="RTTC001"
							>신고</button>
						</li>
					`;
				}
				postHtml += `
					        </ul>
					    </div>
	                </div>
	                <div class="post-pane-body" style="padding:10px;">
	                `;
           		// 파일 컨테이너는 이제 이 함수 내부에서 지역변수로 사용. 전역 변수 Map은 불필요.
	            if(postFiles != null && postFiles.length > 0){
	            	for(let i in postFiles){
	            		let file = postFiles[i];
	            		postHtml += `
	            			<img src="\${file.webPath}" alt="\${file.fileOriginalNm}" width="80%" style="border-radius:10px;">
	            		`;
	            	}
	            }
	            postHtml += `
	                	<p>\${comuPostContent}<p>
	                </div>
	                <div class="post-pane-footer">
	                `;
	            if(likeYn == 'Y'){
	            postHtml += `
					    <button type="button" class="btn btn-like active" data-comu-post-no="\${comuPostNo}" data-comu-profile-no="${myComuProfileNo}"
					    data-board-type-code="\${boardTypeCode}" data-art-group-no="\${artGroupNo}" data-like-yn="\${likeYn}" id="likeButton">
					        <i class="bi bi-heart-fill"></i>
					        <span id="likeCount">\${comuPostLike}</span>
					    </button>
	            	`;
	            }else{
	            	postHtml += `
					    <button type="button" class="btn btn-like" data-comu-post-no="\${comuPostNo}" data-comu-profile-no="${myComuProfileNo}"
					    	data-board-type-code="\${boardTypeCode}" data-art-group-no="\${artGroupNo}" data-like-yn="\${likeYn}" id="likeButton">
					        <i class="bi bi-heart"></i>
					        <span id="likeCount">\${comuPostLike}</span>
					    </button>
	            	`;
	            }
	            postHtml +=`
					</div>
				`;

				$("#postBox").html(postHtml);

				$("#replyCount").html("답글 " + comuPostReplyCount + "개");

				// 댓글 영역
				let replyHtml = ``;
				for(let reply of comuPostReplyList){
					let {comuReplyContent, boardTypeCode:replyBoardTypeCode, comuReplyRegDate, comuReplyNo, replyMember, comuReplyModDate, comuReplyDelYn} = reply;
					let {comuProfileImg, comuNicknm, comuProfileNo:replyComuProfileNo} = replyMember;
						replyHtml += `
							<div class="comment-item">
							<a href="${pageContext.request.contextPath}/community/\${artGroupNo}/profile/\${replyComuProfileNo}" style="text-decoration:none; color:black;">
								<img src="\${comuProfileImg}" class="rounded-circle comment-avatar">
							</a>
				            <div class="comment-main-wrapper">
				            	<div class="comment-header">
									<a href="${pageContext.request.contextPath}/community/\${artGroupNo}/profile/\${replyComuProfileNo}" style="text-decoration:none; color:black;">
				            			<strong>\${comuNicknm}</strong>
									</a>
	            		`;
						replyHtml +=`
		            		<div class="dropdown">
						        <button class="btn btn-link text-secondary p-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
						            <i class="bi bi-three-dots-vertical"></i>
						        </button>
						        <ul class="dropdown-menu">
			          	`;
						if("${myComuProfileNo}" == replyComuProfileNo){
							replyHtml += `
					            		<li><button class="dropdown-item text-danger replyDeleteBtn" data-comu-post-no="\${comuPostNo}" data-comu-reply-no="\${comuReplyNo}">삭제</button></li>
					            	</ul>
					            </div>
							`;
						}else{
							replyHtml += `
										<li><button class="dropdown-item text-danger replyReportBtn" data-comu-post-no="\${comuPostNo}" data-comu-reply-no="\${comuReplyNo}"
											data-bs-toggle="modal"
											data-bs-target="#reportModal"
											data-bs-comuPostNo="\${comuPostNo}"
											data-bs-comuReplyNo="\${comuReplyNo}"
											data-bs-boardType="\${replyBoardTypeCode}"
											data-bs-comuProfileNo="\${replyComuProfileNo}"
											data-bs-comuNick="\${comuNicknm}"
											data-bs-comuContent="\${comuReplyContent}"
											data-bs-selectType="RTTC002" >신고</button></li>
									</ul>
					            </div>
							`;
						}
						replyHtml += `
						        </div>
						        <div class="comment-body-text">
					        	<p>\${comuReplyContent}</p>
					        	<small class="text-muted">\${getFormattedDate(comuReplyModDate)}</small>
							        </div>
							    </div>
							</div>
						`;
					}
				$("#replyContent").html(replyHtml);
				$("#commentSubmitBtn").data("comu-post-no",comuPostNo);
				postModal.data("replyCountInfo",{
					comuPostNo : comuPostNo,
					replyCount : comuPostReplyCount
				});
			},
			error : function(err){
				console.log(err);
				sweetAlert("error","게시글 정보를 불러오는데 실패했습니다.");
			}
		});

		// 이 함수가 호출될 때 URL 해시를 업데이트
		window.history.replaceState("", document.title, window.location.pathname + window.location.search + "#post-" + comuPostNo);
	}

	/**
	* 게시글 수정 모달에 데이터 주입 함수
	*/
	function displayPostUpdateModal(comuPostNo){
		$.ajax({
			url : `/api/community/getUpdatePost?comuPostNo=\${comuPostNo}`,
			type : "get",
			success : function(postVO){
				let {artGroupNo, comuPostContent,postFiles,fileGroupNo, comuPostMbspYn} = postVO;

				// 본문 영역
				let postHtml = `
					<form id="updateForm">
	                    <div class="p-3">
	                        <h4>게시물 수정</h4>
	                        <input type="hidden" name="comuPostNo" value="\${comuPostNo}">
	                        <input type="hidden" name="fileGroupNo" value="\${fileGroupNo}">
	                        <div class="mb-3">
	                            <label for="updatePostContent" class="form-label">내용</label>
	                            <div id="previewContainer">
                           `;
                           if(postFiles != null && postFiles.length > 0){
								for(let file of postFiles){
								postHtml += `
		                        	   <div style="position:relative; display: inline-block;">
				    						<img src="\${file.webPath}" height="120px"/>
				    						<i class="bi bi-x-lg deletePostImg" data-attach-detail-no='\${file.attachDetailNo}' style="position:absolute; top:0; right:0; cursor: pointer; color:red;"></i>
				    					</div>
									`;
								}
                           }
                           postHtml += `
			                            </div>
			                            <textarea class="form-control" id="updatePostContent" name="comuPostContent" rows="10">\${comuPostContent}</textarea>
			                        </div>
			                        <div class="form-check mb-3 d-flex" style="padding-left:0px;">
				                        <label class="form-check-label" for="checkMbspYn"> 멤버쉽 전용 여부</label>
				                        <input class="form-check-input" type="checkbox" name="comuPostMbspYn" id="checkMbspYn" \${comuPostMbspYn == 'Y' ? 'checked' : ''} style="margin-left:20px;">
			                        </div>
			                        <div class="mb-3">
			                            <label for="updatePostFiles" class="form-label">첨부파일</label>
			                            <input type="file" class="form-control" id="updatePostFiles" name="files" accept="image/*" multiple/>
			                        </div>

			                        <div class="d-flex justify-content-end gap-2">
			                            <button type="button" class="btn btn-success" id="savePostUpdateBtn">저장</button>
			                            <button type="button" class="btn btn-secondary" id="cancelPostUpdateBtn" data-bs-dismiss="modal">취소</button>
			                        </div>
			                    </div>
			            	</form>
		                   `;
				$("#postUpdateModalContentBox").html(postHtml);
			},
			error : function(err){
				console.log(err);
				sweetAlert("error","게시글 수정 정보를 불러오는데 실패했습니다.");
			}
		})
	}

	// 좋아요 버튼 클릭 시 서버에 업데이트 요청
	function likeUpdate(data){

		$.ajax({
			url : "/api/community/post/likeUpdate",
			type : "post",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}")
			},
			success : function(res){
				// 좋아요 업데이트 후 별도의 화면 갱신은 각 클릭 이벤트 핸들러에서 처리됨
			},
			error : function(err){
				console.error("Like update error:", err);
				sweetAlert("error","좋아요 처리 중 오류가 발생했습니다.");
			}
		})
	}

	// jQuery DOM Ready 블록
	$(function(){
		const postModal = $("#postModal"); // 해당 포스트 혹은 댓글이달린 원본글을 보여줄 모달
		const postUpdateModal = $("#postUpdateModal"); // 해당 포스트 혹은 댓글이달린 원본글을 보여줄 모달
		const detailBox = $(".detailBox"); // 자신이 쓴 글이나 댓글 div
		const commentSubmitBtn = $("#commentSubmitBtn");

		// 페이지 로드 시 URL 해시 확인하여 게시글 모달 자동 띄우기 (새로운 기능)
		if (window.location.hash) {
            const hash = window.location.hash;
//             console.log("Detected hash on load:", hash);

            if (hash.startsWith("#post-")) {
                const comuPostNo = hash.substring(6);
                if (!isNaN(comuPostNo) && comuPostNo.length > 0) {
//                     console.log("Opening post modal for postNo from hash:", comuPostNo);
                    displayPostModal(comuPostNo);
                }
            }
        }

		// 기존 게시물 카드 클릭 이벤트 (모달 띄우기)
		// displayPostModal 함수가 `show.bs.modal` 핸들러 내에서 호출되므로,
		// detailBox 클릭 이벤트는 직접 displayPostModal을 호출하도록 변경하여 중복 로직 제거 및 명확화.
// 		detailBox.on("click", function() {
//             let comuPostNo = $(this).data("comu-post-no");
//             displayPostModal(comuPostNo);
//         });

		// 게시글 모달이 띄워질 때 (Bootstrap show.bs.modal 이벤트)
		// 이 부분은 displayPostModal 함수가 이미 처리하므로, 여기서는 관련 로직 제거
		postModal.on("show.bs.modal",function(e){
			// 기존에 이 안에 있던 displayPostModal 호출 로직은 detailBox 클릭 시 직접 호출하거나,
			// URL 해시 처리 로직에서 호출되므로 제거합니다.
			// 만약 data-bs-target을 통해 모달이 열리고 그 target에서 comuPostNo를 가져와야 한다면,
			// 아래 주석 처리된 코드를 활용할 수 있습니다.
			// let comuPostNo = e.relatedTarget.getAttribute("data-comu-post-no");
			// if (comuPostNo) displayPostModal(comuPostNo);
		});


		// 좋아요 댓글수 동기화 및 URL 해시 정리 (postModal 닫힐 때)
		postModal.on("hidden.bs.modal",function(){
			const savedLikeStatus = postModal.data('currentLikeStatus');
			const replyCountInfo = postModal.data("replyCountInfo");

			if(savedLikeStatus){
				let {isLiked,comuPostNo,likeCount} = savedLikeStatus
				const mainLikeButton = $(`.post-likes[data-comu-post-no="\${comuPostNo}"]`);
				if(mainLikeButton.length > 0){ // 해당 요소가 존재할 때만 처리
					const likeIcon = mainLikeButton.find('i');
			        const likeCountSpan = mainLikeButton.find('.likeCount');

					if(isLiked){
						mainLikeButton.addClass("active");
						likeIcon.removeClass("bi-heart").addClass("bi-heart-fill");
					}else{
						mainLikeButton.removeClass("active");
						likeIcon.removeClass("bi-heart-fill").addClass("bi-heart");
					}
					likeCountSpan.text(likeCount);
					mainLikeButton.data("likeYn",isLiked ? 'Y' : 'N');
				}
			}
			if(replyCountInfo){ // replyCountInfo가 있을 때만 처리
				const mainReply = $(`.post-comments[data-comu-post-no="\${replyCountInfo.comuPostNo}"]`)
				if(mainReply.length > 0) { // 요소가 존재하는지 확인
					mainReply.find('span').text(replyCountInfo.replyCount);
				}
			}

			postModal.removeData("currentLikeStatus"); // 저장된 데이터 삭제
			postModal.removeData("replyCountInfo"); // 저장된 데이터 삭제

			// 모달 닫힐 때 URL 해시 정리 (새로 추가된 부분)
            if (window.location.hash.startsWith("#post-")) {
                window.history.replaceState("", document.title, window.location.pathname + window.location.search);
            }
		})

		// 글 삭제
		$("body").on("click",".postDeleteBtn",function(){
			let comuPostNo = $(this).data("comuPostNo");
			Swal.fire({
				   title: '정말로 삭제 처리 하시겠습니까?',
				   text: '다시 되돌릴 수 없습니다. 신중하세요.',
				   icon: 'warning',

				   showCancelButton: true,
				   confirmButtonColor: '#3085d6',
				   cancelButtonColor: '#d33',
				   confirmButtonText: '삭제',
				   cancelButtonText: '취소',

				}).then(result => {
				    if(result.isConfirmed) {
				    	$.ajax({
							url : "/api/community/post/delete?comuPostNo="+comuPostNo,
							type : "post",
							beforeSend : function(xhr){
								xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}")
							},
							success : function(res){
								if(res == 'OK'){
									sweetAlert("success","게시글 삭제 성공했습니다");
									location.reload();
								}
							},
							error : function(err){
								sweetAlert("error","게시글 삭제에 실패했습니다.");
							}

						})
				    }
				});
		})

		// 수정 모달 노출시 데이터 주입
		// let fileContainer = new Map(); // displayPostUpdateModal 함수 내부에서 처리되므로 전역 변수 불필요
		postUpdateModal.on("show.bs.modal",function(e){
			let comuPostNo = e.relatedTarget.getAttribute("data-comu-post-no");
			displayPostUpdateModal(comuPostNo);
		})

		// 포스트 수정버튼 클릭
		postUpdateModal.on("click","#savePostUpdateBtn",function(){
			let formData = new FormData($("#updateForm")[0]);

			$.ajax({
				url : "/api/community/post/update",
				type : "post",
				beforeSend : function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}")
				},
				processData : false,
				contentType : false,
				data : formData,
				success : function(res){
					if(res == "OK"){
						sweetAlert("success","글 수정을 완료했습니다.").then((res)=>{
							location.reload();
						})
					}
				},
				error : function(err){
					console.log(err)
					sweetAlert("error", "게시글 수정에 실패했습니다.");
				}
			})

		})

		// 이미지 미리보기
		postUpdateModal.on("change","#updatePostFiles",function(){
			let files = this.files;
			$(".deletePostImg","#previewContainer").each((i,v)=> v.click()) // 기존 미리보기 제거

			for(let file of files){
				let reader = new FileReader();
				reader.onload = function(e){
					html = `
						<div style="position:relative; display: inline-block;">
							<img src="\${e.target.result}" height="120px"/>
							<i class="bi bi-x-lg deletePostImg" style="position:absolute; top:0; right:0; cursor: pointer;"></i>
						</div>
					`
					$("#previewContainer").append(html)
				}
				reader.readAsDataURL(file);
			}
		});

		// 이미지 삭제
		postUpdateModal.on("click",".deletePostImg",function(){
			let attachDetailNo = $(this).data("attachDetailNo");
			if(attachDetailNo){ // 기존 서버에 저장된 파일이라면 hidden input 추가
				let html = `<input type="hidden" name="deleteFiles" value="\${attachDetailNo}" />`
				$("#updateForm").append(html);
			}
			$(this).parent('div').remove(); // 미리보기 이미지 제거
		})

		// 댓글 삭제 버튼
		postModal.on("click",".replyDeleteBtn",function(){
			let comuPostNo = $(this).data("comuPostNo");
			let comuReplyNo = $(this).data("comuReplyNo");

			Swal.fire({
				   title: '정말로 삭제 처리 하시겠습니까?',
				   text: '다시 되돌릴 수 없습니다. 신중하세요.',
				   icon: 'warning',

				   showCancelButton: true,
				   confirmButtonColor: '#3085d6',
				   cancelButtonColor: '#d33',
				   confirmButtonText: '삭제',
				   cancelButtonText: '취소',

				}).then(result => {
				    if(result.isConfirmed) {
				    	$.ajax({
							url : "/api/community/reply/delete?comuReplyNo="+comuReplyNo,
							type : "post",
							beforeSend : function(xhr){
								xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}")
							},
							success : function(res){
								if(res == 'OK'){
									sweetAlert("success","댓글 삭제 성공했습니다.");
									displayPostModal(comuPostNo); // 댓글 삭제 후 게시글 모달 새로고침하여 댓글 목록 갱신
									// $(`.detailBox[data-comu-reply-no='\${comuReplyNo}']`,"#replyContainer").hide(); // displayPostModal 호출로 대체
								}
							},
							error : function(err){
								sweetAlert("error","댓글 삭제에 실패했습니다.");
							}

						})
				    }
				});
		})

		// 댓글 작성 기능
		commentSubmitBtn.on("click",function(){
			let comuProfileNo = $("#myComuProfileNo").val();
			let boardTypeCode = $("#boardTypeCode").val();
			let comuPostNo = $("#comuPostNo").val();
			let artGroupNo = $("#artGroupNo").val();
			let comuReplyContent = $("#comuReplyContent").val();

			if (!comuReplyContent.trim()) {
                sweetAlert("warning", "댓글 내용을 입력해주세요.");
                return;
            }

			let data = {
					boardTypeCode
					,comuPostNo
					,artGroupNo
					,comuProfileNo
					,comuReplyContent
			}
			$.ajax({
				url : "/api/community/reply/insert",
				type : "post",
				contentType : "application/json; charset=utf-8",
				beforeSend : function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}")
				},
				data : JSON.stringify(data),
				success : function(res){
					let {result, replyVO} = res;
					if(result == 'OK'){
						let comuPostNo = replyVO.comuPostNo
						displayPostModal(comuPostNo); // 댓글 작성 후 게시글 모달 새로고침
						$("#comuReplyContent").val(""); // 댓글 입력창 비우기
					}
				},
				error : function(err){
					console.log(err)
					sweetAlert("error","댓글 작성에 실패했습니다.");
				}
			})
		})

		// 신고 기능
		$("#reportSendBtn").on("click",function(){
			let reportForm = $("#reportForm")[0];
			let reportReasonCode = $(`input[name='reportReasonCode']:checked`);

			if(reportReasonCode.length <= 0){
				sweetAlert("error","신고 사유를 선택해주세요!");
				return false;
			}
			let formData = new FormData(reportForm);
			$.ajax({
				url : "/api/community/send/report",
				type : "post",
				processData : false,
				contentType : false,
				data : formData,
				beforeSend : function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}")
				},
				success : function(res){
					if(res == "OK"){
						sweetAlert("success","신고가 접수되었습니다.");
						$("#reportModal").modal('hide');
					}else if(res == "EXIST"){ // '=' 하나는 할당 연산자, '==' 또는 '===' 비교 연산자 사용 권장
						sweetAlert("warning","이미 신고하셨습니다.");
						$("#reportModal").modal('hide');
					}
				},
				error : function(err){
					sweetAlert("error","신고 도중 오류가 발생했습니다. 다시 시도해주세요");
				}
			});
		})

		// 좋아요 기능 (메인 페이지 게시물 카드)
		$(".post-likes").on("click",function(){

			let comuPostNo = $(this).data("comuPostNo");
	        let comuProfileNo = $(this).data("comuProfileNo");
	        let boardTypeCode = $(this).data("boardTypeCode");
	        let artGroupNo = $(this).data("artGroupNo");
	     	let likeYn = $(this).data("likeYn")
	     	let comuPostMbspYn = $(this).data("comuPostMbspYn");
	     	let comuWriterProfileNo = $(this).data("comuWriterProfileNo");
	     	let flag = ${membershipFlag};
	     	let insertDelete = likeYn == 'N' ? 1 : -1;
	     	if(comuPostMbspYn == 'Y' && comuWriterProfileNo != "${myComuProfileNo}" && !flag){
	     		sweetAlert("error","멤버쉽 가입 후 이용가능합니다.");
				return ;
	     	}

	        let data = {
	        		comuPostNo,comuProfileNo,boardTypeCode,artGroupNo,insertDelete
	        }
	        likeUpdate(data); // 좋아요 API 호출
	        $(this).toggleClass('active'); // 버튼 활성/비활성 클래스 토글

	        const likeIcon = $(this).find('i'); // 버튼 안의 i 태그(아이콘)를 찾음
	        const likeCountSpan = $(this).find('.likeCount');
	        let currentCount = parseInt(likeCountSpan.text().trim()); // 현재 숫자 가져오기

	        // 현재 'active' 클래스가 있는지 확인하여 아이콘 모양과 숫자 변경
	        if ($(this).hasClass('active')) {
	            // "좋아요"를 누른 상태 (활성 상태)
	            likeIcon.removeClass('bi-heart').addClass('bi-heart-fill');
	            likeCountSpan.text(currentCount + 1);
	            $(this).data("likeYn","Y") // 데이터 속성 업데이트
	        } else {
	            // "좋아요"를 취소한 상태 (비활성 상태)
	            likeIcon.removeClass('bi-heart-fill').addClass('bi-heart');
	            likeCountSpan.text(currentCount - 1);
	            $(this).data("likeYn","N") // 데이터 속성 업데이트
	        }
		});

		// 좋아요 기능 (모달 내 좋아요 버튼)
	    postModal.on('click',"#likeButton", function() {
	        let comuPostNo = $(this).data("comuPostNo");
	        let comuProfileNo = $(this).data("comuProfileNo");
	        let boardTypeCode = $(this).data("boardTypeCode");
	        let artGroupNo = $(this).data("artGroupNo");
	     	let likeYn = $(this).data("likeYn")
			let insertDelete = likeYn == 'N' ? 1 : -1;
	        let data = {
	        		comuPostNo,comuProfileNo,boardTypeCode,artGroupNo,insertDelete
	        }
	        likeUpdate(data); // 좋아요 API 호출

	        $(this).toggleClass('active'); // 버튼 활성/비활성 클래스 토글

	        const likeIcon = $(this).find('i'); // 버튼 안의 i 태그(아이콘)를 찾음
	        const likeCountSpan = $(this).find('#likeCount');
	        let currentCount = parseInt(likeCountSpan.text().trim()); // 현재 숫자 가져오기

	        // 현재 'active' 클래스가 있는지 확인하여 아이콘 모양과 숫자 변경
	        if ($(this).hasClass('active')) {
	            // "좋아요"를 누른 상태 (활성 상태)
	            likeIcon.removeClass('bi-heart').addClass('bi-heart-fill');
	            likeCountSpan.text(currentCount + 1);
	            $(this).data("likeYn","Y") // 데이터 속성 업데이트
	        } else {
	            // "좋아요"를 취소한 상태 (비활성 상태)
	            likeIcon.removeClass('bi-heart-fill').addClass('bi-heart');
	            likeCountSpan.text(currentCount - 1);
	            $(this).data("likeYn","N") // 데이터 속성 업데이트
	        }

	        // 모달 닫힘 시 메인 화면 동기화를 위해 현재 좋아요 상태 저장
	        postModal.data('currentLikeStatus', {
	            comuPostNo: comuPostNo,
	            isLiked: $(this).hasClass('active'), // true/false
	            likeCount: parseInt(likeCountSpan.text().trim()) // 최종 좋아요 수
	        });
	    });

		// textarea에서 키보드를 누를 때마다 실행 자동 높이조절
	    $('.comment-pane-footer textarea').on('keyup', function() {
	        // 일단 높이를 초기화하여 줄어드는 것도 가능하게 함
	        $(this).css('height', 'auto');
	        // 스크롤 높이(내용 전체 높이)를 실제 높이로 지정
	        $(this).css('height', $(this).prop('scrollHeight') + 'px');
	    });

		// 엔터키 댓글 전송
	    $('.comment-pane-footer textarea').on('keydown', function(e) {
	        // Shift 키를 누르지 않고 Enter 키만 눌렀을 때
	        if (e.key === 'Enter' && !e.shiftKey) {
	            e.preventDefault(); // 기본 Enter 동작(줄바꿈)을 막음
	            $('#commentSubmitBtn').click(); // 등록 버튼을 강제로 클릭
	        }
	    });

		// 신고모달 열림 (data-bs- 관련 속성 사용)
	    $("#reportModal").on("show.bs.modal",function(e){

			let postNo = e.relatedTarget.getAttribute('data-bs-comuPostNo'); // 대상 게시글 번호
			let boardType = e.relatedTarget.getAttribute('data-bs-boardType'); // 아티스트 팬 게시글인지
			let comuProfileNo = e.relatedTarget.getAttribute('data-bs-comuProfileNo');// 타켓의 커뮤프로필넘버
			let comuNick = e.relatedTarget.getAttribute('data-bs-comuNick'); // 타겟의 커뮤닉
			let comuContent = e.relatedTarget.getAttribute('data-bs-comuContent'); // 타켓 내용
			let selectType = e.relatedTarget.getAttribute('data-bs-selectType'); // RTTC001(게시글) 또는 RTTC002(댓글)
			let comuReplyNo = e.relatedTarget.getAttribute('data-bs-comuReplyNo'); // 댓글일때만 필요


			// JSP EL에서 받아온 코드 맵 사용
			let code = ${codeMap};
			let reasonCode = code.reasonCode; // 신고 사유 코드 목록

			let info = {
				"postNo" : postNo,
				"boardType" : boardType,
				"comuProfileNo" : comuProfileNo,
				"reasonCode" : reasonCode, // 이미 서버에서 가져온 이유 목록 사용
				"reportTarCode" : selectType, // 직접 selectType을 넘겨줌 (RTTC001 또는 RTTC002)
				"comuNick" : comuNick,
				"comuContent" : comuContent,
				"comuReplyNo" : comuReplyNo
			};
			reportModalInfo(info);
		});

		// 신고 모달 닫기
	    $("#reportModal").on("hide.bs.modal",function(e){
			$("#targetComuReplyNo").val(""); // 댓글 신고시 사용된 값 초기화
			$("#reportForm")[0].reset(); // 폼 필드 초기화
		});

		// `postUpdateModal`의 "취소" 버튼 클릭 이벤트 (data-bs-dismiss="modal" 속성 사용 시 필요 없음)
		$("#cancelPostUpdateBtn").on("click", function() {
            postUpdateModal.modal('hide');
        });
	});
});
</script>
</html>