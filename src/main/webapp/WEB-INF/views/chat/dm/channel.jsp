<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <title>채팅방 목록</title>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; margin: 0; padding: 15px; background-color: #f7f9fb; }
        ul { list-style: none; padding: 0; margin: 0; }
        li {
            padding: 15px;
            margin-bottom: 10px;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            cursor: pointer; /* 클릭 가능한 요소임을 표시 */
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: all 0.2s ease-in-out; /* 호버 애니메이션 */
            height: 90px;
        }
        li:hover {
            background-color: #f0f5f8;
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
        }
        .no-channels {
            color: #a0a0a0;
            font-style: italic;
            text-align: center;
            padding: 20px; /* 패딩 증가 */
            font-size: 1em;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .channel-info-header {
        	display: flex;
        	justify-content: space-between;
        	align-items: center;
        	width: 100%;
        	margin-bottom: 8px;
        }
        .channel-name {
        	font-weight: 600;
        	font-size: 1.2em;
        	color: #333;
        	display: flex;
        	align-items: center;
        }
        .artist-badge { /* Added CSS for the badge */
            background-image: linear-gradient(to right, #8a2be2, #ff69b4);
            background-size: 100% 100%;
            background-repeat: no-repeat;
            color: white;
            font-size: 0.7em;
            font-weight: bold;
            padding: 2px 6px;
            border-radius: 4px;
            margin-right: 8px; /* Space between badge and name */
            white-space: nowrap;
        }
        .unread-count {
        	background-color: #ff5c5c;
        	color: white;
        	font-weight: bold;
        	padding: 4px 9px;
        	border-radius: 15px;
        	font-size: 0.85em;
        	margin-left: 15px;
        	min-width: 25px;
        	text-align: center;
        }
        .last-message-content {
        	font-size: 0.95em;
        	color: #555;
        	white-space: nowrap;
        	overflow: hidden;
        	text-overflow: ellipsis;
        	width: 100%;
        	margin-bottom: 5px;
        	line-height: 1.4; /* 줄 간격 */

        }
        .last-message-time {
        	font-size: 0.8em;
        	color: #999;
        	width: 100%;
        	text-align: right;
        	margin-top: 5px;
        }
    </style>
    <script type="text/javascript">
    	const contextPath = '${pageContext.request.contextPath}';
    </script>
</head>
<body>
    <ul id="chatChannelList"></ul>

    <script type="text/javascript">

        document.addEventListener('DOMContentLoaded', function() {
            const chatChannelList = document.getElementById('chatChannelList');
            const currentUser = "<sec:authentication property='name'/>";

            if(!currentUser || currentUser.trim() === '') {
            	alert("로그인 후 이용 가능합니다.");
            	return;
            }

            localStorage.setItem('wschat.username', currentUser);

            // 채팅방 목록 조회 함수
            function findAllChannel() {
                // 서버의 /chat/rooms 엔드포인트로 GET 요청을 보냅니다.
                fetch(contextPath + '/chat/dm/channels')
                    .then(response => {
                        // 응답이 성공적(HTTP 200 OK)인지 확인합니다.
                        if (!response.ok) {
                            throw new Error('HTTP 오류! 상태: ' + response.status);
                        }
                        return response.json(); // JSON 형태로 응답을 파싱합니다.
                    })
                    .then(chatChannels => {
                        // 기존 목록을 비웁니다.
                        chatChannelList.innerHTML = '';

                        if (chatChannels.length === 0) {
                            // 채팅방이 없을 경우 메시지를 표시합니다.
                            const listItem = document.createElement('li');
                            listItem.textContent = '아직 참여 중인 채팅방이 없습니다.';
                            listItem.classList.add('no-channels');
                            chatChannelList.appendChild(listItem);
                        } else {
                            // 각 채팅방 정보를 순회하며 목록에 추가합니다.
                            chatChannels.forEach(item => {
                                const listItem = document.createElement('li');
                                listItem.addEventListener('click', () => enterChannel(item.chatChannelNo));

                                // 채널 헤더
                                const channelHeader = document.createElement('div');
                                channelHeader.classList.add('channel-info-header');

                                // 채팅방 이름
                                const channelName = document.createElement('span');
                                channelName.classList.add('channel-name');

                            	 // 아티스트 전용 뱃지 추가 (HTML로 직접 삽입)
                                channelName.innerHTML = `<span class="artist-badge">ARTIST</span> \${item.artistComuNicknm}`;
                                channelHeader.appendChild(channelName);

                                // 읽지 않은 채팅 개수 표시
                                if(item.unreadMessageCount > 0) {
                                	const unreadSpan = document.createElement('span');
                                	unreadSpan.classList.add('unread-count');
                                	unreadSpan.textContent = item.unreadMessageCount;
                                	channelHeader.appendChild(unreadSpan);
                                }
                                listItem.appendChild(channelHeader);

                                // 최근 메세지 내용
                                const lastMessageContentSpan = document.createElement('div');
                                lastMessageContentSpan.classList.add('last-message-content');

                                if(item.lastMessageContent) {
                                	lastMessageContentSpan.textContent = item.lastMessageContent;
                                } else {
                                	lastMessageContentSpan.textContent = '메세지 없음';
                                }
                                listItem.appendChild(lastMessageContentSpan);

                                const lastMessageTimeSpan = document.createElement('div');
                                lastMessageTimeSpan.classList.add('last-message-time');

                                if(item.lastMessageSendDate) {
                                	const date = new Date(item.lastMessageSendDate);
                                	const formattedTime = date.toLocaleString('ko-KR', {
                                		year: 'numeric',
                                		month: '2-digit',
                                		day: '2-digit',
                                		hour: '2-digit',
                                		minute: '2-digit',
                                		hour12: false
                                	});
                                	lastMessageTimeSpan.textContent = formattedTime;
                                } else {
                                	lastMessageTimeSpan.textContent = '';
                                }
                                listItem.appendChild(lastMessageTimeSpan);

                                chatChannelList.appendChild(listItem);
                            });
                        }
                    })
                    .catch(error => {
                        console.error("채팅방 목록을 가져오는 데 실패했습니다:", error.message);
                        alert("채팅방 목록을 가져오는 중 오류가 발생했습니다: " + error.message);
                    });
            }

            // 채팅방 입장 함수
            function enterChannel(chatChannelNo) {
            	localStorage.setItem('wschat.chatChannelNo', chatChannelNo);	// 채널 번호 저장

            	// 부모 창의 iframe 요소 찾아서 src 변경
            	const parentIframe = window.parent.document.getElementById('dmChannelListIframe');
                const newSrc = `\${contextPath}/chat/dm/channel/enter/\${chatChannelNo}`;

            	if(parentIframe) {
            		// 중복 변경 방지
                    if (parentIframe.src === newSrc || parentIframe.contentWindow.location.pathname === new URL(newSrc, window.location.origin).pathname) {
//                         console.log("이미 해당 채널로 이동 중이므로 src 변경하지 않음:", newSrc);
                        return;
                    }
//                     console.log("iframe src 변경:", parentIframe.src, "→", newSrc);
                    parentIframe.src = newSrc;
            	} else {
            		console.warn("오류: 부모 iframe을 찾을 수 없습니다.");
            	}
            }
            // 페이지 로드 시 채팅방 목록을 즉시 불러옵니다.
            findAllChannel();
        });
    </script>
</body>
</html>