<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 수정 - DDTOWN 관리자 시스템</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pages/admin_items.css">
    <%@ include file="../../../modules/headerPart.jsp" %>
</head>
<body>
	<div class="emp-container">
		<%@ include file="../../modules/header.jsp"%>

		<div class="emp-body-wrapper">
			<%@ include file="../../modules/aside.jsp"%>

			<main class="emp-content">
				<section id="goodsItemFormSection" class="ea-section active-section">
					<div class="ea-section-header">
						<h2>상품 수정</h2>
						<div class="ea-header-actions">
							<c:if test="${not empty successMessage}">
								<div class="alert alert-success">${successMessage}</div>
							</c:if>
							<c:if test="${not empty errorMessage}">
								<div class="alert alert-danger">${errorMessage}</div>
							</c:if>
						</div>
					</div>
					<form method="POST"
						action="${pageContext.request.contextPath}/admin/goods/items/update"
						enctype="multipart/form-data">
						<input type="hidden" name="goodsNo" value="${item.goodsNo }">

						<div class="form-row">
							<div class="form-group">
								<label for="goodsNm">상품명 <span class="required">*</span></label>
								<input type="text" id="goodsNm" name="goodsNm" required value="<c:out value='${item.goodsNm}'/>">
							</div>
							<div class="form-group">
								<label for="goodsCode">상품코드<span class="required"></span></label>
								<input type="text" id="goodsCode" name="goodsCode" readonly placeholder="자동 생성" value="<c:out value='${item.goodsCode}'/>">
							</div>

							<!-- 아티스트 그룹 -->
							<div class="form-group">
								<label for="artGroupNo">아티스트 그룹 <span class="required">*</span></label>
								<select id="artGroupNo" name="artGroupNo" required>
									<option value="">아티스트를 선택하세요</option>
									<c:forEach var="artist" items="${artistList}">
										<!-- *** 기존 선택된 아티스트 표시 로직 ***** -->
										<option value="${artist.artGroupNo}"
											${item.artGroupNo == artist.artGroupNo ? 'selected' : ''}>
											<c:out value="${artist.artGroupNm}" />
										</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<!-- <div class="form-row"> 끝 -->

						<!-- 옵션 선택 -->
						<div class="form-row">
							<div class="form-group">
								<label for="useOptionsCheckbox">옵션 사용</label> <input
									type="checkbox" id="useOptionsCheckbox" name="useOptions"
									value="true" ${item.goodsMultiOptYn == 'Y' ? 'checked' : ''}>
							</div>
						</div>

						<div class="form-row" id="mainStockSection">
							<div class="form-group">
								<label for="stockRemainQty">재고수량<span class="required">*</span></label>
								<input type="number" id="stockRemainQty" name="stockRemainQty"
									min="0" value="<c:out value='${item.stockRemainQty}'/>">
							</div>
						</div>
						<div id="optionsInputSection">
							<div class="d-flex justify-contents-center"
								style="align-items: center; gap: 30px;">
								<label>상품 옵션</label>
								<button type="button" id="addOptionBtn"
									class="ea-btn sm outline">옵션 추가</button>
							</div>
							<div id="goodsOptionsContainer">

								<c:forEach var="option" items="${item.options}" varStatus="loop">
									<div class="option-set existing-option-set">
										<input type="hidden" name="options[${loop.index }].goodsOptNo"
											value="${option.goodsOptNo }"> <input type="text"
											name="options[${loop.index }].goodsOptNm"
											value="<c:out value='${option.goodsOptNm }'/>"
											placeholder="옵션명">
										<!-- 현재 재고!!!!! -->
										<input type="number" name="options[${loop.index }].initialStockQty" value="<c:out value='${not empty option.goodsStock ? option.goodsStock.stockRemainQty : 0}'/>"placeholder="초기 재고 수량">
										<input type="number" name="options[${loop.index }].goodsOptPrice" value="<c:out value='${option.goodsOptPrice }'/>" placeholder="옵션 추가 가격">
										<input type="text" name="options[${loop.index }].goodsOptEtc" value="<c:out value='${option.goodsOptEtc }'/>" placeholder="옵션 설명">
										<!-- 기존 옵션 삭제 버튼: data-optno에 goodsOptNo에 전달 -->
										<button type="button" class="remove-existing-option-btn" data-optno="${option.goodsOptNo }">기존 옵션 삭제</button>
									</div>
								</c:forEach>
							</div>
							<button type="button" id="addOptionBtn">새 옵션 추가</button>
							<!-- 삭제할 기존 옵션 ID(goodsOptNo)들을 담을 hidden input! -->
							<input type="hidden" name="deleteOptionNos"
								id="deleteOptionNosInput" value="">
						</div>
						<!-- <div id="optionsInputSection"> 끝 -->

						<!-- 판매 가격 -->
						<div class="form-row">
							<div class="form-group">
								<label for="goodsPrice">판매가격 <span class="required">*</span></label>
								<input type="number" id="goodsPrice" name="goodsPrice" min="0"
									step="1" required value="<c:out value='${item.goodsPrice}'/>">
							</div>
						</div>
						<!-- 판매 상태 -->
						<div class="form-group">
							<label for="itemStatus">판매상태 <span class="required">*</span></label>
							<select id="itemStatus" name="statusEngKey" required>
								<%-- name도 statusEngKey로 변경하는 것을 고려 --%>
								<option value="IN_STOCK"
									<c:if test="${item.statusEngKey == 'IN_STOCK' or empty item.statusEngKey}">selected</c:if>>판매중</option>
								<option value="SOLD_OUT"
									<c:if test="${item.statusEngKey == 'SOLD_OUT'}">selected</c:if>>품절</option>
							</select>
						</div>

						<!-- 상품 설명 -->
						<div class="form-group">
							<label for="goodsContent">상품설명 <span class="required">*</span></label>
							<textarea id="goodsContent" name="goodsContent" required><c:out
									value='${item.goodsContent}' /></textarea>
						</div>

						<%-- 상품 이미지 --%>
						<div class="form-group">
							<label for="goodsFiles">상품 이미지 <span class="required">*</span></label>

							<div id="existingImagesContainer" style="margin-bottom: 15px; border: 1px solid #eee; padding: 10px;">
								<h4>기존 이미지</h4>
								<%-- 대표 이미지도 없고, 추가적인 첨부파일 목록도 없을 때 "등록된 이미지 없음" 표시 --%>
								<%-- GoodsVO의 필드명 representativeImageFile 로 수정 --%>
								<c:if
									test="${empty item.representativeImageFile && empty item.attachmentFileList}">
									<p>등록된 이미지가 없습니다!!</p>
								</c:if>

								<%-- 1. 대표 이미지 표시 및 삭제 버튼 --%>
								<%--    item.representativeImageFile 객체가 존재하고, 그 안에 webPath가 있을 때 표시 --%>
								<c:if test="${not empty item.representativeImageFile && not empty item.representativeImageFile.webPath}">
									<div class="image-preview existing-image"
										id="repImageDiv_${item.representativeImageFile.attachDetailNo}">
										<%-- ★ item.representativeImageFile 사용 ★ --%>
										<img src="${item.representativeImageFile.webPath}" alt="<c:out value='${item.representativeImageFile.fileOriginalNm}'/> (대표)"
											style="max-width: 120px; max-height: 120px; border: 2px solid blue; margin: 5px;">
										<button type="button" class="remove-existing-image-btn"
											data-attachno="${item.representativeImageFile.attachDetailNo}"
											title="대표 이미지 삭제">&times;</button>
										<%-- ★ item.representativeImageFile 사용 ★ --%>
									</div>
								</c:if>

								<%-- 2. "추가" 이미지 목록 표시 및 삭제 버튼 --%>
								<%--    attachmentFileList를 반복하되, 이미 위에서 대표 이미지로 표시된 것은 제외 --%>
								<div class="additional-images-display"
									style="display: flex; flex-wrap: wrap;">
									<c:if test="${not empty item.attachmentFileList}">
										<c:forEach var="imageFile" items="${item.attachmentFileList}">
											<%-- 현재 imageFile이 대표 이미지(item.representativeImageFile)와 동일한 파일이 아닐 경우에만 표시 --%>
											<c:if
												test="${empty item.representativeImageFile || item.representativeImageFile.attachDetailNo != imageFile.attachDetailNo}">
												<div class="image-preview existing-image"
													id="existingImgDiv_${imageFile.attachDetailNo}">
													<img src="${imageFile.webPath}"
														alt="<c:out value="${imageFile.fileOriginalNm}"/>"
														style="max-width: 100px; max-height: 100px; margin: 5px; border: 1px solid #ddd;">
													<button type="button" class="remove-existing-image-btn"
														data-attachno="${imageFile.attachDetailNo}" title="이미지 삭제">&times;</button>
												</div>
											</c:if>
										</c:forEach>
									</c:if>
								</div>
							</div>

							<%-- 삭제할 기존 이미지의 attachDetailNo들을 담을 hidden input --%>
							<input type="hidden" name="deleteAttachDetailNos"
								id="deleteAttachDetailNosInput" value="">

							<%-- 새 이미지 추가 영역 --%>
							<div class="image-upload-area" id="newImageUploadArea">
								<p>새 이미지 추가 (기존 이미지를 변경하거나 새 이미지를 추가할 수 있습니다)</p>
								<input type="file" id="goodsFiles" name="goodsFiles" multiple
									accept="image/*" style="display: none;">
								<button type="button" class="ea-btn"
									onclick="document.getElementById('goodsFiles').click()">
									<i class="fas fa-upload"></i> 새 이미지 선택
								</button>
							</div>

							<%-- 새로 추가하는 이미지 미리보기 컨테이너 --%>
							<div class="image-preview-container"
								id="newImagePreviewContainer"
								style="display: flex; flex-wrap: wrap; margin-top: 10px;">
								<%-- 여기에 JavaScript로 새 이미지 미리보기가 추가됩니다. --%>
							</div>
						</div>
						<!-- 취소 / 등록 버튼 -->
						<div class="form-actions">
							<a href="${pageContext.request.contextPath}/admin/goods/items/list"
								class="ea-btn">취소</a>
							<button type="submit" id="goodsRegisterSubmitBtn"
								class="ea-btn primary">
								<i class="fas fa-save"></i> 수정
							</button>
						</div>
						<sec:csrfInput />
					</form>
			</section>
		</main>
	</div>
