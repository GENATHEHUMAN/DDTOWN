<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/mainservice_home.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/mainservice_common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/concert_detail.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.14.1/themes/base/jquery-ui.min.css">
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js" defer integrity="sha256-9zljDKpE/mQxmaR4V2cGVaQ7arF3CcXxarvgr7Sj8Uc=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/animejs/lib/anime.iife.min.js"></script>
<title>DDTOWN SQUARE</title>

<style type="text/css">
body {
    background: linear-gradient(135deg, #1a1a2e 0%, #2a1e4a 50%, #8a2be2 100%); /* 중간색을 약간 더 보라색 계열로 조정 */
    background-attachment: fixed; /* 배경을 뷰포트에 고정 */
    background-size: cover; /* 배경이 전체 영역을 커버하도록 */
    min-height: 100vh;
    margin: 0;
    font-family: "Noto Sans KR", 돋움, Dotum, 굴림, Gulim, Tahoma, Verdana, sans-serif;
    color: #ffffff;
    overflow-x: hidden;
}
section {
    display: flex; /* 자식 요소들을 가로로 나란히 배치 */
    justify-content: center; /* 가운데 정렬 (필요에 따라 start, space-between 등 조절) */
    align-items: flex-start; /* 상단 정렬 (컨텐츠 높이가 다를 경우 유용) */
    flex-wrap: wrap; /* 화면이 좁아지면 자동으로 다음 줄로 넘어가도록 설정 */
    gap: 10px; /* 자식 요소들 사이의 간격 */
    margin: 10px auto; /* 중앙 정렬 및 위아래 여백 */
    max-width: 1200px; /* 전체 섹션의 최대 너비 설정 (조절 가능) */
    align-items: center;
    margin-bottom: 82px;
}

/* 예약 정보 (달력 + 버튼)를 위한 새로운 컨테이너 */
.concert-selectedseat-section {
    width: 280px;
    flex-shrink: 0; /* 공간이 부족해도 축소하지 않음 (이 값을 1로 주면 축소될 수 있음) */
    padding: 20px;
    border: 1px solid #eee;
    border-radius: 8px;
    background-color: #eee;
    display: flex;
    flex-direction: column; /* 세로 방향으로 요소 배치 */
    /* justify-content: space-between; */ /* 자식 요소들을 상하 끝으로 분배 */
    align-items: center; /* 가로 중앙 정렬 */
    height: 550px; /* 고정된 높이 */
    box-sizing: border-box; /* 패딩이 높이에 포함되도록 */
}

.concert-selectedseat-section h3 {
    color: #333;
    font-size: 18px;
    margin: 0;
}

/* 좌석 등급 / 가격, 선택 좌석 정보, 총 결제 금액 컨테이너 */
.concert-seat-display, #selectedSeatInfo, #totalPrice {
    width: 100%; /* 부모 너비에 맞춰 확장 */
    text-align: center; /* 텍스트 중앙 정렬 */
    padding: 5px 0; /* 상하 패딩 추가 */
    font-size: 1.05em; /* 글자 크기 조정 */
}

/* 예매하기 버튼 스타일 */
.btn-reserve {
    width: 100%; /* 부모 너비에 맞춤 */
    max-width: 90px; /* 최대 너비 설정 */
    padding: 12px 15px;
    background-color: #8a2be2;
    color: white;
    border: none;
    border-radius: 18px;
    font-size: 1em;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 10px;
}

.btn-cancel {
    width: 100%; /* 부모 너비에 맞춤 */
    max-width: 90px; /* 최대 너비 설정 */
    padding: 12px 15px;
    background-color: #ccc;
    color: #333;
    border: none;
    border-radius: 18px;
    font-size: 1em;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 10px;
}

.seat-map-container {
	position: relative;
	height: 400px;
	width: 500px;
	overflow: hidden;
}

.seat-map-container object {
	position: absolute;
	top: 50%;
	left: 68%;
	transform: translate(-50%, -50%) scale(0.4);
	width: 330%;
	height: 235%;
	object-fit: contain;
}

.concert-detail-container {
	max-width: 605px;
	flex-shrink: 0;
	padding: 0 20px;
	box-sizing: border-box;
}

