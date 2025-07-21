<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>그룹 관리 - DDTOWN 직원 포털</title>
    <%@ include file ="../../modules/headerPart.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/group-management.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/pagination.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <div class="emp-container">
        <%@ include file="../modules/header.jsp" %>

        <div class="emp-body-wrapper">
            <%@ include file="../modules/aside.jsp" %>

            <main class="emp-content">
            	<section class="ea-section">
                    <div class="ea-section-header">
		            	<h2 style="margin-bottom: 15px;">그룹 프로필</h2>
		            </div>
	                <c:if test="${not empty artistGroupList}">
	                    <table class="ea-table">
	                        <thead>
	                            <tr>
	                                <th>번호</th>
	                                <th class="col-profile-path">프로필 이미지</th>
	                                <th>그룹명</th>
	                                <th>데뷔일자</th>
	                                <th>최근 수정일</th>
	                                <th class="col-actions">관리</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <c:forEach items="${artistGroupList}" var="group">
	                                <tr>
	                                    <td>${group.artGroupNo}</td>
	                                    <td class="col-profile-path">
                                            <c:if test="${not empty group.artGroupProfileImg}">
                                                <img src="${pageContext.request.contextPath}${group.artGroupProfileImg}" alt="${group.artGroupNm} 프로필" style="width:50px; height:auto; border-radius:4px;">
                                            </c:if>
                                            <c:if test="${empty group.artGroupProfileImg}">
                                                <span>이미지 없음</span>
                                            </c:if>
                                        </td>
	                                    <td><c:out value="${group.artGroupNm}" /></td>
	                                    <td>${group.artGroupDebutdate}</td>
	                                    <td><fmt:formatDate value="${group.artGroupModDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                                    <td>
	                                        <c:set var="initialMembersJsonString" value="[]" />
	                                        <c:if test="${not empty group.artistList}">
	                                            <c:set var="memberJsonBuilder">
	                                                <c:forEach items="${group.artistList}" var="artist" varStatus="loopStatus">
	                                                    {"artNo": "${artist.artNo}", "artNm": "<c:out value='${artist.artNm}' escapeXml='true' />"}${!loopStatus.last ? ',' : ''}
	                                                </c:forEach>
	                                            </c:set>
	                                            <c:set var="initialMembersJsonString" value="[${memberJsonBuilder}]" />
	                                        </c:if>

	                                        <%-- 초기 앨범 정보 JSON 생성 --%>
	                                        <c:set var="initialAlbumsJsonString" value="[]" />
	                                        <c:if test="${not empty group.albumList}">
	                                            <c:set var="albumJsonBuilder">
	                                                <c:forEach items="${group.albumList}" var="album" varStatus="loopStatus">
	                                                    {"albumNo": "${album.albumNo}", "albumNm": "<c:out value='${album.albumNm}' escapeXml='true' />"}${!loopStatus.last ? ',' : ''}
	                                                </c:forEach>
	                                            </c:set>
	                                            <c:set var="initialAlbumsJsonString" value="[${albumJsonBuilder}]" />
	                                        </c:if>

	                                        <button class="ea-btn sm outline edit-group-btn"
	                                            data-group-no="${group.artGroupNo}"
	                                            data-group-nm="<c:out value='${group.artGroupNm}'/>"
	                                            data-group-debutdate="${group.artGroupDebutdate}"
	                                            data-group-typecode="${group.artGroupTypeCode}"
	                                            data-group-initial-members='${initialMembersJsonString}'
	                                            data-group-initial-albums='${initialAlbumsJsonString}'
	                                            data-group-content="<c:out value='${group.artGroupContent}' escapeXml='true'/>"
	                                            data-group-profileimg="${group.artGroupProfileImg}">
                                                <i class="fas fa-edit"></i> 수정
                                            </button>
	                                    </td>
	                                </tr>
	                            </c:forEach>
	                        </tbody>
	                    </table>
	                </c:if>
	                <c:if test="${empty artistGroupList}">
	                    <p style="text-align: center;">등록된 그룹이 없습니다.</p>
	                </c:if>
                </section>
            </main>
        </div>
    </div>

    <%-- 그룹 정보 수정 모달 --%>
    <div id="editGroupModal" class="modal">
        <div class="modal-content">
            <span class="close-button">&times;</span>
            <h2>그룹 정보 수정</h2>
            <hr>
            <form id="editGroupForm">
                <input type="hidden" id="modalGroupNo" name="artGroupNo">

                <input type="hidden" id="modalExistingGroupProfileImg" name="existingGroupProfileImg">

                <div class="form-group">
                    <label for="modalGroupName">그룹명:</label>
                    <input type="text" id="modalGroupName" name="artGroupNm" class="form-control">
                </div>
                <div class="form-group">
                    <label for="modalDebutDate">데뷔일 (YYYY-MM-DD):</label>
                    <input type="text" id="modalDebutDate" name="artGroupDebutdate" class="form-control" placeholder="예: 2024-01-01">
                </div>
                 <div class="form-group">
                    <fieldset>
                        <legend style="font-weight: bold; padding: 0; margin-bottom: 5px; border: 0; display: block; width:auto;">활동유형:</legend>
                        <div class="radio-options-wrapper" style="display: flex; align-items: center; margin-top: 5px;">
                            <label class="radio-label" for="artGroupTypeGroup" style="margin-right: 15px; cursor:pointer; font-weight:normal; display: inline-flex; align-items: center; white-space: nowrap;">
                                그룹 <input type="radio" name="artGroupTypeCode" value="AGTC001" id="artGroupTypeGroup" style="margin-left: 5px;">
                            </label>
                            <label class="radio-label" for="artGroupTypeSolo" style="cursor:pointer; font-weight:normal; display: inline-flex; align-items: center; white-space: nowrap;">
                                솔로 <input type="radio" name="artGroupTypeCode" value="AGTC002" id="artGroupTypeSolo" style="margin-left: 5px;">
                            </label>
                        </div>
                    </fieldset>
                </div>

                <div class="form-group">
                    <fieldset>
                        <legend class="form-label" style="font-weight: bold; padding: 0; margin-bottom: 10px; border: 0; display: block; width: auto;">소속멤버:</legend>
                        <div id="selectedMembersContainer" class="members-container" style="margin-bottom: 10px; min-height: 40px; border: 1px solid #ddd; padding: 8px; border-radius: 4px;"></div>
                        <div class="input-group-for-member-add" style="display: flex; gap: 8px; align-items: center; margin-bottom: 10px;">
                            <select id="artistSelect" class="form-control" style="flex-grow: 1;">
                                <option value="">-- 아티스트 선택 --</option>
                                <c:forEach items="${allArtists}" var="artist"><option value="${artist.artNo}"><c:out value="${artist.artNm}"/></option></c:forEach>
                            </select>
                            <button type="button" id="addMemberBtn" class="action-button" style="white-space: nowrap;">멤버 추가</button>
                        </div>
                        <input type="hidden" id="memberArtNosInput" name="memberArtNos" />
                    </fieldset>
                </div>
                <div class="form-group">
                    <fieldset>
                        <legend class="form-label" style="font-weight: bold; padding: 0; margin-bottom: 10px; border: 0; display: block; width: auto;">앨범:</legend>
                        <div id="selectedAlbumsContainer" class="albums-container" style="margin-bottom: 10px; min-height: 40px; border: 1px solid #ddd; padding: 8px; border-radius: 4px;"></div>
                        <div class="input-group-for-album-add" style="display: flex; gap: 8px; align-items: center; margin-bottom: 10px;">
                            <select id="albumSelect" class="form-control" style="flex-grow: 1;">
                                <option value="">-- 앨범 선택 --</option>
                                <c:forEach items="${albumsWithoutGroup}" var="album"><option value="${album.albumNo}"><c:out value="${album.albumNm}"/></option></c:forEach>
                            </select>
                            <button type="button" id="addAlbumBtn" class="action-button" style="white-space: nowrap;">앨범 추가</button>
                        </div>
                        <input type="hidden" id="selectedAlbumNosInput" name="selectedAlbumNos" />
                    </fieldset>
                </div>
                <div class="form-group">
                    <label for="modalGroupContent">소개글:</label>
                    <textarea id="modalGroupContent" name="artGroupContent" rows="4" class="form-control"></textarea>
                </div>

                <div class="form-group">
                    <label for="modalGroupProfileFileSelect">프로필 이미지 파일 선택:</label>
                    <input type="file" id="modalGroupProfileFileSelect" name="profileImage" accept="image/*" class="form-control-file">
                    <div>
                        <img id="groupPreviewImage" alt="선택된 그룹 이미지 미리보기" src="" style="max-width: 100%; max-height: 200px; display: none; margin-top:10px;">
                        <p id="noGroupImageSelectedText" style="color: #666; margin-top: 5px;">선택된 이미지가 없습니다.</p>
                    </div>
                </div>

                <div class="modal-actions ea-form-actions">
                    <button type="button" class="ea-btn primary" id="saveGroupChangesBtn"><i class="fas fa-save"></i> 저장</button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="../../modules/footerPart.jsp" %>

    <script>
        // 페이지 로드 시 사이드바 메뉴 관련 공통 스크립트 (artist-management.jsp와 동일)
        document.addEventListener('DOMContentLoaded', function() {
            const navItemsWithSubmenu = document.querySelectorAll('.emp-sidebar .emp-nav-item.has-submenu');
            navItemsWithSubmenu.forEach(item => {
                const arrow = item.querySelector('.submenu-arrow');
                item.addEventListener('click', function(event) {
                    if (this.getAttribute('href') === '#') { event.preventDefault(); }
                    const parentLi = this.parentElement;
                    const submenu = this.nextElementSibling;
                    if (submenu && submenu.classList.contains('emp-submenu')) {
                        const parentUl = parentLi.parentElement;
                        if (parentUl) {
                            Array.from(parentUl.children).forEach(siblingLi => {
                                if (siblingLi !== parentLi) {
                                    const siblingSubmenuControl = siblingLi.querySelector('.emp-nav-item.has-submenu.open');
                                    if (siblingSubmenuControl) {
                                        const siblingSubmenuElement = siblingSubmenuControl.nextElementSibling;
                                        siblingSubmenuControl.classList.remove('open');
                                        if (siblingSubmenuElement && siblingSubmenuElement.classList.contains('emp-submenu')) {
                                            siblingSubmenuElement.style.display = 'none';
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
            const currentFullHref = window.location.href;
            document.querySelectorAll('.emp-sidebar .emp-nav-item[href]').forEach(link => {
                if (link.href === currentFullHref) {
                    link.classList.add('active');
                    let currentActiveElement = link;
                    while (true) {
                        const parentLi = currentActiveElement.parentElement;
                        if (!parentLi) break;
                        const parentSubmenuUl = parentLi.closest('ul.emp-submenu');
                        if (parentSubmenuUl) {
                            parentSubmenuUl.style.display = 'block';
                            const controllingAnchor = parentSubmenuUl.previousElementSibling;
                            if (controllingAnchor && controllingAnchor.classList.contains('has-submenu')) {
                                controllingAnchor.classList.add('active', 'open');
                                const arrow = controllingAnchor.querySelector('.submenu-arrow');
                                if (arrow) arrow.style.transform = 'rotate(90deg)';
                                currentActiveElement = controllingAnchor;
                            } else break;
                        } else break;
                    }
                }
            });
        });

        // 그룹 수정 관련 JavaScript
        $(function() {
            const $editGroupModal = $('#editGroupModal');
            const $closeButton = $editGroupModal.find('.close-button');

            // 모달 필드 jQuery 객체
            const $modalGroupNo = $('#modalGroupNo');
            const $modalGroupName = $('#modalGroupName');
            const $modalDebutDate = $('#modalDebutDate');
            const $modalGroupContent = $('#modalGroupContent');
            const $modalGroupProfileFileSelect = $('#modalGroupProfileFileSelect'); // 파일 선택 input
            const $modalExistingGroupProfileImg = $('#modalExistingGroupProfileImg'); // hidden input (기존 경로)
            const $groupPreviewImage = $('#groupPreviewImage'); // 이미지 미리보기 태그
            const $noGroupImageSelectedText = $('#noGroupImageSelectedText'); // "이미지 없음" 텍스트

            // --- 멤버 및 앨범 관리 관련 변수 및 함수 (기존 로직 유지) ---
            const $selectedMembersContainer = $('#selectedMembersContainer');
            const $artistSelect = $('#artistSelect');
            const $addMemberBtn = $('#addMemberBtn');
            const $memberArtNosInput = $('#memberArtNosInput');
            let currentMemberArtNos = [];

            function renderMemberTag(artNo, artNm) {
                const artNoStr = String(artNo);
                if (currentMemberArtNos.includes(artNoStr)) { /* Swal.fire('이미 추가된 멤버입니다.', '', 'warning'); */ return; }
                const $tag = $('<span></span>').addClass('member-tag').text(artNm).data('artNo', artNoStr);
                const $removeBtn = $('<button></button>').addClass('remove-member-btn').html('&times;').attr('type', 'button');
                $removeBtn.on('click', function() {
                    $tag.remove();
                    currentMemberArtNos = currentMemberArtNos.filter(id => id !== artNoStr);
                    updateMemberArtNosInput();
                });
                $tag.append($removeBtn).appendTo($selectedMembersContainer);
                currentMemberArtNos.push(artNoStr);
                updateMemberArtNosInput();
            }
            function updateMemberArtNosInput() { $memberArtNosInput.val(currentMemberArtNos.join(',')); }
            $addMemberBtn.on('click', function() {
                const $selectedOption = $artistSelect.find('option:selected');
                if ($selectedOption.length && $selectedOption.val()) {
                    renderMemberTag($selectedOption.val(), $selectedOption.text());
                    $artistSelect.val("");
                } else { Swal.fire('아티스트를 선택해주세요.', '', 'warning'); }
            });

            const $selectedAlbumsContainer = $('#selectedAlbumsContainer');
            const $albumSelect = $('#albumSelect');
            const $addAlbumBtn = $('#addAlbumBtn');
            const $selectedAlbumNosInput = $('#selectedAlbumNosInput');
            let currentAlbumNos = [];

            function renderAlbumTag(albumNo, albumNm) {
                const albumNoStr = String(albumNo);
                if (currentAlbumNos.includes(albumNoStr)) { /* Swal.fire('이미 추가된 앨범입니다.', '', 'warning'); */ return; }
                const $tag = $('<span></span>').addClass('album-tag').text(albumNm).data('albumNo', albumNoStr);
                const $removeBtn = $('<button></button>').addClass('remove-album-btn').html('&times;').attr('type', 'button');
                $removeBtn.on('click', function() {
                    $tag.remove();
                    currentAlbumNos = currentAlbumNos.filter(id => id !== albumNoStr);
                    updateSelectedAlbumNosInput();
                });
                $tag.append($removeBtn).appendTo($selectedAlbumsContainer);
                currentAlbumNos.push(albumNoStr);
                updateSelectedAlbumNosInput();
            }
            function updateSelectedAlbumNosInput() { $selectedAlbumNosInput.val(currentAlbumNos.join(',')); }
            $addAlbumBtn.on('click', function() {
                const $selectedOption = $albumSelect.find('option:selected');
                if ($selectedOption.length && $selectedOption.val()) {
                    renderAlbumTag($selectedOption.val(), $selectedOption.text());
                    $albumSelect.val("");
                } else { Swal.fire('앨범을 선택해주세요.', '', 'warning'); }
            });

            // --- 모달 열고 닫기 ---
            function openGroupModal() { $editGroupModal.css('display', 'block'); }
            function closeGroupModal() {
                $editGroupModal.css('display', 'none');
                $groupPreviewImage.attr('src', '').hide();
            	$noGroupImageSelectedText.show();
                $modalGroupProfileFileSelect.val('');
            }
            $closeButton.on('click', closeGroupModal);
            $(window).on('click', function (event) {
                if ($(event.target).is($editGroupModal)) { closeGroupModal(); }
            });

            // --- "수정" 버튼 클릭: 모달에 그룹 데이터 채우기 ---
            $('.edit-group-btn').on('click', function () {
                const $this = $(this);
                $modalGroupNo.val($this.data('groupNo') || '');
                $modalGroupName.val($this.data('groupNm') || '');
                $modalDebutDate.val($this.data('groupDebutdate') || '');
                $modalGroupContent.val($this.data('groupContent') || '');

                const existingGroupImg = $this.data('group-profileimg');
                $modalExistingGroupProfileImg.val(existingGroupImg || ''); // hidden input에 기존 이미지 경로 설정

                // 이미지 미리보기 설정
                if (existingGroupImg && typeof existingGroupImg === 'string' && existingGroupImg.startsWith("/upload")) {
                    $groupPreviewImage.attr('src', '${pageContext.request.contextPath}' + existingGroupImg).show();
                    $noGroupImageSelectedText.hide();
                } else {
                    $groupPreviewImage.attr('src', '').hide();
                    $noGroupImageSelectedText.show();
                    if(existingGroupImg) { // 경로가 있지만 /upload로 시작하지 않는 경우 경고
                        console.warn("기존 그룹 프로필 이미지 경로가 예상과 다릅니다:", existingGroupImg);
                    }
                }
                $modalGroupProfileFileSelect.val(''); // 파일 선택 input 초기화

                const typeCode = $this.data('groupTypecode');
                $('input[name="artGroupTypeCode"]').prop('checked', false);
                if (typeCode === 'AGTC001') $('#artGroupTypeGroup').prop('checked', true);
                else if (typeCode === 'AGTC002') $('#artGroupTypeSolo').prop('checked', true);

                // 멤버 및 앨범 초기화 로직 (기존 유지)
                $selectedMembersContainer.empty(); currentMemberArtNos = [];
                const initialMembersJson = $this.data('groupInitialMembers');
                if (initialMembersJson) { try { let initialMembers = (typeof initialMembersJson === 'string') ? JSON.parse(initialMembersJson) : initialMembersJson; if (Array.isArray(initialMembers)) { initialMembers.forEach(member => { if(member && typeof member.artNo !== 'undefined' && typeof member.artNm !== 'undefined') { renderMemberTag(member.artNo, member.artNm); }}); } } catch (e) { console.error("멤버 JSON 파싱 오류:", e, initialMembersJson); }}
                updateMemberArtNosInput();

                $selectedAlbumsContainer.empty(); currentAlbumNos = [];
                const initialAlbumsJson = $this.data('groupInitialAlbums');
                if (initialAlbumsJson) { try { let initialAlbums = (typeof initialAlbumsJson === 'string') ? JSON.parse(initialAlbumsJson) : initialAlbumsJson; if (Array.isArray(initialAlbums)) { initialAlbums.forEach(album => { if(album && typeof album.albumNo !== 'undefined' && typeof album.albumNm !== 'undefined') { renderAlbumTag(album.albumNo, album.albumNm); }}); } } catch (e) { console.error("앨범 JSON 파싱 오류:", e, initialAlbumsJson); }}
                updateSelectedAlbumNosInput();

                openGroupModal();
            });

            // --- 파일 선택 시 이미지 미리보기 (아티스트 JSP와 동일하게) ---
            $modalGroupProfileFileSelect.on('change', function(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        $groupPreviewImage.attr('src', e.target.result).show();
                        $noGroupImageSelectedText.hide();
                    };
                    reader.readAsDataURL(file);
                } else {
                    // 파일 선택 취소 시, 기존 이미지로 미리보기 복원 (또는 초기화)
                    const existingImgPath = $modalExistingGroupProfileImg.val();
                    if (existingImgPath && typeof existingImgPath === 'string' && existingImgPath.startsWith("/upload")) {
                        $groupPreviewImage.attr('src', '${pageContext.request.contextPath}' + existingImgPath).show();
                        $noGroupImageSelectedText.hide();
                    } else {
                        $groupPreviewImage.attr('src', '').hide();
                        $noGroupImageSelectedText.show();
                    }
                }
            });

            // --- "저장" 버튼 클릭: AJAX로 데이터 전송 ---
            $('#saveGroupChangesBtn').on('click', function() {
                const formData = new FormData();

                // @ModelAttribute ArtistGroupVO groupVO 에 바인딩될 필드들
                formData.append('artGroupNo', $modalGroupNo.val());
                formData.append('artGroupNm', $modalGroupName.val());
                formData.append('artGroupDebutdate', $modalDebutDate.val());
                formData.append('artGroupTypeCode', $('input[name="artGroupTypeCode"]:checked').val());
                formData.append('artGroupContent', $modalGroupContent.val());
                formData.append('memberArtNos', $memberArtNosInput.val());
                formData.append('selectedAlbumNos', $selectedAlbumNosInput.val());

                // @RequestParam("existingGroupProfileImg") 으로 받을 값
                formData.append('existingGroupProfileImg', $modalExistingGroupProfileImg.val());

                // @ModelAttribute ArtistGroupVO groupVO 의 profileImage 필드에 바인딩될 파일
                const groupFile = $modalGroupProfileFileSelect[0].files[0];
                if (groupFile) {
                    formData.append('profileImage', groupFile); // "profileImage"는 ArtistGroupVO의 MultipartFile 필드명과 일치
                }

                $.ajax({
                    url: '${pageContext.request.contextPath}/emp/group/update', // 그룹 수정 AJAX URL
                    type: 'POST',
                    contentType: false,
                    processData: false,
                    data: formData,
                    beforeSend : function(xhr) {
                        var csrfHeader = "${_csrf.headerName}"; // CSRF 헤더 이름
                        var csrfToken = "${_csrf.token}";       // CSRF 토큰 값
                        if (csrfHeader && csrfToken) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        }
                    },
                    success: function(response) {
                        if(response && response.status === "success") {
                        	Swal.fire('성공!', response.message || '그룹 정보가 성공적으로 저장되었습니다.', 'success')
                        		.then(() => {
		                            location.reload();
                        		});
                        } else {
                        	Swal.fire('오류', response.message || '그룹 정보 저장 중 문제가 발생했습니다.', 'error');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("그룹 정보 저장 실패:", xhr.status, error, xhr.responseText);
                        let errorMsg = '그룹 정보 저장에 실패했습니다.';
                        try {
                            const errResponse = JSON.parse(xhr.responseText);
                            if (errResponse && errResponse.message) {
                                errorMsg = errResponse.message;
                            } else if (xhr.responseText) {
                                 errorMsg += '\n서버 응답 일부: ' + xhr.responseText.substring(0,200);
                            }
                        } catch(e) {
                            if (xhr.responseText) {
                                 errorMsg += '\n서버 응답 일부: ' + xhr.responseText.substring(0,200);
                            }
                        }
                        Swal.fire('요청 실패', errorMsg, 'error');
                    }
                });
            });
        });
    </script>
</body>
</html>