</div>
</body>
<%@ include file="../../../modules/footerPart.jsp" %>

<%@ include file="../../../modules/sidebar.jsp" %>
<script>
  document.addEventListener('DOMContentLoaded', function() {

   	// ======================== 폼 및 버튼 요소 선택 ========================
      const itemForm = document.querySelector('form[action$="/items/update"]'); // ★★★ 수정 처리 action URL ★★★
      const submitButton = itemForm ? itemForm.querySelector('button[type="submit"]') : null; // 수정 버튼

   	// --- 옵션 관련 요소 ---
      const useOptionsCheckbox = document.getElementById('useOptionsCheckbox');
      const mainStockSection = document.getElementById('mainStockSection');
      const stockRemainQtyInput = document.getElementById('stockRemainQty');
      const optionsInputSection = document.getElementById('optionsInputSection'); // 옵션 컨테이너와 추가 버튼을 감싸는 div
      const addOptionButton = document.getElementById('addOptionBtn');
      const optionsContainer = document.getElementById('goodsOptionsContainer'); // 옵션 세트들이 들어갈 곳
      const deleteOptionNosInput = document.getElementById('deleteOptionNosInput'); // 삭제할 기존 옵션 ID 저장용
      let optionIndex = optionsContainer.getElementsByClassName('option-set').length; // 새 옵션 인덱스용
      let optionNosToDelete = deleteOptionNosInput.value ? deleteOptionNosInput.value.split(',').filter(id => id.trim() !== '').map(Number) : [];

   	// --- 이미지 관련 요소 ---
      const goodsFilesInput = document.getElementById('goodsFiles'); // 새 이미지 파일 입력
      const newImagePreviewContainer = document.getElementById('newImagePreviewContainer'); // 새 이미지 미리보기 컨테이너
      const existingImagesContainer = document.getElementById('existingImagesContainer'); // 기존 이미지 표시 컨테이너
      const deleteAttachDetailNosInput = document.getElementById('deleteAttachDetailNosInput'); // 삭제할 기존 이미지 ID 저장용
      let currentNewFilesDataTransfer = new DataTransfer(); // 새로 추가되는 파일 관리
      let attachNosToDelete = deleteAttachDetailNosInput.value ? deleteAttachDetailNosInput.value.split(',').filter(id => id.trim() !== '').map(Number) : [];

  	//------------------------1. 중복 제출 방어--------------------------------------
  	// JavaScript 최상단 또는 DOMContentLoaded 내부의 적절한 위치
if (itemForm && submitButton) {
          itemForm.addEventListener('submit', function(event) {
              if (submitButton.dataset.submitted === 'true') {
                  console.warn('폼 중복 제출 시도 감지됨 (JS).');
                  event.preventDefault();
                  return false;
              }
              submitButton.dataset.submitted = 'true';
              submitButton.disabled = true;
              submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 처리 중...';
          });
      }

// ======================== 2. "옵션 사용" 체크박스 로직 ========================
      function toggleSectionsBasedOnOptions() {
          const isChecked = useOptionsCheckbox ? useOptionsCheckbox.checked : true; // 체크박스가 없으면 기본적으로 옵션 사용으로 간주 (또는 false)
                                                                                  // 페이지 로드 시 item.goodsMultiOptYn에 의해 checked 상태가 결정됨

          if (isChecked) { // 옵션 사용 시
              if (mainStockSection) mainStockSection.style.display = 'none';
              if (stockRemainQtyInput) {
                  stockRemainQtyInput.disabled = true;
                  stockRemainQtyInput.required = false;
              }
              if (optionsInputSection) optionsInputSection.style.display = 'block';
              if (optionsInputSection) optionsInputSection.querySelectorAll('input, button').forEach(el => el.disabled = false);

              // 수정 폼에서는 이미 존재하는 첫 번째 옵션이 있을 수 있으므로, 무조건 required 설정보다는
              // 옵션이 하나도 없을 때만 첫 번째 새로 추가되는 옵션에 required를 거는 등의 로직이 필요할 수 있음
              // const firstOptNm = optionsInputSection.querySelector('input[name="options[0].goodsOptNm"]');
              // if(firstOptNm && optionsContainer.getElementsByClassName('option-set').length === 0) firstOptNm.required = true;

          } else { // 옵션 미사용 시
              if (mainStockSection) mainStockSection.style.display = ''; // 기본 display로 (보통 block 또는 flex)
              if (stockRemainQtyInput) {
                  stockRemainQtyInput.disabled = false;
                  stockRemainQtyInput.required = true;
              }
              if (optionsInputSection) optionsInputSection.style.display = 'none';
              if (optionsInputSection) optionsInputSection.querySelectorAll('input, button').forEach(el => el.disabled = true);
          }
      }

      if (useOptionsCheckbox) {
          useOptionsCheckbox.addEventListener('change', toggleSectionsBasedOnOptions);
          toggleSectionsBasedOnOptions(); // 페이지 로드 시 초기 상태에 맞게 UI 설정
      }

   	// 3a. 새 옵션 추가
      if (addOptionButton && optionsContainer) { // optionsContainer null 체크 추가
          addOptionButton.addEventListener('click', function() {
              const newOptionSetDiv = document.createElement('div');
              newOptionSetDiv.classList.add('option-set', 'newly-added-option-set');

              // ★★★ JavaScript 문자열 연결 방식으로 변경 ★★★
              newOptionSetDiv.innerHTML =
                  '<input type="hidden" name="options[' + optionIndex + '].goodsOptNo" value="0">' +
                  '<input type="text" name="options[' + optionIndex + '].goodsOptNm" placeholder="옵션명 (예: 레드/S)" required>' +
                  '<input type="number" name="options[' + optionIndex + '].initialStockQty" placeholder="초기 재고 수량" min="0" value="0">' +
                  '<input type="number" name="options[' + optionIndex + '].goodsOptPrice" placeholder="옵션 추가 가격" min="0" value="0">' +
                  '<input type="text" name="options[' + optionIndex + '].goodsOptEtc" placeholder="옵션 설명 (비고)">' +
                  // 새 옵션이므로 goodsOptFixYn은 GoodsOptionVO의 기본값("N")을 사용하거나,
                  // 필요하다면 여기서 hidden으로 "N"을 전달할 수 있습니다.
                  '<input type="hidden" name="options[' + optionIndex + '].goodsOptFixYn" value="N">' +
                  '<button type="button" class="remove-new-option-btn">삭제</button>';

              optionsContainer.appendChild(newOptionSetDiv);
              optionIndex++; // 다음 새 옵션의 인덱스
          });
      }

      // 3b. 옵션 컨테이너 내 클릭 이벤트 (새 옵션 삭제 / 기존 옵션 삭제 토글)
      if (optionsContainer) {
          optionsContainer.addEventListener('click', function(event) {
              // 새로 추가된 옵션 행 삭제 (DOM에서 완전히 제거)
              if (event.target.classList.contains('remove-new-option-btn')) {
                  event.target.closest('.option-set').remove();
                  // 필요시 optionIndex 재조정 로직 (하지만 보통은 불필요)
              }
              // 기존 옵션 삭제/복구 토글
              else if (event.target.classList.contains('remove-existing-option-btn')) {
                  const button = event.target;
                  const optNoStr = button.dataset.optno;
                  const optionSetDiv = button.closest('.option-set.existing-option-set');

                  if (optNoStr) {
                      const optNo = parseInt(optNoStr, 10);
                      const indexInDeleteList = optionNosToDelete.indexOf(optNo);

                      if (indexInDeleteList === -1) { // 삭제 목록에 없으면 -> 삭제 대상으로 표시
                          optionNosToDelete.push(optNo);
                          if (optionSetDiv) optionSetDiv.style.textDecoration = 'line-through';
                          button.textContent = '삭제 취소';
                          button.title = '삭제 취소';
                      } else { // 이미 삭제 목록에 있으면 -> 복구
                          optionNosToDelete.splice(indexInDeleteList, 1);
                          if (optionSetDiv) optionSetDiv.style.textDecoration = 'none';
                          button.textContent = '기존 옵션 삭제';
                          button.title = '기존 옵션 삭제';
                      }
                      if (deleteOptionNosInput) deleteOptionNosInput.value = optionNosToDelete.join(',');
//                       console.log("삭제할 옵션 ID 목록:", deleteOptionNosInput ? deleteOptionNosInput.value : "N/A");
                  }
              }
          });
      }

   // ======================== 4. 이미지 관리 로직 ========================
      // 4a. 새 이미지 추가, 미리보기, 삭제 (등록폼 로직과 유사)
      if (goodsFilesInput && newImagePreviewContainer) {
          goodsFilesInput.addEventListener('change', function(event) {
              const newFiles = event.target.files;
              Array.from(newFiles).forEach(file => {
                  if (file.type.startsWith('image/')) {
                      let exists = false;
                      for (let i = 0; i < currentNewFilesDataTransfer.files.length; i++) {
                          if (currentNewFilesDataTransfer.files[i].name === file.name && currentNewFilesDataTransfer.files[i].size === file.size) {
                              exists = true; break;
                          }
                      }
                      if (!exists) {
                          currentNewFilesDataTransfer.items.add(file);
                          displayNewImagePreview(file);
                      }
                  } else { alert('이미지 파일만 업로드할 수 있습니다!'); }
              });
              goodsFilesInput.files = currentNewFilesDataTransfer.files;
//               logClientFileList(goodsFilesInput.files, "새 파일 선택 후 goodsFilesInput.files");
              /* event.target.value = ''; */
          });

          newImagePreviewContainer.addEventListener('click', function(event) {
              if (event.target.classList.contains('remove-new-image-btn')) { // 새 이미지 제거 버튼 클래스 확인
                  const previewElement = event.target.parentElement;
                  const fileNameToRemove = previewElement.dataset.fileName;
                  const newTempDT = new DataTransfer();
                  for (let i = 0; i < currentNewFilesDataTransfer.files.length; i++) {
                      if (currentNewFilesDataTransfer.files[i].name !== fileNameToRemove) {
                          newTempDT.items.add(currentNewFilesDataTransfer.files[i]);
                      }
                  }
                  currentNewFilesDataTransfer = newTempDT;
                  goodsFilesInput.files = currentNewFilesDataTransfer.files;
                  previewElement.remove();
//                   logClientFileList(goodsFilesInput.files, "새 파일 제거 후 goodsFilesInput.files");
              }
          });
      }

      function displayNewImagePreview(file) { // 새 이미지용 미리보기
          const reader = new FileReader();
          reader.onload = function(e) {
              const dataURL = e.target.result;
              if (!dataURL || !dataURL.startsWith("data:image")) {
                  console.error("유효하지 않은 Data URL:", dataURL ? dataURL.substring(0,50) : "null");
                  alert("이미지 데이터를 올바르게 읽어오지 못했습니다: " + file.name);
                  return;
              }
              const previewDiv = document.createElement('div');
              previewDiv.classList.add('image-preview', 'newly-added-image');
              previewDiv.dataset.fileName = file.name;
           	// ★★★ JavaScript 문자열 연결 방식으로 변경 ★★★
              previewDiv.innerHTML =
                  '<img src="' + dataURL + '" alt="' + file.name + '" style="max-width: 100px; max-height: 100px; margin: 5px; border: 1px solid #ddd;">' +
                  '<button type="button" class="remove-new-image-btn" title="이 새 이미지 제거">&times;</button>';
              if (newImagePreviewContainer) newImagePreviewContainer.appendChild(previewDiv);
          };
          reader.onerror = function(e) { console.error("FileReader 오류:", e); alert("파일 읽기 오류: " + file.name); };
          reader.readAsDataURL(file);
      }

   	// FileList 상태 로깅 헬퍼 함수 (등록폼과 동일)
      function logClientFileList(fileList, contextMessage) {
          console.log(`--- ${contextMessage} ---`);
          if (!fileList) { console.log("FileList is null or undefined."); return; }
          console.log(`FileList length: ${fileList.length}`);
          for (let i = 0; i < fileList.length; i++) {
              const f = fileList[i];
              if (f) { console.log(`File ${i}: name="${f.name}", size=${f.size}, type="${f.type}"`); }
              else { console.log(`File ${i}: is null or undefined.`); }
          }
          console.log(`-----------------------------`);
      }


      // 4b. 기존 이미지 삭제 토글
      if (existingImagesContainer && deleteAttachDetailNosInput) {
          existingImagesContainer.addEventListener('click', function(event) {
              if (event.target.classList.contains('remove-existing-image-btn')) {
                  const button = event.target;
                  const attachNoStr = button.dataset.attachno;
                  const imagePreviewDiv = button.closest('.image-preview.existing-image');

                  if (attachNoStr) {
                      const attachNo = parseInt(attachNoStr, 10);
                      const indexInDeleteList = attachNosToDelete.indexOf(attachNo);

                      if (indexInDeleteList === -1) { // 삭제 목록에 없으면 추가
                          attachNosToDelete.push(attachNo);
                          if (imagePreviewDiv) imagePreviewDiv.style.opacity = '0.4'; // 삭제됨을 시각적으로 표시
                          button.innerHTML = '복구'; // 버튼 아이콘이나 텍스트 변경
                          button.title = '삭제 취소';
                          // 실제 폼에서는 이 input이 값을 가지게 됨
                          // <input type="checkbox" name="deleteActualAttachDetailNos" value="${attachNo}" style="display:none" checked> 와 같은 효과
                      } else { // 이미 삭제 목록에 있으면 제거 (복구)
                          attachNosToDelete.splice(indexInDeleteList, 1);
                          if (imagePreviewDiv) imagePreviewDiv.style.opacity = '1';
                          button.innerHTML = '&times;';
                          button.title = imagePreviewDiv.id.startsWith('repImageDiv_') ? '대표 이미지 삭제' : '이미지 삭제';
                      }
                      deleteAttachDetailNosInput.value = attachNosToDelete.join(',');
//                       console.log("삭제할 기존 이미지 attachDetailNo 목록:", deleteAttachDetailNosInput.value);
                  }
              }
          });
      }
  });
  </script>
</html>