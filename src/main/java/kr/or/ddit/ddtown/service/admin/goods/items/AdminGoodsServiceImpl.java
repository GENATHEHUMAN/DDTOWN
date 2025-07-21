package kr.or.ddit.ddtown.service.admin.goods.items;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.goods.IGoodsMapper;
import kr.or.ddit.ddtown.mapper.goods.IGoodsSearchMapper;
import kr.or.ddit.ddtown.mapper.goods.IWishlistMapper;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.goods.goodsOptionVO;
import kr.or.ddit.vo.goods.goodsStockVO;
import kr.or.ddit.vo.goods.goodsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminGoodsServiceImpl implements IAdminGoodsService {
	
	@Autowired
	private IFileService fileService;
	
	@Autowired
	private IGoodsMapper goodsMapper;
	
	@Autowired
	private IWishlistMapper wishlistMapper;
	
	@Autowired
	private IGoodsSearchMapper goodsSearchMapper;
	
    private static final String FILETYPECODE = "FITC004";

	
	@Transactional
	@Override
	public ServiceResult itemsRegister(goodsVO goodsVO) throws Exception {
		// Service
		log.warn("<<<<< SERVICE itemsRegister 진입! Thread: {}, GoodsNm: {} >>>>>", Thread.currentThread().getName(), goodsVO.getGoodsNm());
		log.info("itemsRegister() 실행 시작..!");
		
		int newGoodsNo = goodsMapper.selectNextGoodsNo();
		goodsVO.setGoodsNo(newGoodsNo); 
		log.info("새로운 goodsNo 채번: {}", newGoodsNo);
		
		
		String artGroupNoForCode = ""; 
		
		if(goodsVO.getArtGroupNo() > 0) { 
			artGroupNoForCode = String.valueOf(goodsVO.getArtGroupNo());
			
		} else {
			log.info("유효한 artGroupNo가 전달되지 않았습니다. 상품 코드 생성 규칙 확인 필요 artGroupNo:{}", goodsVO.getArtGroupNo());
			
			throw new IllegalArgumentException("아티스트 그룹은 반드시 선택돼야 합니다.");
		}
		
		String goodsNoForCode = String.valueOf(newGoodsNo);
		String generatedGoodsCode = "G" + artGroupNoForCode + "P" + goodsNoForCode;
		goodsVO.setGoodsCode(generatedGoodsCode);
		log.info("생성된 goodsCode(G + 그룹 번호 + P + 상품 번호 형식): {}", generatedGoodsCode);
		
		String statusEngKeyFromForm = goodsVO.getStatusEngKey();
		String dbGoodsStatCode = null; 
		if("IN_STOCK".equalsIgnoreCase(statusEngKeyFromForm)) {
			dbGoodsStatCode = "GSC001"; 
		} else if ("SOLD_OUT".equalsIgnoreCase(statusEngKeyFromForm)){
			dbGoodsStatCode = "GSC002"; 
		}
		
		goodsVO.setGoodsStatCode(dbGoodsStatCode);
		log.info("설정된 goodsStatCode: {}", goodsVO.getGoodsStatCode());
		
		log.info("파일 처리 시작. goodsVO.getGoodsFiles() is null: {}", (goodsVO.getFileGroupNo() == null));
		if(goodsVO.getGoodsFiles() != null) { 
			log.info("goodsVO.getGoodsFiles().length:{}", goodsVO.getGoodsFiles().length);
			
			if(goodsVO.getGoodsFiles().length > 0) {
				log.info("첫번째 파일 isEmpty(): {}, OriginFilename:{}", goodsVO.getGoodsFiles()[0].isEmpty(),
						goodsVO.getGoodsFiles()[0].getOriginalFilename());
			}	
		}
		
		if (goodsVO.getGoodsFiles() != null && goodsVO.getGoodsFiles().length > 0 && !goodsVO.getGoodsFiles()[0].isEmpty()) {
			log.info("fileService.uploadAndProcessFiles 호출. FILECODE: {}", FILETYPECODE); //FILETYPECODE 값 확인
			Integer fileGroupResult = fileService.uploadAndProcessFiles(goodsVO.getGoodsFiles(), FILETYPECODE);
			log.info("fileService.uploadAndProcessFiles 반환 값 (fileGroupResult): {}", fileGroupResult); //파일 들어갔는지 확인 결과
			goodsVO.setFileGroupNo(fileGroupResult);
		} else {
			log.info("업로드할 파일이 없거나 비어있어 fileGroupNo를 null로 설정합니다!!");
			goodsVO.setFileGroupNo(null);
		}
		log.info("설정된 fileGroupNo: {}", goodsVO.getFileGroupNo());
		
		
		List<goodsOptionVO> options = goodsVO.getOptions();
		
		if (options != null && !options.isEmpty()) {
			goodsVO.setGoodsMultiOptYn("Y"); // 옵션이 있으면 'Y'
			log.info("옵션이 존재하므로 goodsMultiOptYn을 'Y'로 설정");
		} else {
			goodsVO.setGoodsMultiOptYn("N"); // 옵션이 없으면 'N'
			log.info("옵션이 없으므로 goodsMultiOptYn을 'N'으로 설정");
		}
		log.info("DB INSERT 직전 goodsMultiOptYn: {}", goodsVO.getGoodsMultiOptYn());
		
		
		int goodsInsertRowCount = goodsMapper.itemsRegister(goodsVO);
		
		if(goodsInsertRowCount <= 0) {
			log.warn("상품 기본 정보 DB 등록 실패: {}", goodsVO.getGoodsNm());
			return ServiceResult.FAILED; //상품 정보 등록 실패 시 종료
		}
		log.info("상품 기본 정보 DB 등록 성공: goodsNo={}, goodsNm={}", goodsVO.getGoodsNo(), goodsVO.getGoodsNm());
		
		
		if(options != null && !options.isEmpty()) {
				log.info("옵션 사용됨. 옵션 개수: {}", options.size());
				
				int currentOptionSequence = 0; 
				
				for(goodsOptionVO option : options) {
					option.setGoodsNo(goodsVO.getGoodsNo());
					
			        String etcFromForm = option.getGoodsOptEtc(); 
			        if (etcFromForm == null || etcFromForm.trim().isEmpty()) {
			            option.setGoodsOptEtc(" "); 
			            log.info("옵션 '{}'의 goodsOptEtc가 비어있어 기본값(' ')으로 설정합니다.", option.getGoodsOptNm());
			        }
			        option.setGoodsOptSec(++currentOptionSequence);
					option.setGoodsOptPrice(goodsVO.getGoodsPrice());
					int optionInsertCount = goodsMapper.insertGoodsOption(option);
					
					if(optionInsertCount <= 0) {
						log.info("상품 옵션 정보 등록 실패! 옵션명: {}", option.getGoodsOptNm());
						throw new RuntimeException("상품 옵션 정보 등록에 실패했습니다! 옵션명:{}"+option.getGoodsOptNm());
					} 
					
					log.info("상품 옵션 정보 DB 등록 성공! goodsOptNo: {}", option.getGoodsOptNo());
					
					if (option.getInitialStockQty() != null && option.getInitialStockQty() >= 0) {
						goodsStockVO stock = new goodsStockVO();
						stock.setStockTypeCode("STC001"); 
						stock.setGoodsNo(option.getGoodsNo());
						stock.setGoodsOptNo(option.getGoodsOptNo()); 
						stock.setStockRemainQty(option.getInitialStockQty());
						stock.setStockNewQty(option.getInitialStockQty()); 
						stock.setStockSafeQty(0); 
						stock.setStockUnitCost(0); 
						
						int stockInsertCount = goodsMapper.insertGoodsStock(stock);
						
						if(stockInsertCount <= 0) {
							log.error("옵션 재고 정보 등록 실패! 옵션명: {}", option.getGoodsOptNm());
							throw new RuntimeException("옵션 재고 정보 등록에 실패! 옵션명: {}" + option.getGoodsOptNm());
						}
						
						log.info("옵션 재고 정보 DB 등록 성공! goodsOptNo: {}, 재고: {}	", option.getGoodsOptNo(), option.getInitialStockQty());
					} else {
						log.warn("옵션 '{}'에 대한 초기 재고 수량이 없거나 유효하지 않아 등록을 못합니다!", option.getGoodsOptNm());
					}
				}
				
		} else { 
			log.info("등록된 상품에 옵션이 없습니다! goodsNo: {}", goodsVO.getGoodsNo());
			
			if(goodsVO.getStockRemainQty() != null && goodsVO.getStockRemainQty() >= 0) {
				goodsOptionVO defaultOption = new goodsOptionVO();
				defaultOption.setGoodsNo(goodsVO.getGoodsNo());
				defaultOption.setGoodsOptNm(goodsVO.getGoodsNm());
				defaultOption.setGoodsOptPrice(goodsVO.getGoodsPrice());
				defaultOption.setGoodsOptFixYn("N");
				defaultOption.setGoodsOptEtc("-");
				defaultOption.setGoodsOptSec(0);
				
				int defaultOptionInsertCount = goodsMapper.insertGoodsOption(defaultOption); 
				
				if(defaultOptionInsertCount <= 0 || defaultOption.getGoodsOptNo() <= 0) {
					log.error("기본 상품 옵션 생성 실패!! goodsNo: {}", goodsVO.getGoodsNo());
					throw new RuntimeException("기본 상품 옵션 정보 등록에 실패했습니다!!");
				}
				log.info("기본 상품 옵션 DB 등록 성공! new goodsOptNo: {}", defaultOption.getGoodsOptNo());
				
				goodsStockVO stockDataForBaseProduct = new goodsStockVO();
				stockDataForBaseProduct.setGoodsNo(goodsVO.getGoodsNo());
				stockDataForBaseProduct.setGoodsOptNo(defaultOption.getGoodsOptNo()); 
				stockDataForBaseProduct.setStockRemainQty(goodsVO.getStockRemainQty()); 
				stockDataForBaseProduct.setStockNewQty(goodsVO.getStockRemainQty()); 
				
				stockDataForBaseProduct.setStockTypeCode("STC001");
				stockDataForBaseProduct.setStockSafeQty(0); 
				stockDataForBaseProduct.setStockUnitCost(0); 
				
				log.info("기본 상품 재고 등록 시도! goodsStockVo: {}", stockDataForBaseProduct);
				int stockInsertCount = goodsMapper.insertGoodsStock(stockDataForBaseProduct); 
				
				if(stockInsertCount <= 0) {
					log.error("기본 상품 재고 정보 등록 실패! goodsNo: {}", goodsVO.getGoodsNo());
					throw new RuntimeException("기본 상품 재고 정보 등록 실패!");
				}
				
				log.info("기본 상품 재고 정보 DB 등록 성공! goodsNo:{}, 재고: {}", goodsVO.getGoodsNo(), goodsVO.getStockRemainQty());
			} else {
				log.warn("옵션 미사용 상태, 재고도 입력되지 않았음! goodsNo:{}", goodsVO.getGoodsNo());
			}
		}
        this.synchronizeGoodsStatusWithStock(goodsVO.getGoodsNo());
		
		return ServiceResult.OK;
			
	}
	
	//아티스트 그룹 조회
	@Override
	public List<ArtistGroupVO> getArtistGroupsForForm() {
		log.info("AdminGoodsService: 모든 아티스트 그룹 목록 조회 요청");
		
		return goodsMapper.selectAllArtistGroups();
	}
	
	//상품 수정
	@Transactional
	@Override
	public ServiceResult updateGoodsItem(goodsVO goodsVO) throws Exception {
	    log.warn("<<<<< SERVICE updateGoodsItem 진입! Thread: {}, GoodsNm: {} >>>>>",
	            Thread.currentThread().getName(),
	            goodsVO.getGoodsNm());

	    // 0. 수정 대상 상품 존재 여부 확인
	    goodsVO existingGoods = goodsMapper.getGoodsDetail(goodsVO.getGoodsNo());
	    if (existingGoods == null) {
	        log.error("수정할 상품을 찾을 수 없습니다. goodsNo: {}", goodsVO.getGoodsNo());
	        throw new RuntimeException("수정할 상품 정보가 없습니다.");
	    }

	    Integer oldFileGroupNo = existingGoods.getFileGroupNo();
	    Integer currentWorkingFileGroupNo = oldFileGroupNo; 

	    boolean hasNewFiles = (goodsVO.getGoodsFiles() != null && goodsVO.getGoodsFiles().length > 0 && goodsVO.getGoodsFiles()[0].getSize() > 0);
	    log.info("수정 요청 시 새 파일 첨부 여부: {}", hasNewFiles);
	    log.info("기존 상품의 fileGroupNo: {}", existingGoods.getFileGroupNo());
	    log.info("폼에서 넘어온 삭제할 파일 상세 번호: {}", goodsVO.getDeleteAttachDetailNos());

	    if (goodsVO.getGoodsFiles() != null && goodsVO.getGoodsFiles().length > 0) {
	        MultipartFile firstFile = goodsVO.getGoodsFiles()[0];
	        log.info("첫 번째 파일 정보: OriginalFilename='{}', Size={}, isEmpty()={}, ContentType='{}'",
	                 firstFile.getOriginalFilename(), firstFile.getSize(), firstFile.isEmpty(), firstFile.getContentType());
	    } else {
	        log.info("goodsVO.getGoodsFiles()가 null이거나 비어있습니다.");
	    }

	    if (goodsVO.getDeleteAttachDetailNos() != null && !goodsVO.getDeleteAttachDetailNos().isEmpty()) {
	        log.info("삭제할 첨부파일 ID 목록: {}", goodsVO.getDeleteAttachDetailNos());
	        fileService.deleteSpecificFiles(goodsVO.getDeleteAttachDetailNos());

	        if (currentWorkingFileGroupNo != null && currentWorkingFileGroupNo > 0) {
	            int remainingFiles = fileService.countFilesInGroup(currentWorkingFileGroupNo);
	            if (remainingFiles == 0) {
	                currentWorkingFileGroupNo = null; // 기존 그룹이 비었음을 표시
	                log.info("기존 파일 그룹 {}의 특정 파일 삭제 후, 그룹에 파일이 없어 null로 설정", oldFileGroupNo);
	            }
	        }
	    }

	    if (hasNewFiles) { 
	        log.info("fileService.uploadAndProcessFiles 호출 전. 업로드할 파일 수: {}", goodsVO.getGoodsFiles().length);
	        Integer uploadedFileGroupNo = fileService.uploadAndProcessFiles(goodsVO.getGoodsFiles(), FILETYPECODE /*, uploaderId */);
	        log.info("fileService.uploadAndProcessFiles 호출 후 반환된 그룹 번호: {}", uploadedFileGroupNo);
	        
	        if (uploadedFileGroupNo != null && uploadedFileGroupNo > 0) {
	            currentWorkingFileGroupNo = uploadedFileGroupNo; // 새 파일 그룹 번호로 갱신
	            log.info("새 파일이 업로드되어 최종 파일 그룹 번호가 {}로 변경됨", currentWorkingFileGroupNo);
	        } else {
	            log.warn("새 파일 업로드 처리 실패 또는 반환된 그룹 번호가 유효하지 않음. 기존 파일 그룹 번호 {} 유지 (혹은 null)", currentWorkingFileGroupNo);
	        }
	    } 
	    goodsVO.setFileGroupNo(currentWorkingFileGroupNo);
	    log.info("goodsVO에 최종 설정된 fileGroupNo: {}", goodsVO.getFileGroupNo());


	    String statusEngKeyFromForm = goodsVO.getStatusEngKey();
	    String dbGoodsStatCode;
	    if ("IN_STOCK".equalsIgnoreCase(statusEngKeyFromForm)) {
	        dbGoodsStatCode = "GSC001";
	    } else if ("SOLD_OUT".equalsIgnoreCase(statusEngKeyFromForm)) {
	        dbGoodsStatCode = "GSC002";
	    } else {
	        log.warn("알 수 없거나 유효하지 않은 statusEngKey: '{}'. 기존 상태 유지 또는 기본값으로 설정 필요.", statusEngKeyFromForm);
	        dbGoodsStatCode = existingGoods.getGoodsStatCode();
	    }
	    goodsVO.setGoodsStatCode(dbGoodsStatCode);


	    if (goodsVO.getDeleteOptionNos() != null && !goodsVO.getDeleteOptionNos().isEmpty()) {
	        for (Integer goodsOptNoToDelete : goodsVO.getDeleteOptionNos()) {
	            if (goodsOptNoToDelete != null && goodsOptNoToDelete > 0) {
	                goodsMapper.deleteStockForOption(goodsOptNoToDelete);
	                goodsMapper.deleteGoodsOption(goodsOptNoToDelete);
	                log.info("기존 옵션 삭제 성공: goodsOptNo={}", goodsOptNoToDelete);
	            }
	        }
	    }

	    int currentOptionSequence = 0;
	    if (goodsVO.getOptions() != null && !goodsVO.getOptions().isEmpty()) {
	        log.info("처리할 옵션 개수 (수정/추가): {}", goodsVO.getOptions().size());
	        for (goodsOptionVO option : goodsVO.getOptions()) {
	            option.setGoodsNo(goodsVO.getGoodsNo());

	            String etcFromForm = option.getGoodsOptEtc();
	            if (etcFromForm == null || etcFromForm.trim().isEmpty()) {
	                option.setGoodsOptEtc(" ");
	            }
	            if (option.getGoodsOptFixYn() == null || option.getGoodsOptFixYn().isEmpty()) {
	                option.setGoodsOptFixYn("N");
	            }
	            option.setGoodsOptSec(++currentOptionSequence);

	            if (option.getGoodsOptNo() > 0) { 
	            	goodsMapper.updateGoodsOption(option);
	                log.info("기존 옵션 정보 DB 업데이트 성공! goodsOptNo: {}", option.getGoodsOptNo());
	                goodsMapper.deleteStockForOption(option.getGoodsOptNo()); 
	            } else { 
	                goodsMapper.insertGoodsOption(option);
	                log.info("새 옵션 정보 DB 등록 성공! new goodsOptNo: {}", option.getGoodsOptNo());
	            }

	            if (option.getInitialStockQty() != null && option.getInitialStockQty() >= 0) {
	                goodsStockVO stockVO = new goodsStockVO();
	                stockVO.setGoodsNo(option.getGoodsNo());
	                stockVO.setGoodsOptNo(option.getGoodsOptNo());
	                stockVO.setStockRemainQty(option.getInitialStockQty());
	                stockVO.setStockNewQty(option.getInitialStockQty());
	                stockVO.setStockTypeCode("STC001");
	                stockVO.setStockSafeQty(0);
	                stockVO.setStockUnitCost(0);

	                goodsMapper.insertGoodsStock(stockVO);
	                log.info("옵션 재고 정보 DB 처리 성공! goodsOptNo: {}, 재고: {}", option.getGoodsOptNo(), option.getInitialStockQty());
	            }
	        }
	    }

	    List<goodsOptionVO> finalOptionsInDb = goodsMapper.optionList(goodsVO.getGoodsNo());
	    if (finalOptionsInDb != null && !finalOptionsInDb.isEmpty()) {
	        goodsVO.setGoodsMultiOptYn("Y");
	    } else {
	        goodsVO.setGoodsMultiOptYn("N");
	    }
	    log.info("옵션 처리 완료 후 최종 결정된 goodsMultiOptYn: {}", goodsVO.getGoodsMultiOptYn());


	    if ("N".equals(goodsVO.getGoodsMultiOptYn())) {
	        goodsMapper.deleteAllOptionsStockForGoods(goodsVO.getGoodsNo());
	        goodsMapper.deleteAllOptionsForGoods(goodsVO.getGoodsNo());
	        
	        if (goodsVO.getStockRemainQty() != null && goodsVO.getStockRemainQty() >= 0) {
	            goodsStockVO stockDataForBaseProduct = new goodsStockVO();
	            stockDataForBaseProduct.setGoodsNo(goodsVO.getGoodsNo());
	            stockDataForBaseProduct.setGoodsOptNo(0);
	            stockDataForBaseProduct.setStockRemainQty(goodsVO.getStockRemainQty());
	            stockDataForBaseProduct.setStockNewQty(goodsVO.getStockRemainQty());
	            stockDataForBaseProduct.setStockTypeCode("STC001");
	            stockDataForBaseProduct.setStockSafeQty(0);
	            stockDataForBaseProduct.setStockUnitCost(0);

	            goodsMapper.deleteBaseStockForGoods(goodsVO.getGoodsNo(), 0);
	            goodsMapper.insertGoodsStock(stockDataForBaseProduct);
	            log.info("옵션 미사용으로 전환, 기본 상품 재고 정보 DB 등록/수정 성공!");
	        }
	    } else {
	        goodsMapper.deleteBaseStockForGoods(goodsVO.getGoodsNo(), 0);
	        log.info("옵션 사용 상품으로 전환됨에 따라 기본 상품 재고 (goods_opt_no=0) 삭제.");
	    }


	    goodsVO.setGoodsCode(existingGoods.getGoodsCode()); 

	    int finalUpdateGoodsCount = goodsMapper.updateGoodsItem(goodsVO);
	    if (finalUpdateGoodsCount <= 0) {
	        log.warn("상품 기본 정보 DB 최종 업데이트 실패: {}", goodsVO.getGoodsNm());
	        return ServiceResult.FAILED;
	    }
	    log.info("상품 기본 정보 DB 최종 업데이트 성공: goodsNo={}, goodsNm={}", goodsVO.getGoodsNo(), goodsVO.getGoodsNm());


	    if(oldFileGroupNo != null && oldFileGroupNo > 0 && !oldFileGroupNo.equals(goodsVO.getFileGroupNo())) {
	        fileService.deleteFilesByGroupNo(oldFileGroupNo);
	        log.info("GOODS 테이블에서 참조가 끊긴 기존 파일 그룹 {} 삭제 완료!", oldFileGroupNo);
	    }
		this.synchronizeGoodsStatusWithStock(goodsVO.getGoodsNo());
	    
	    return ServiceResult.OK;
	}
	
	//상품 삭제
	@Override
	@Transactional
	public ServiceResult deleteGoodsItems(int goodsNo) {
	    ServiceResult result = ServiceResult.FAILED;
	    log.warn("<<<<<Service deleteGoodsItems 진입!!!! goodsNo: {} >>>>>", goodsNo);
	    
	    Integer fileGroupNoToDelete = null;
	    try {
	        goodsVO goods = goodsMapper.getGoodsDetail(goodsNo); 
	        if (goods != null) {
	            fileGroupNoToDelete = goods.getFileGroupNo();
	            log.info("상품(goodsNo:{})에 연결된 파일 그룹(fileGroupNo:{}) 미리 확보", goodsNo, fileGroupNoToDelete);
	        } else {
	            log.warn("상품(goodsNo:{})이 존재하지 않아 삭제를 진행할 수 없습니다.", goodsNo);
	            return ServiceResult.FAILED; 
	        }

	        log.info("상품(goodsNo:{})에 연결된 찜 목록 데이터 삭제 시도", goodsNo);
	        wishlistMapper.deleteWishlistByGoodsNo(goodsNo);

	        log.info("상품(goodsNo:{})의 모든 옵션 재고 삭제 시도", goodsNo);
	        goodsMapper.deleteAllOptionsStockForGoods(goodsNo);
	        log.info("상품(goodsNo:{})의 모든 옵션 삭제 시도", goodsNo);
	        goodsMapper.deleteAllOptionsForGoods(goodsNo);

	        log.info("상품(goodsNo:{})의 기본 재고(goods_opt_no=0) 삭제 시도", goodsNo);
	        goodsMapper.deleteBaseStockForGoods(goodsNo, 0);

	        log.info("상품(goodsNo:{}) 데이터 삭제 시도", goodsNo);
	        int goodsDeleteStatus = goodsMapper.deleteGoodsItem(goodsNo);

	        if (goodsDeleteStatus > 0) {
	            if (fileGroupNoToDelete != null) {
	                log.info("상품 삭제 완료 후, 연결된 파일 그룹(fileGroupNo:{}) 삭제 시도", fileGroupNoToDelete);
	                fileService.deleteFilesByGroupNo(fileGroupNoToDelete); 
	            } else {
	                log.info("상품(goodsNo:{})에 연결된 파일 그룹이 없어 삭제하지 않습니다.", goodsNo);
	            }
	            
	            result = ServiceResult.OK;
	            log.info("상품(goodsNo:{}) 및 관련 데이터 성공적으로 삭제 완료.", goodsNo);
	        } else {
	            result = ServiceResult.FAILED;
	            log.warn("상품(goodsNo:{}) 삭제 실패 또는 해당 상품이 존재하지 않아 삭제할 수 없습니다.", goodsNo);
	        }
	    } catch (Exception e) {
	        log.error("상품(goodsNo:{}) 삭제 중 예외 발생: {}", goodsNo, e.getMessage(), e);
	       
	        throw new RuntimeException("상품 삭제 중 오류 발생: " + e.getMessage(), e);
	    }
	    return result;
	}

	/**
	 * 특정 상품의 총 재고를 기반으로 판매 상태를 동기화하는 private 메소드
	 * @param goodsNo 동기화할 상품 번호
	 */
	private void synchronizeGoodsStatusWithStock(int goodsNo) {
	    
	    int totalStock = goodsMapper.selectTotalStockForGoods(goodsNo);
	    log.info("상품(goodsNo:{})의 상태 동기화 시작. 계산된 총 재고: {}", goodsNo, totalStock);

	    goodsVO currentGoods = goodsMapper.getGoodsStatusOnly(goodsNo); 
	    if (currentGoods == null) {
	        log.warn("상태 동기화 중 상품(goodsNo:{}) 정보를 찾을 수 없어 중단합니다.", goodsNo);
	        return;
	    }
	    String currentStatus = currentGoods.getGoodsStatCode();

	    String newStatus = null;
	    if (totalStock <= 0 && !"GSC002".equals(currentStatus)) {
	        
	        newStatus = "GSC002";
	        log.info("재고가 0 이하이므로 상품(goodsNo:{}) 상태를 '품절({})'로 변경합니다.", goodsNo, newStatus);
	    } else if (totalStock > 0 && !"GSC001".equals(currentStatus)) {
	        
	        newStatus = "GSC001";
	        log.info("재고가 0보다 많으므로 상품(goodsNo:{}) 상태를 '판매중({})'으로 변경합니다.", goodsNo, newStatus);
	    }

	    
	    if (newStatus != null) {
	        goodsMapper.updateGoodsStatus(goodsNo, newStatus);
	        log.info("상품(goodsNo:{}) 상태 DB 업데이트 완료.", goodsNo);
	    } else {
	        log.info("상품(goodsNo:{})의 현재 상태가 재고와 일치하여 변경하지 않습니다.", goodsNo);
	    }
	}
	
	@Override
    public void retrieveGoodsList(PaginationInfoVO<goodsVO> pagingVO) {
        
        int totalRecord = goodsSearchMapper.selectGoodsCount(pagingVO);
        pagingVO.setTotalRecord(totalRecord);
        
        
        List<goodsVO> dataList = goodsSearchMapper.selectGoodsList(pagingVO);
        pagingVO.setDataList(dataList);
    }
	
	@Override
	public List<Map<String, Object>> getGoodsStatusCounts() {
	    return goodsSearchMapper.selectGoodsStatusCounts();
	}

    @Override
    public int getTotalGoodsCount() {
        return goodsSearchMapper.getTotalGoodsCount();
    }

	@Override
	public List<Map<String, Object>> getGoodsStockCounts() {
	    return goodsSearchMapper.selectGoodsStockCounts();
	}
}
