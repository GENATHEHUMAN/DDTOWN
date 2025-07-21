// =============================================================
//               apt-community.js 최종 버전 (통합 및 오류 수정)
// =============================================================

// 전역 함수: 라이브 방송 시작
// 이 함수는 main.jsp에서 'Live 방송하기' 버튼 클릭 시 호출됩니다.
function startLive() {
    const mediaServerUrl = document.getElementById('mediaServerUrl').value;
    const artGroupNo = document.getElementById('communityArtistGroupNo').value;
    const artGroupNm = document.getElementById('communityArtistGroupNm').value;
    const streamInfoBtn = document.getElementById('stream-info');
    
    if (!streamInfoBtn) {
        alert("방송 시작 버튼 정보를 찾을 수 없습니다.");
        return;
    }
    const currentUserId = streamInfoBtn.dataset.userId; 

    if (!currentUserId) {
        alert("로그인이 필요합니다.");
        return;
    }
    
    const encodedArtGroupNm = encodeURIComponent(artGroupNm);
    
    if (!mediaServerUrl || !artGroupNo) {
        alert("방송 정보를 불러올 수 없습니다. 페이지를 새로고침 해주세요.");
        return;
    }
    
    const broadcastURL = `${mediaServerUrl}/broadcast/new?artGroupNo=${artGroupNo}&userId=${currentUserId}&artGroupNm=${encodedArtGroupNm}`;
    console.log("새 창으로 여는 URL:", broadcastURL);
    window.open(broadcastURL, 'broadcastWindow', 'width=1280,height=750');

}

// 전역 함수: 라이브 방송 시청 (수정된 코드 - broadcastId를 인자로 받음)
// 이 함수는 동적으로 생성된 라이브 카드 클릭 시 호출됩니다.
function watchLive(broadcastId) {
    const mediaServerUrl = document.getElementById('mediaServerUrl').value;
    const artGroupNo = document.getElementById('communityArtistGroupNo').value; 

    const myProfileNicknameElement = document.getElementById('myProfileNickname');
    // myProfileNickname이 null이거나 내용이 비어있을 경우 '사용자'로 기본값 설정
    const myProfileNickname = myProfileNicknameElement ? myProfileNicknameElement.textContent.trim() : '사용자'; 
    console.log('My Profile Nickname (from main.jsp):', myProfileNickname); // 값 확인용 로그

    // 미디어 서버의 '검색 후 리다이렉트' URL을 호출
    const watchURL = `${mediaServerUrl}/broadcast/live/${artGroupNo}?broadcastId=${broadcastId}&viewerNick=${encodeURIComponent(myProfileNickname)}`; 
    
    console.log("새 창으로 여는 URL (watchLive):", watchURL); // 생성된 URL 확인용 로그
    window.open(watchURL, 'watchWindow', 'width=1280,height=665');
}