.concert-detail-grid {
	height: 550px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.concert-price > div > div {
    display: flex;
    justify-content: space-around;
    align-items: center;
}

.concert-price > div > div  p {
	margin : 0;
}

</style>
</head>
<body>
	<sec:authentication property="principal.memberVO" var="memberVO"/>
	<jsp:include page="/WEB-INF/views/modules/communityHeader.jsp" />

	<section>
		<div class="concert-detail-container">
			<c:choose>
		        <c:when test="${not empty concertVO }">
				    <div class="concert-detail-grid">
				        <div class="seat-map-container" style="position: relative; height: 400px;">
<%-- 			            	<object data="${pageContext.request.contextPath}/resources/concertHall.svg" type="image/svg+xml" id="concertHallSvg"></object> --%>
			            	<object data="${pageContext.request.contextPath}/resources/seatSection.svg" type="image/svg+xml" id="seatSectionSvg"></object>
			            </div>
				    </div>
		    	</c:when>
		    	<c:otherwise>
		    		<div>콘서트 상세 내용을 불러올 수 없습니다.</div>
		    	</c:otherwise>
		    </c:choose>
		</div>

		<div class="concert-selectedseat-section">
			<h3>좌석 예매</h3>
	    	<h3>구역 / 등급 / 가격</h3>
	    	<div class="concert-seat-display">
	    		<hr>
	            <c:choose>
		            <c:when test="${not empty seatList }">
			            <div class="concert-price">
			                <c:forEach var="seat" items="${seatList }">
				                <div>
				                	<c:if test="${seat.seatGradeCode == 'SGC001' }">
				                		<div><p>STANDING석:</p> <p><fmt:formatNumber value="${ seat.seatPrice}" pattern="###,###"></fmt:formatNumber>원</p></div>
				                	</c:if>
				                	<c:if test="${seat.seatGradeCode == 'SGC002' }">
				                		<div><p>${seat.seatSection } 구역</p><p>VIP석: </p> <p><fmt:formatNumber value="${ seat.seatPrice}" pattern="###,###"></fmt:formatNumber>원</p></div>
				                	</c:if>
				                	<c:if test="${seat.seatGradeCode == 'SGC003' }">
				                		<div><p>${seat.seatSection } 구역</p><p>R석:</p> <p><fmt:formatNumber value="${ seat.seatPrice}" pattern="###,###"></fmt:formatNumber>원</p></div>
				                	</c:if>
				                	<c:if test="${seat.seatGradeCode == 'SGC004' }">
				                		<div><p>${seat.seatSection } 구역</p><p>S석:</p> <p><fmt:formatNumber value="${ seat.seatPrice}" pattern="###,###"></fmt:formatNumber>원</p></div>
				                	</c:if>
				                </div>
			                </c:forEach>
			            </div>
		            </c:when>
		            <c:otherwise>
		            	<div>가격 정보가 없습니다.</div>
		            </c:otherwise>
	            </c:choose>
		    	<hr>
		    	<h3>선택 좌석 정보</h3>
		    	<div id="selectedSeatInfo">
		    		선택된 자석이 없습니다.
		    	</div>

		    	<hr>
		    	<h3>총 결제 금액</h3><span id="totalPrice">0원</span>
		    	<hr>
		    	<button class="btn-cancel" id="btnCancel">구역보기</button>
		    	<button class="btn-reserve" id="btnReserve">결제하기</button>
    		</div>
   		</div>
    </section>
	<div id="footer">
        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/views/modules/communityFooter.jsp" />
        <script src="${pageContext.request.contextPath}/resources/js/pages/communityFooter.js"></script>
        <!-- FOOTER END -->
    </div>
</body>
<script>

	$(function() {

		const seatSectionSvgObj = document.getElementById("seatSectionSvg");
		let currentSeatSvgObj = null;

		let seats = [];	// 모든 좌석 요소를 저장할 배열
		const selectedSeatMap = new Map();
		const totalPrice = $('#totalPrice');

		// JSP에서 전달받은 JSON 데이터 파싱
		const allTicketList = JSON.parse('${allTicketList}');
		const bookedSeatNo = JSON.parse('${bookedSeatNo}');

// 		console.log("예매된 티켓 정보: ", bookedSeatNo);

		// 두 파일이 모두 로드되었는지 확인하는 카운터
		let loadedSvgCount = 0;
		const totalSvgToLoad = 1;

		const concertNo = '${concertVO.concertNo}'; // 콘서트 번호
        const concertNm = '${concertVO.concertNm}'; // 콘서트 이름

//         console.log("예매된 티켓 정보 : ", bookedSeatNo);

		// CSRF 토큰 정보 가져오기
	    const csrfMeta = document.querySelector('meta[name="_csrf"]');
	    const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');

	    const csrfToken = csrfMeta.getAttribute('content');
	    const csrfHeaderName = csrfHeaderMeta.getAttribute('content');

		// 모든 svg 로드가 완료되었을 때 실행될 함수
		function onAllSvgsLoaded() {
// 			console.log("초기 SVG 파일이 성공적으로 로드되었습니다.");

			const hallDoc = seatSectionSvgObj.contentDocument;
			if(hallDoc) {
				 const areaClasses = ["section_A", "section_B", "section_C", "section_D", "section_E"];
                 areaClasses.forEach(id => {
                     const areaElement = hallDoc.querySelector("." + id);
					if (areaElement) {
						$(areaElement).css({
							cursor: 'pointer',
							fill: '#E0E0E0'		// 기본 구역 색상 (클릭 가능 시점)
						});

						// 마우스 호버 효과
						$(areaElement).on('mouseenter', function() {
							$(this).css('fill', '#A0A0A0'); // 호버 시 색상 변경
						}).on('mouseleave', function() {
							$(this).css('fill', '#E0E0E0'); // 원래 색상으로 복귀
						}) ;

						// 구역 클릭 이벤트 핸들러
						$(areaElement).on('click', function() {
							let selectedAreaId = $(this).attr('class');
							selectedAreaId = selectedAreaId.split('_')[1];
// 							console.log("클릭된 구역: ", selectedAreaId);

							// 상세 구역 SVG 로드
							loadDetailedAreaSvg(selectedAreaId);
						});
					}
				});
			}
		}

		// 상세 구역 SVG 로드, 표시하는 함수
		function loadDetailedAreaSvg(areaId) {
// 			console.log(areaId);
			const seatMapContainer = document.querySelector(".seat-map-container");
			if(!seatMapContainer) {
				console.error("seat-map-container를 찾을 수 없습니다.");
				return;
			}

			// 기존 모든 SVG 객체 제거
			while (seatMapContainer.firstChild) {
				seatMapContainer.removeChild(seatMapContainer.firstChild);
			}

			// 구역 변경 시 selectedSeatMap을 초기화하고 UI 업데이트
			selectedSeatMap.clear();
			updateSelectedSeatInfo(); // 인자 없이 호출
			updateTotalPrice(); // 인자 없이 호출

			// 새로운 상세 SVG 생성 및 추가
			const detailedSvgObj = document.createElement("object");
			detailedSvgObj.setAttribute("type", "image/svg+xml");
			detailedSvgObj.setAttribute("id", "detailedAreaSvg");
			detailedSvgObj.setAttribute("data", `${pageContext.request.contextPath}/resources/\${areaId}Seat.svg`);
			detailedSvgObj.style.transform = 'translate(-50%, -50%) scale(0.8)'
			detailedSvgObj.style.position = 'absolute'
			detailedSvgObj.style.top = '30%'
			detailedSvgObj.style.left = '55%'
			detailedSvgObj.style.width = '100%'
			detailedSvgObj.style.height = '100%'
			detailedSvgObj.style.objectFit = 'contain'

			seatMapContainer.appendChild(detailedSvgObj);
			currentSeatSvgObj = detailedSvgObj;

			detailedSvgObj.onload= function() {
// 				console.log(`${areaId}Seat.svg 파일이 성공적으로 로드되었습니다.`);

				const detailedSeatSvgDocument = detailedSvgObj.contentDocument;
				if(detailedSeatSvgDocument) {
					const svgRoot = detailedSeatSvgDocument.querySelector("svg");
					if(svgRoot) {

						seats = svgRoot.querySelectorAll("rect");

						seats.forEach(function(seatElement) {
							if(bookedSeatNo.includes($(seatElement).attr("class"))){
								$(seatElement).attr("fill","red")
							}
							$(seatElement).css("cursor","pointer");

							$(seatElement).on('click', function() {
								const selectedSeatInfoDiv = document.getElementById("selectedSeatInfo");
								const seatId = $(seatElement).attr('class');
								// 좌석 선택/해제 토글 로직
                                if ($(seatElement).hasClass("selected-seat")) {
                                    // 이미 선택된 좌석이면 해제
                                    $(seatElement).attr("fill","#0992CA")
                                    $(seatElement).removeClass("selected-seat");
//                                    	console.log(selectedSeatMap.get(seatId))
                                    selectedSeatMap.clear();

                                } else {
									if($(selectedSeatInfoDiv).children().length >=1){
										Swal.fire({
							                icon: 'warning',
							                title: '좌석은 하나만 선택 가능합니다!',
							                confirmButtonColor: '#dc3545'
							            });
										return false;
									}
                                    // 선택 가능한 좌석이면 선택
                                    // 예매된 좌석이 아닌 경우에만 선택 가능하도록 로직 추가
                                    if (!bookedSeatNo.includes(seatId)) { // bookedSeatNo는 예매된 좌석 ID 배열
                                        $(seatElement).addClass("selected-seat");
                                        // allTicketList에서 해당 좌석 ID의 가격 찾기
                                        const seatInfo = allTicketList.find(ticket => ticket.seatNo === seatId);
//                                         console.log(seatInfo)
                                        if (seatInfo) {
                                        	let data = {ticketPrice : seatInfo.ticketPrice, goodsNo: seatInfo.goodsNo};
                                            selectedSeatMap.set(seatId, data);
                                            // {
                                            //	ticketPrice :
                                            //}
                                            $(seatElement).attr("fill","red")
                                        }
                                    } else {
//                                         console.log("이미 예매된 좌석입니다: " + seatId);
                                        Swal.fire({
							                icon: 'warning',
							                title: '이미 예매된 좌석입니다!',
							                confirmButtonColor: '#dc3545'
							            });
                                    }
                                }

                                updateSelectedSeatInfo(seatId); // 선택된 좌석 정보 업데이트
                                updateTotalPrice(seatId);      // 총 결제 금액 업데이트
							});

							if(bookedSeatNo.includes($(seatElement).attr('id'))) {
								$(seatElement).addclasS("booked-seat");
								$(seatElement).off('click');
							}
						});
					}
				}
			};

			detailedSvgObj.onerror = function() {
                console.error(`Error loading ${areaId}_detail.svg`);
                seatMapContainer.innerHTML = `<p>상세 좌석 지도를 불러올 수 없습니다. (${areaId})</p>`;
            };
		}

		// 선택된 좌석 정보 DIV 업데이트 함수
        function updateSelectedSeatInfo(seatId) {
            const selectedSeatInfoDiv = document.getElementById("selectedSeatInfo");
            if (selectedSeatMap.get(seatId) == undefined) {
                selectedSeatInfoDiv.textContent = "선택된 좌석이 없습니다.";
            } else {
                selectedSeatInfoDiv.innerHTML = `<span>\${seatId}</span>`
            }
        }

        // 총 결제 금액 업데이트 함수
        function updateTotalPrice(seatId) {
            let currentTotalPrice = 0;
            if(selectedSeatMap.get(seatId) != undefined){
            	currentTotalPrice = selectedSeatMap.get(seatId).ticketPrice;
            }
            totalPrice.text(currentTotalPrice.toLocaleString() + "원"); // 금액 포맷팅
        }


		// seatSectionSvgObj 로드 완료 핸들러
		seatSectionSvgObj.onload = function() {
// 			console.log("seatSectionSvgObj 파일이 성공적으로 로드되었습니다.");
			loadedSvgCount++;
			if(loadedSvgCount === totalSvgToLoad) {
				onAllSvgsLoaded();
			}
			selectedSeatMap.clear();
			updateSelectedSeatInfo();
			updateTotalPrice();
		};

		// 결제하기 버튼 이벤트
		$('#btnReserve').on('click', function(e) {
// 	    	console.log("결제하기 클릭됨");
			event.preventDefault(); // 기본 링크 동작 방지

// 			console.log("selectedSeatMap.size : " + selectedSeatMap.size);
			if(selectedSeatMap.size === 0) {
				Swal.fire({
	                icon: 'warning',
	                title: '좌석을 선택해주세요.',
	                confirmButtonColor: '#dc3545'
	            });
			} else {
				Swal.fire({
	                icon: 'info',
	                title: '결제 화면으로 이동합니다.',
	                confirmButtonColor: '#3085d6',
	                timer : 1000,
	                showConfirmButton : false
	            }).then(res=>{
					// 선택된 좌석 정보 가져오기
					const selectedSeatId = selectedSeatMap.keys().next().value; // 선택된 좌석 번호
	                const selectedSeat = selectedSeatMap.get(selectedSeatId); // 선택된 좌석 가격

	                const {ticketPrice:selectedSeatPrice, goodsNo} = selectedSeat;
// 	                console.log(selectedSeatPrice,goodsNo)
	//                 const selectedSeatPrice = selectedSeatMap.get(selectedSeatId); // 선택된 좌석 가격

	             	// allTicketList에서 선택된 좌석 ID에 해당하는 티켓 정보 찾기
	                const selectedTicketInfo = allTicketList.find(ticket => ticket.seatNo === selectedSeatId);
	                // 카카오페이 결제 함수 호출
					requestKakaoPaySubscription(selectedSeatId, selectedSeatPrice, concertNo, concertNm, goodsNo,selectedTicketInfo.ticketNo);

	            });
			}
		});

		// 구역보기 버튼 이벤트
		$('#btnCancel').on('click', function(e) {
// 			console.log("구역보기 클릭됨");
			event.preventDefault();
			location.reload();
		});

		function requestKakaoPaySubscription(seatNo, seatPrice, concertNo, concertNm,goodsNo,ticketNo) {
			// 1. 결제할 콘서트 티켓 정보 정의
	        const orderData = {
	            orderItems: [
	                {
	                    goodsNo: goodsNo, // 콘서트 티켓 상품 번호
	                    goodsOptNo: ticketNo,   // 콘서트 좌석은 옵션이 아님
	                    qty: 1,
	                    goodsNm: `\${concertNm} - \${seatNo} 좌석`, // 콘서트 이름과 좌석 번호
	                    itemPrice: seatPrice // 이 상품 항목의 가격 (필요하다면)
	                }
	            ],
	            singleGoodsName: `\${concertNm} 콘서트 티켓`, // 단일 상품명
	            totalAmount: seatPrice, // 선택된 좌석의 총 가격 (백엔드에서 검증/계산 필수)
	            isFromCart: false,
	            orderTypeCode: "OTC003",
	            orderPayMethodNm: "카카오페이",
	            // TODO: 실제 로그인한 사용자의 정보를 여기에 바인딩해야 합니다.
	            // 또는 백엔드에서 세션 정보를 사용하여 자동으로 채워지도록 합니다.
	            orderRecipientNm: "${memberVO.peoName}", // 실제 사용자 이름
	            orderRecipientPhone: "${memberVO.peoPhone}", // 실제 사용자 전화번호=
	            orderZipCode: "${memberVO.memZipCode}",
	            orderAddress1: "${memberVO.memAddress1}", // 배송 필요 없는 상품임을 명시
	            orderAddress2: "${memberVO.memAddress2}",
	            orderEmail: "${memberVO.peoEmail}", // 실제 사용자 이메일
	            orderMemo: `${concertNm} 콘서트 ${seatNo} 좌석 예매`,
	        };

// 	        console.log("카카오페이 결제 준비 요청 데이터 : ", orderData);

	        const headers = {
	            'Content-Type': 'application/json'
	        };

	        if (csrfToken && csrfHeaderName) {
	            headers[csrfHeaderName] = csrfToken;
	        } else {
	            console.warn("CSRF 토큰 또는 헤더 이름이 없습니다. 보안 설정을 확인하세요.");
	            Swal.fire({
	                icon: 'error',
	                title: '결제 오류',
	                text: '보안 토큰 문제로 결제를 진행할 수 없습니다. 페이지를 새로고침 해주세요.',
	                confirmButtonColor: '#dc3545'
	            });
	            return; // 토큰이 없으면 결제 요청 중단
	        }

	        // 2. 백엔드 API 호출
	        fetch('/goods/order/pay/ready', {
	            method: 'POST',
	            headers: headers,
	            body: JSON.stringify(orderData)
	        })
	        .then(response => {
	            if (!response.ok) {
	                return response.text().then(errorMessage => {
	                    console.error(`백엔드 오류 응답 (Status: \${response.status}):`, errorMessage);
	                    throw new Error(`결제 준비 실패: \${errorMessage}`);
	                });
	            }
	            return response.json();
	        })
	        .then(data => {
	            const nextRedirectUrl = data.next_redirect_pc_url;

	            if (nextRedirectUrl) {
// 	                console.log("카카오페이 결제 페이지로 리다이렉트: ", nextRedirectUrl);
	                window.location.href = nextRedirectUrl;
	            } else {
	                console.warn("카카오페이 리다이렉트 URL을 받지 못했습니다.");
	                Swal.fire({
	                    icon: 'error',
	                    title: '결제 실패',
	                    text: '카카오페이 결제 페이지로 이동할 수 없습니다. 다시 시도해주세요.',
	                    confirmButtonColor: '#dc3545'
	                });
	            }
	        })
	        .catch(error => {
	            console.error("카카오페이 결제 준비 중 예외 발생:", error);
	            Swal.fire({
	                icon: 'error',
	                title: '결제 처리 중 오류 발생',
	                text: `오류가 발생했습니다: \${error.message || '알 수 없는 오류'}. 잠시 후 다시 시도해주세요.`,
	                confirmButtonColor: '#dc3545'
	            });
	        });
	    }
	});

</script>
</html>