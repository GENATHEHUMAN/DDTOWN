<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<style>
.alert-list-container {
    background: rgba(255,255,255,0.18);
    backdrop-filter: blur(12px);
    border-radius: 18px;
    box-shadow: 0 8px 32px rgba(138,43,226,0.10);
    padding: 20px 0;
}
.alert-item {
    background: rgba(255,255,255,0.55);
    border-radius: 14px;
    margin: 12px 18px;
    box-shadow: 0 2px 8px rgba(138,43,226,0.08);
    display: flex; align-items: center;
    transition: background 0.2s, box-shadow 0.2s;
    border-left: 6px solid transparent;
    position: relative;
}
.alert-item.unread { border-left: 6px solid #8a2be2; background: rgba(255,255,255,0.75); }
.alert-item.read   { opacity: 0.7; }
.alert-item:hover  { background: rgba(138,43,226,0.08); box-shadow: 0 4px 16px #8a2be233; }
.alert-icon-area i {
    font-size: 1.2em;
    color: #8a2be2;
    margin-right: 1px;
}
.alert-content-area {
    flex-grow: 1;
    color: #2d1b69;
    font-size: 1.08em;
    font-weight: 500;
}
.alert-content-area .timestamp {
    font-size: 0.92em;
    color: #9d4edd;
    font-weight: 400;
    margin-left: 8px;
}
.alert-actions-area {
    display: flex;
    gap: 8px;
    margin-left: 10px;
}
body .btn.mark-read-btn, body .btn.delete-alert-btn {
    border-radius: 8px;
    background: linear-gradient(90deg,#8a2be2,#9d4edd);
    color: #fff;
    border: none;
    margin-left: 8px;
    box-shadow: 0 2px 8px #8a2be2a0;
    transition: background 0.2s;
    font-weight: 600;
    padding: 6px 16px;
    font-size: 1em;
}
body .btn.mark-read-btn:hover, body .btn.delete-alert-btn:hover {
    background: linear-gradient(90deg,#9d4edd,#8a2be2);
}
#artist-filter-select {
    padding: 7px 12px;
    border: 2px solid #8a2be2;
    border-radius: 8px;
    background: rgba(255,255,255,0.7);
    color: #8a2be2;
    font-weight: bold;
    margin-right: 10px;
}
#btn-mark-all-alerts-read-content {
    background: linear-gradient(90deg,#8a2be2,#9d4edd);
    color: white;
    border: none;
    padding: 7px 18px;
    border-radius: 8px;
    font-weight: 600;
    box-shadow: 0 2px 8px #8a2be2a0;
    transition: background 0.2s;
}
#btn-mark-all-alerts-read-content:hover {
    background: linear-gradient(90deg,#9d4edd,#8a2be2);
}
.no-alerts {
    padding: 30px 0;
    text-align: center;
    color: #888;
    font-size: 1.1em;
}
::-webkit-scrollbar {
    width: 8px;
    background: rgba(138,43,226,0.08);
    border-radius: 8px;
}
::-webkit-scrollbar-thumb {
    background: linear-gradient(135deg,#8a2be2,#9d4edd);
    border-radius: 8px;
}
</style>

<section id="alerts-content" class="mypage-section active-section">
    <div class="mypage-section-header">
        <h3>${pageTitle} <c:if test="${unreadCnt > 0}"><span class="badge badge-danger">${unreadCnt}</span></c:if></h3>
        <div class="alert-filter-area">
        	<select id="artist-filter-select" class="form-control form-control-sm" onchange="filterAlertsByArtist()">
        		<option value="">모든 아티스트 알림</option>
        		<c:forEach var="group" items="${followedGroups}">
        			<option value="${group.artGroupNo}" <c:if test="${group.artGroupNo == selectedArtGroupNo}">selected</c:if>>
        				${group.artGroupNm}
        			</option>
        		</c:forEach>
        	</select>
        </div>
        <button type="button" id="btn-mark-all-alerts-read-content" class="btn-mypage-secondary small-btn">모두 읽음 처리 및 삭제</button>
    </div>


    <div id="alertListServerMessage" class="server-message"></div>
    <c:if test="${not empty alertErrorMessage}"><div class="server-message error" style="display:block;">${alertErrorMessage}</div></c:if>
    <c:if test="${not empty alertSuccessMessage}"><div class="server-message success" style="display:block;">${alertSuccessMessage}</div></c:if>

    <div class="alert-list-container">
        <c:choose>
            <c:when test="${not empty pagingVO.dataList && fn:length(pagingVO.dataList) > 0}">
                <c:forEach var="alert" items="${pagingVO.dataList}">
					<div class="alert-item ${alert.alertReadYn eq 'N' ? 'unread' : 'read'}"
                         data-alert-no="${alert.alertNo}"
                         data-alert-url="<c:url value='${alert.alertUrl}'/>"
                         data-alert-readyn="${alert.alertReadYn}">
                        <div class="alert-icon-area">
                            <c:choose>
				                <c:when test="${alert.alertTypeCode eq 'ATC001'}"><i class="fas fa-bullhorn" title="새 게시글"></i></c:when>
				                <c:when test="${alert.alertTypeCode eq 'ATC002'}"><i class="fas fa-reply" title="새 댓글"></i></c:when>
				                <c:when test="${alert.alertTypeCode eq 'ATC003'}"><i class="fas fa-comments" title="새 채팅"></i></c:when>
				                <c:when test="${alert.alertTypeCode eq 'ATC004'}"><i class="fas fa-video" title="라이브 시작"></i></c:when>
				                <c:when test="${alert.alertTypeCode eq 'ATC005'}"><i class="fas fa-heart" title="새 좋아요"></i></c:when>
				                <c:when test="${alert.alertTypeCode eq 'ATC006'}"><i class="fas fa-user-friends" title="멤버십 변경/시작"></i></c:when>
				                <c:when test="${alert.alertTypeCode eq 'ATC007'}"><i class="fas fa-microphone-alt" title="새 콘서트"></i></c:when>
				                <c:when test="${alert.alertTypeCode eq 'ATC008'}"><i class="fas fa-stop-circle" title="라이브 종료"></i></c:when>
				                <c:otherwise><i class="fas fa-bell" title="기타 알림"></i></c:otherwise>
				            </c:choose>
                        </div>
                        <div class="alert-content-area">
                            <span class="message">${alert.alertContent != null ? fn:replace(alert.alertContent, '
', '<br>') : '새로운 알림'}</span>
                            <span class="timestamp">
                            	<fmt:formatDate value="${alert.alertCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </span>
                        </div>
                        <div class="alert-actions-area">
							<c:if test="${alert.alertReadYn eq 'N'}">
                                <button type="button" class="btn btn-sm btn-outline-primary mark-read-btn" data-alert-no="${alert.alertNo}">읽음</button>
                            </c:if>
                            <button type="button" class="btn btn-sm btn-outline-danger delete-alert-btn" data-alert-no="${alert.alertNo}">삭제</button>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="no-alerts" style="padding: 20px; text-align: center; color: #777;">표시할 알림이 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>
    <%-- 페이징 UI 추가 --%>
    <div class="pagination-container" id="pagingArea">
             ${pagingVO.pagingHTML}
        </div>
</section>
<script>
// CSRF 토큰 설정
const csrfToken = $("meta[name='_csrf']").attr("content");
const csrfHeader = $("meta[name='_csrf_header']").attr("content");
const headers = {};
if (csrfToken && csrfHeader) {
    headers[csrfHeader] = csrfToken;
}

// 아티스트 그룹 필터 적용 함수
function filterAlertsByArtist() {
    const selectedGroupNo = document.getElementById("artist-filter-select").value;
    const currentUrl = '<c:url value="/mypage/alerts"/>';
    const params = new URLSearchParams(window.location.search);

    if (selectedGroupNo) {
        params.set('artGroupNo', selectedGroupNo);
    } else {
        params.delete('artGroupNo'); // "모든 아티스트 알림" 선택 시 파라미터 제거 -> 전체보여주기
    }

    // 필터 변경 시 첫 페이지로 초기화
    params.set('currentPage', '1');

    window.location.href = currentUrl + (params.toString() ? '?' + params.toString() : '');
}
// window 객체에 함수 등록 (onchange에서 호출 가능하도록)
window.filterAlertsByArtist = filterAlertsByArtist;


$(function(){
    const alertListContent = $('#alerts-content'); // 현재 섹션 컨테이너

    // === 페이징 로직 시작 ===
    const pagingArea = $('#pagingArea');
    const artistFilterSelect = $('#artist-filter-select'); // 아티스트 필터 드롭다운

    function showAlert(icon, title, text) {
        Swal.fire({
            icon: icon,
            title: title,
            text: text,
            showConfirmButton: false,
            timer: 1500
        });
    }

    if(pagingArea.length > 0) {
        // 페이징 링크 클릭 이벤트 바인딩
        // PaginationInfoVO의 getPagingHTML()에서 생성되는 <a> 태그의 data-page 속성을 이용
        pagingArea.on('click', 'a.page-link', function(event) {
            event.preventDefault(); // 기본 링크 이동 방지
            const page = $(this).data('page'); // 클릭된 페이지 번호 가져옴

            // 현재 선택된 아티스트 그룹 필터 값 가져오기
            const currentArtGroupNo = artistFilterSelect.val();

            // 페이지 이동을 위한 URL 구성
            let targetPageUrl = '<c:url value="/mypage/alerts"/>?currentPage=' + page;

            if (currentArtGroupNo && currentArtGroupNo !== '') {
                targetPageUrl += '&artGroupNo=' + encodeURIComponent(currentArtGroupNo);
            }

//             console.log("알림 내역 페이지네이션 클릭: " + targetPageUrl);
            window.location.href = targetPageUrl; // 페이지 이동
        });
    }
    // === 페이징 로직 끝 ===

    function updateAlertBadge(count) {		// 안읽은 알림 개수 받아서 UI 업데이트
        unreadAlertCount = count;
        if (unreadAlertCount > 0) {
            alertBadge.text(unreadAlertCount > 99 ? "99+" : unreadAlertCount).show();
        } else {
            alertBadge.hide();
        }
    }


    // 개별 알림 항목 클릭 시 처리 (읽음 처리 + URL 이동)
    // 버튼 클릭이 아닌 알림 항목의 빈 공간 클릭 시 작동
    alertListContent.on('click', '.alert-item', function(event) {
        const clickedElement = $(event.target);
        // '읽음' 또는 '삭제' 버튼을 직접 클릭한 경우는 제외
        if (!clickedElement.hasClass('mark-read-btn') &&
            !clickedElement.hasClass('delete-alert-btn') &&
            !clickedElement.closest('.mark-read-btn').length && // 버튼 내부의 아이콘 등 클릭 시
            !clickedElement.closest('.delete-alert-btn').length &&
            !clickedElement.hasClass('alert-link')) { // 기존 a.alert-link 클릭 시 중복 이벤트 방지

            const alertNo = $(this).data('alertNo');
            const alertUrl = $(this).data('alertUrl'); // 새로 추가된 data-alert-url 사용
            const alertReadYn = $(this).data('alertReadyn'); // 새로 추가된 data-alert-readyn 사용

            if (alertReadYn === 'N') { // 읽지 않은 알림일 경우에만 읽음 처리 요청
                $.ajax({
                    url: '<c:url value="/mypage/alerts/read"/>',
                    type: 'POST',
                    data: { alertNo: alertNo },
                    headers: headers,
                    success: function(response) {
                        if (response.success) {
                            const item = $(`div.alert-item[data-alert-no="\${alertNo}"]`);
                            item.removeClass('unread').addClass('read');
                            item.data('alertReadyn', 'Y'); // data 속성도 업데이트
                            item.find('.mark-read-btn').remove();

                            const currentUnread = parseInt($('.unread-count-display').text() || "0");
                            const newUnread = Math.max(0, currentUnread - 1);
                            if (typeof updateHeaderBadgeCount === 'function') { // 함수 존재 여부 확인
                                updateHeaderBadgeCount(newUnread);
                            } else {
                                console.warn("updateHeaderBadgeCount 함수를 찾을 수 없습니다.");
                            }
                            setTimeout(function() {
                                window.location.reload();
                            }, 1600);
                        } else {
                            console.warn("알림 읽음 처리 실패(서버):", response.message);
                        }
                    },
                    error: function(xhr) {
                        console.error("알림 읽음 처리 중 오류:", xhr.responseText);
                    },
                    complete: function() {
                        // 읽음 처리 성공/실패와 관계없이 URL로 이동
                        if (alertUrl && alertUrl !== '#') {
                            // 채팅 관련 URL인지 확인
                            if (alertUrl.includes('/chat/dm/channel/enter/')) {
                                // 채팅방 직접 입장
                                window.location.href = alertUrl;
                            } else if(alertUrl.startsWith('javascript:')){
                                const jsCode = alertUrl.replace('javascript:', '');
                                if(jsCode.includes('openDmModal')) {
                                    // openDmModal 함수 호출 추출
                                    const match = jsCode.match(/openDmModal\(['"]?(\d+)['"]?\)/);
                                    if(match && match[1]) {
                                        const channelId = match[1];
                                        if(typeof window.openDmModal === 'function'){
                                            window.openDmModal(channelId);	// 채팅 모달 열기
                                        } else {
                                            console.error("openDmModal 함수 정의되지 않음 채널로 이동");
                                            window.location.href = '/chat/dm/channel';
                                        }
                                    } else {
                                        // openDmModal 함수만 호출 (채널 ID 없음)
                                        if(typeof window.openDmModal === 'function'){
                                            window.openDmModal();	// 채팅 모달 열기
                                        } else {
                                            console.error("openDmModal 함수 정의되지 않음 채널로 이동");
                                            window.location.href = '/chat/dm/channel';
                                        }
                                    }
                                } else {
                                    eval(jsCode);
                                }
                            } else {
                                window.location.href = alertUrl;
                            }
                        }
                    }
                });
            } else { // 이미 읽은 알림도 javascript처리
                if (alertUrl && alertUrl !== '#') {
                    // 채팅 관련 URL인지 확인
                    if (alertUrl.includes('/chat/dm/channel/enter/')) {
                        // 채팅방 직접 입장
                        window.location.href = alertUrl;
                    } else if (alertUrl.startsWith('javascript:')) {
                        const jsCode = alertUrl.replace('javascript:', '');
                        if(jsCode.includes('openDmModal')) {
                            // openDmModal 함수 호출 추출
                            const match = jsCode.match(/openDmModal\(['"]?(\d+)['"]?\)/);
                            if(match && match[1]) {
                                const channelId = match[1];
                                if(typeof window.openDmModal === 'function'){
                                    window.openDmModal(channelId);	// 채팅 모달 열기
                                } else {
                                    console.error("openDmModal 함수 정의되지 않음 채널로 이동");
                                    window.location.href = '/chat/dm/channel';
                                }
                            } else {
                                // openDmModal 함수만 호출 (채널 ID 없음)
                                if(typeof window.openDmModal === 'function'){
                                    window.openDmModal();	// 채팅 모달 열기
                                } else {
                                    console.error("openDmModal 함수 정의되지 않음 채널로 이동");
                                    window.location.href = '/chat/dm/channel';
                                }
                            }
                        } else {
                            eval(jsCode);
                        }
                    } else {
                        window.location.href = alertUrl;
                    }
                }
            }
        }
    });


    // 개별 알림 읽음 처리 (버튼 클릭 시)
    alertListContent.on('click', '.mark-read-btn', function(event) {
        event.stopPropagation(); // alert-item 클릭 이벤트가 전파되지 않도록 방지
        const alertNo = $(this).data('alertNo');
        const item = $(this).closest('.alert-item');
        const button = $(this);

        $.ajax({
            url: '<c:url value="/mypage/alerts/read"/>',
            type: 'POST',
            data: { alertNo: alertNo },
            headers: headers,
            success: function(response) {
                if (response.success) {
                    item.removeClass('unread').addClass('read');
                    item.data('alertReadyn', 'Y'); // data 속성도 업데이트
                    button.remove(); // 읽음 버튼 제거
                    showAlert('success', '성공', response.message || '알림을 읽음 처리했습니다.');

                    const currentUnread = parseInt($('.unread-count-display').text() || "0");
                    const newUnread = Math.max(0, currentUnread - 1);
                    if (typeof updateHeaderBadgeCount === 'function') { // 함수 존재 여부 확인
                        updateHeaderBadgeCount(newUnread);
                    } else {
                        console.warn("updateHeaderBadgeCount 함수를 찾을 수 없습니다.");
                    }
                    setTimeout(function() {
                        window.location.reload();
                    }, 1600);

                } else {
                    showAlert('error', '오류', response.message || '알림 읽음 처리에 실패했습니다.');
                }
            },
            error: function() {
                showAlert('error', '오류', '알림 읽음 처리 중 서버 오류가 발생했습니다.');
            }
        });
    });

    // 개별 알림 삭제 처리 (논리적)
    alertListContent.on('click', '.delete-alert-btn', function(event) {
        event.stopPropagation(); // alert-item 클릭 이벤트가 전파되지 않도록 방지
        const alertNo = $(this).data('alertNo');
        const item = $(this).closest('.alert-item');
		const wasUnread = item.hasClass('unread'); // 삭제 전 안읽음 상태였는지 확인

        Swal.fire({
            title: '확인',
            text: "이 알림을 삭제하시겠습니까?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '네, 삭제합니다!',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '<c:url value="/mypage/alerts/delete"/>',
                    type: 'POST',
                    data: { alertNo: alertNo },
                    headers: headers,
                    success: function(response) {
                        if (response.success) {
                            item.fadeOut(300, function() { // 부드러운 삭제 효과
                                $(this).remove();
                                // 모든 알림이 삭제되었을 경우 메시지 표시
                                if (alertListContent.find('.alert-item').length === 0) {
                                     alertListContent.find('.alert-list-container').html('<p class="no-alerts" style="padding: 20px; text-align: center; color: #777;">표시할 알림이 없습니다.</p>');
                                }
                            });
                            showAlert('success', '성공', response.message || '알림을 삭제했습니다.');
                            setTimeout(function() {
                                window.location.reload();
                            }, 1600);
                            if(wasUnread){ // 안읽은 알림이 삭제된 경우에만 개수 업데이트
                                const currentUnread = parseInt($('.unread-count-display').text() || "0");
                                const newUnread = Math.max(0, currentUnread - 1);
                                if (typeof updateHeaderBadgeCount === 'function') {
                                    updateHeaderBadgeCount(newUnread); // mypageMain.jsp에 정의된 함수 호출
                                }
                            }
                        } else {
                            showAlert('error', '오류', response.message || '알림 삭제에 실패했습니다.');
                        }
                    },
                    error: function() {
                        showAlert('error', '오류', '알림 삭제 중 서버 오류가 발생했습니다.');
                    }
                });
            }
        });
    });

    // 모두 읽음 처리
    $('#btn-mark-all-alerts-read-content').on('click', function() {

        Swal.fire({
            title: '확인',
            text: "모든 알림을 읽음처리 후 삭제하시겠습니까?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '<c:url value="/mypage/alerts/readAll"/>',
                    type: 'POST',
                    headers: headers,
                    success: function(response) {
                        if (response.success) {
                            alertListContent.find('.alert-item.unread').each(function() {
                                $(this).removeClass('unread').addClass('read');
                                $(this).data('alertReadyn', 'Y'); // data 속성도 업데이트
                                $(this).find('.mark-read-btn').remove();
                            });
                            showAlert('success', '성공', response.message || '모든 알림을 읽음 처리 후 삭제했습니다.');
                            if (typeof updateHeaderBadgeCount === 'function') {
                                updateHeaderBadgeCount(0); // mypageMain.jsp에 정의된 함수 호출
                            }
                            setTimeout(function() {
                                window.location.reload();
                            }, 1600);
                        } else {
                            showAlert('error', '오류', response.message || '모든 알림 읽음 처리에 실패했습니다.');
                        }
                    },
                    error: function() {
                        showAlert('error', '오류', '모든 알림 읽음 처리 중 서버 오류가 발생했습니다.');
                    }
                });
            }
        });
    });
});
</script>