// =============================================================
//               라이브 탭 비동기 로딩 로직 (수정 및 통합된 부분)
// =============================================================
document.addEventListener('DOMContentLoaded', function() {
    const liveTabButton = document.getElementById('live');
    const liveContentArea = document.getElementById('liveContentArea'); // main.jsp에 추가될 ID
    const liveLoadingIndicator = document.getElementById('liveLoadingIndicator'); // main.jsp에 추가될 ID
    const noLiveMessage = document.getElementById('noLiveMessage'); // main.jsp에 추가될 ID
    const mediaServerUrl = document.getElementById('mediaServerUrl').value;
    const artGroupNo = document.getElementById('communityArtistGroupNo').value;
    const artGroupNm = document.getElementById('communityArtistGroupNm').value; // artGroupNm 필드 가져오기
	const artistGroupProfileImg = document.getElementById('artistGroupProfileImg').value; // 새로 추가

    // `watchLive` 함수를 전역 스코프에 노출시켜 HTML에서 `javascript:watchLive()`로 호출 가능하게 함
    window.watchLive = watchLive; 

    if (liveTabButton && liveContentArea) {
        // Bootstrap 탭의 'shown.bs.tab' 이벤트 리스너를 추가
        liveTabButton.addEventListener('shown.bs.tab', function (event) {
            console.log("라이브 탭이 활성화되었습니다. 비동기 데이터 로딩 시작.");
            loadLiveInfo(artGroupNo, mediaServerUrl, artGroupNm); // artGroupNm 전달
        });

        // 페이지 로드 시 URL 해시가 '#liveArea'이거나 경로가 '/live'로 끝날 경우 초기 로딩
        // (이 부분은 main.jsp의 <c:if test='${requestScope["javax.servlet.forward.request_uri"].endsWith("/live")}'> 와 연동)
        if (window.location.hash === '#liveArea' || window.location.pathname.endsWith('/live')) {
            // 라이브 탭 활성화 ( 클릭 )
            activateLiveTab();
            loadLiveInfo(artGroupNo, mediaServerUrl, artGroupNm); // artGroupNm 전달
        }
    }

    // 라이브 탭 활성화 함수
    function activateLiveTab() {
        console.log("알림 URL 이동 후 라이브 탭 활성화");
        
        // Bootstrap 탭 활성화
        const liveTab = new bootstrap.Tab(liveTabButton);
        liveTab.show();
        
        // URL 해시 제거
        if (window.location.hash === '#liveArea') {
            history.replaceState(null, null, window.location.pathname);
        }
    }

    // 라이브 정보 로드 및 렌더링 함수
    function loadLiveInfo(artGroupNo, mediaServerUrl, artGroupNm) {
        // 기존 콘텐츠 지우고 로딩 인디케이터 표시
        liveContentArea.innerHTML = '';
        if (liveLoadingIndicator) {
            liveLoadingIndicator.style.display = 'block';
        }
        if (noLiveMessage) {
            noLiveMessage.style.display = 'none';
        }

        const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
        const csrfHeaderName = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

        // REST API 엔드포인트 호출
        fetch(`${window.location.origin}/api/community/live/current/${artGroupNo}`, { 
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                [csrfHeaderName]: csrfToken 
            }
        })
        .then(response => {
            console.log('라이브 정보 조회 응답 상태:', response.status);
            
            if (response.status === 204) {
                // NO_CONTENT 상태 코드 (라이브 없음)
                console.log('진행중인 라이브가 없습니다.');
                return null;
            } else if (response.ok) {
                // 응답이 성공적이지만 body가 비어있을 수 있음
                const contentType = response.headers.get('content-type');
                if (contentType && contentType.includes('application/json')) {
                    return response.json();
                } else {
                    console.log('응답이 JSON이 아닙니다. contentType:', contentType);
                    return null;
                }
            } else {
                throw new Error('라이브 정보를 불러오는데 실패했습니다. 상태 코드: ' + response.status); 
            }
        })
        .then(liveInfo => {
            // 로딩 인디케이터 숨김
            if (liveLoadingIndicator) {
                liveLoadingIndicator.style.display = 'none';
            }

            if (liveInfo && Object.keys(liveInfo).length > 0) {		// 라이브정보 제대로 검증하고 ㄱㄱ 로그 다시확인
                // 라이브 정보가 있을 경우 동적으로 HTML 생성 및 삽입
				const liveHtml = `
                    <h4 class="mb-3"> 진행중인 LIVE </h4>
                    <div class="card shadow-sm live-broadcast-card" data-broadcast-id="${liveInfo.id}" style="transition: all 0.3s ease; border: 2px solid transparent; cursor:pointer;">
                        <div class="card-body">
                            ${liveInfo.liveThmimgUrl ? `<img src="${liveInfo.liveThmimgUrl}" class="img-fluid rounded mb-3" alt="방송 썸네일" style="width: 100%; height: 400px;">` : `<img src="${artistGroupProfileImg}" class="img-fluid rounded mb-3" alt="아티스트 그룹 프로필 이미지" style="width: 100%; height: 400px;">`}
                            <div class="d-flex align-items-center text-danger mt-3">
                                <i class="bi bi-broadcast-pin me-2"></i>
                                <strong style="font-size: 1.1em;">LIVE</strong>
                            </div>
                            <div>
                                <h5 class="card-title mt-2">${liveInfo.liveTitle}</h5>
                                <p class="card-text text-muted">${liveInfo.liveContent}</p>
                                <i class="bi bi-eye-fill me-1"></i>
                                <span id="viewer-count-${liveInfo.id}">${new Intl.NumberFormat().format(liveInfo.liveHit)}</span>명
                            </div>
                        </div>
                    </div>
                `;
                liveContentArea.innerHTML = liveHtml;

                // 방송 카드에 직접 클릭 이벤트 바인딩
                const liveCard = document.querySelector('.live-broadcast-card');
                if (liveCard) {
                    liveCard.addEventListener('click', function() {
                        watchLive(liveInfo.id);
                    });
                }

                // 뷰어 카운트 실시간 업데이트를 위한 StompJS 연결
                connectStompForViewers(liveInfo.id, mediaServerUrl);

                // 알림으로 인한 라이브 탭 진입 시 방송 카드에 포커스
                if (window.location.hash === '#liveArea' || window.location.pathname.endsWith('/live')) {
                    setTimeout(() => {
                        focusLiveCard();
                    }, 500); // 라이브 정보 로딩 완료 후 0.5초 뒤 포커스
                }

            } else {
                // 라이브 방송이 없을 경우 메시지 표시
                console.log('라이브 정보가 없습니다. noLiveMessage 표시');
                if (noLiveMessage) {
                    noLiveMessage.style.display = 'block';
                    // artGroupNm을 활용하여 메시지 커스터마이징 가능
                    // noLiveMessage.innerHTML = `<i class="bi bi-camera-video-off" style="font-size: 3rem;"></i><p class="mt-3 mb-0">\${artGroupNm}의 현재 진행 중인 라이브 방송이 없습니다.</p>`;
                }
            }
        })
        .catch(error => {
            console.error('라이브 정보를 불러오는 중 오류 발생:', error); 
            // 로딩 인디케이터 숨김
            if (liveLoadingIndicator) {
                liveLoadingIndicator.style.display = 'none';
            }
            // 오류 메시지 표시
            liveContentArea.innerHTML = `<div class="text-center p-5 text-danger border rounded">
                                            <i class="bi bi-exclamation-triangle" style="font-size: 3rem;"></i>
                                            <p class="mt-3 mb-0">라이브 정보를 불러오는데 실패했습니다. 잠시 후 다시 시도해주세요.</p>
                                        </div>`;
        });
    }

    // 방송 카드 포커스 효과 함수
    function focusLiveCard() {
        const liveCard = document.querySelector('.live-broadcast-card');
        if (liveCard) {
            console.log("방송 카드에 포커스 효과 적용");
            
            // 카드로 스크롤
            liveCard.scrollIntoView({ 
                behavior: 'smooth', 
                block: 'center' 
            });
            
            // 포커스 효과 (테두리 색상 변경)
            liveCard.style.border = '2px solid #dc3545';
            liveCard.style.boxShadow = '0 0 20px rgba(220, 53, 69, 0.3)';
            
            // 3초 후 포커스 효과 제거
            setTimeout(() => {
                liveCard.style.border = '2px solid transparent';
                liveCard.style.boxShadow = '0 0.125rem 0.25rem rgba(0, 0, 0, 0.075)';
            }, 3000);
        }
    }

    // StompJS 연결 함수 (main.jsp의 기존 스크립트에서 가져온 부분)
    function connectStompForViewers(broadcastId, mediaServerUrl) {
        // 이미 연결된 Stomp 클라이언트가 있다면 재활용하거나 새로 연결 로직 필요
        // 이 예시에서는 간단히 매번 연결 시도. 실제 운영 환경에서는 연결 관리 로직을 추가하는 것이 좋습니다.
        const socket = new SockJS(`${mediaServerUrl}/ws`); 
        const stompClient = Stomp.over(socket); 

        stompClient.connect({}, function(frame) {
            console.log('STOMP 연결 성공. broadcastId:', broadcastId); 
            stompClient.subscribe('/topic/viewers/' + broadcastId, function(message) {
                const data = JSON.parse(message.body); 
                // ID로 정확한 span 태그를 찾아 내용 업데이트
                $('#viewer-count-' + broadcastId).text(data.viewerCount); 
            });
        }, function(error) {
            console.error('STOMP 연결 실패:', error); 
        });
    }
});