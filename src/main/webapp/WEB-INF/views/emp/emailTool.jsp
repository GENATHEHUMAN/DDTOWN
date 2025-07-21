<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDTOWN - 이메일 전송 도구</title>
    <%@ include file ="../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="emp-container">
        <%@ include file="./modules/header.jsp" %>

        <div class="emp-body-wrapper">
            <%@ include file="./modules/aside.jsp" %>

            <main class="emp-content">
                <div class="emp-welcome-message">
                    <h2>이메일 전송 도구</h2>
                    <p>대내외 공지 및 마케팅 이메일을 작성하고 발송하세요.</p>
                </div>

                <div class="email-tool-container">
                    <form id="email-form" class="email-form">
                        <div class="form-group">
                            <label for="email-type">이메일 유형</label>
                            <select id="email-type" name="email-type" required>
                                <option value="">선택하세요</option>
                                <option value="notice">공지사항</option>
                                <option value="marketing">마케팅</option>
                                <option value="event">이벤트</option>
                                <option value="newsletter">뉴스레터</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="email-subject">제목</label>
                            <input type="text" id="email-subject" name="email-subject" required placeholder="이메일 제목을 입력하세요">
                        </div>

                        <div class="form-group">
                            <label for="email-content">내용</label>
                            <textarea id="email-content" name="email-content" rows="10" required placeholder="이메일 내용을 입력하세요"></textarea>
                        </div>

                        <div class="form-group">
                            <label>수신자 그룹</label>
                            <div class="recipient-groups">
                                <label><input type="checkbox" name="recipient-group" value="all"> 전체 직원</label>
                                <label><input type="checkbox" name="recipient-group" value="artists"> 아티스트</label>
                                <label><input type="checkbox" name="recipient-group" value="fans"> 팬클럽</label>
                                <label><input type="checkbox" name="recipient-group" value="partners"> 협력사</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email-attachment">첨부파일</label>
                            <input type="file" id="email-attachment" name="email-attachment" multiple>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="emp-btn secondary" id="preview-btn">미리보기</button>
                            <button type="submit" class="emp-btn primary">발송하기</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>

        <footer class="emp-footer">
            <p>&copy; 2025 DDTOWN Entertainment. All rights reserved. (직원 전용)</p>
        </footer>
    </div>

    <script>
        // 로그아웃 기능
        const logoutButton = document.querySelector('.emp-logout-btn');
        if (logoutButton) {
            logoutButton.addEventListener('click', function(e) {
                e.preventDefault();
                if (confirm('로그아웃 하시겠습니까?')) {
                    alert('로그아웃 되었습니다.');
                }
            });
        }

        // 직원 이름 등 동적 데이터 로드
        const employeeNameSpan = document.getElementById('employee-name');
        if (employeeNameSpan) {
            employeeNameSpan.textContent = "홍길동";
        }

        // 사이드바 토글 및 활성화 스크립트
        document.addEventListener('DOMContentLoaded', function() {
            const navItemsWithSubmenu = document.querySelectorAll('.emp-sidebar .emp-nav-item.has-submenu');
            navItemsWithSubmenu.forEach(item => {
                const arrow = item.querySelector('.submenu-arrow');
                item.addEventListener('click', function(event) {
                    event.preventDefault();
                    const parentLi = this.parentElement;
                    const submenu = this.nextElementSibling;
                    if (submenu && submenu.classList.contains('emp-submenu')) {
                        const parentUl = parentLi.parentElement;
                        if (parentUl) {
                            Array.from(parentUl.children).forEach(siblingLi => {
                                if (siblingLi !== parentLi) {
                                    const siblingSubmenuControl = siblingLi.querySelector('.emp-nav-item.has-submenu.open');
                                    if (siblingSubmenuControl) {
                                        const siblingSubmenu = siblingSubmenuControl.nextElementSibling;
                                        siblingSubmenuControl.classList.remove('open');
                                        if (siblingSubmenu && siblingSubmenu.classList.contains('emp-submenu')) {
                                            siblingSubmenu.style.display = 'none';
                                        }
                                        const siblingArrow = siblingSubmenuControl.querySelector('.submenu-arrow');
                                        if (siblingArrow) siblingArrow.style.transform = 'rotate(0deg)';
                                    }
                                }
                            });
                        }
                    }
                    this.classList.toggle('open');
                    if (submenu && submenu.classList.contains('emp-submenu')) {
                        submenu.style.display = this.classList.contains('open') ? 'block' : 'none';
                        if (arrow) arrow.style.transform = this.classList.contains('open') ? 'rotate(90deg)' : 'rotate(0deg)';
                    }
                });
            });

            // 현재 페이지 URL 기반으로 사이드바 메뉴 활성화
            const currentFullHref = window.location.href;

            document.querySelectorAll('.emp-sidebar .emp-nav-item[href]').forEach(link => {
                const linkHrefAttribute = link.getAttribute('href');

                if (linkHrefAttribute && linkHrefAttribute !== "#" && currentFullHref.endsWith(linkHrefAttribute)) {
                    link.classList.add('active');

                    let currentActiveElement = link;

                    while (true) {
                        const parentLi = currentActiveElement.parentElement;
                        if (!parentLi) break;

                        const parentSubmenuUl = parentLi.closest('.emp-submenu');

                        if (parentSubmenuUl) {
                            parentSubmenuUl.style.display = 'block';

                            const controllingAnchor = parentSubmenuUl.previousElementSibling;

                            if (controllingAnchor && controllingAnchor.tagName === 'A' && controllingAnchor.classList.contains('has-submenu')) {
                                controllingAnchor.classList.add('active', 'open');
                                const arrow = controllingAnchor.querySelector('.submenu-arrow');
                                if (arrow) {
                                    arrow.style.transform = 'rotate(90deg)';
                                }
                                currentActiveElement = controllingAnchor;
                            } else {
                                break;
                            }
                        } else {
                            break;
                        }
                    }
                }
            });
        });

        // 이메일 폼 제출 처리
        const emailForm = document.getElementById('email-form');
        if (emailForm) {
            emailForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // 수신자 그룹 선택 확인
                const selectedGroups = document.querySelectorAll('input[name="recipient-group"]:checked');
                if (selectedGroups.length === 0) {
                    alert('최소 하나 이상의 수신자 그룹을 선택해주세요.');
                    return;
                }

                // 이메일 발송 확인
                if (confirm('이메일을 발송하시겠습니까?')) {
                    alert('이메일이 성공적으로 발송되었습니다.');
                    emailForm.reset();
                }
            });
        }

        // 미리보기 버튼 처리
        const previewBtn = document.getElementById('preview-btn');
        if (previewBtn) {
            previewBtn.addEventListener('click', function() {
                const subject = document.getElementById('email-subject').value;
                const content = document.getElementById('email-content').value;
                
                if (!subject || !content) {
                    alert('제목과 내용을 모두 입력해주세요.');
                    return;
                }

                // 미리보기 창 표시
                const previewWindow = window.open('', '이메일 미리보기', 'width=800,height=600');
                previewWindow.document.write(`
                    <html>
                    <head>
                        <title>이메일 미리보기</title>
                        <style>
                            body { font-family: Arial, sans-serif; padding: 20px; }
                            .preview-header { border-bottom: 1px solid #eee; padding-bottom: 10px; margin-bottom: 20px; }
                            .preview-subject { font-size: 18px; font-weight: bold; margin-bottom: 10px; }
                            .preview-content { white-space: pre-wrap; }
                        </style>
                    </head>
                    <body>
                        <div class="preview-header">
                            <div class="preview-subject">\${subject}</div>
                        </div>
                        <div class="preview-content">\${content}</div>
                    </body>
                    </html>
                `);
            });
        }
    </script>
</body>
</html>