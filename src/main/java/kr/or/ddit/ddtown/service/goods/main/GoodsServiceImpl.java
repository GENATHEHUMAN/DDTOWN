package kr.or.ddit.ddtown.service.goods.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.goods.IGoodsMapper;
import kr.or.ddit.ddtown.mapper.goods.IGoodsSearchMapper;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import kr.or.ddit.vo.goods.goodsOptionVO;
import kr.or.ddit.vo.goods.goodsStockVO;
import kr.or.ddit.vo.goods.goodsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GoodsServiceImpl implements IGoodsService {
	
	@Autowired
	private IGoodsMapper mapper;
	
	@Autowired
	private IFileService fileService;
	
	@Autowired
	private IGoodsSearchMapper goodsSearchMapper;
	
	//상품 리스트 가져오기
	@Override
	public List<goodsVO> goodsList() {	
		log.info("goodsList() 서비스 호출! 상품 목록 조회 시작!");
		//1. DB에서 기본 상품 목록 조회
		List<goodsVO> itemList = mapper.goodsList();
		
		//2. 각 상품에 대한 대표 이미지 설정
		if(itemList != null && !itemList.isEmpty()) {
			for (goodsVO items : itemList) {
				if (items.getFileGroupNo() != null && items.getFileGroupNo() > 0) {
					AttachmentFileDetailVO imageFiles;
					try {
						imageFiles = fileService.getRepresentativeFileByGroupNo(items.getFileGroupNo());
					
						if(imageFiles != null && imageFiles.getWebPath() != null && !imageFiles.getWebPath().isEmpty()) {
							items.setRepresentativeImageUrl(imageFiles.getWebPath());
							log.debug("상품 번호 {}의 대표 이미지 경로 설정: {}", items.getGoodsNo(), imageFiles.getWebPath());
						} else {
							items.setRepresentativeImageUrl(null);
							log.warn("상품 번호 {} (fileGroupNo: {})에 대한 대표 이미지를 찾을 수 없거나 웹 경로가 없습니다.", items.getGoodsNo(), items.getFileGroupNo());
						} 
					} catch (Exception e) {
						log.error("상품 번호 {}의 대표 이미지 조회 중 오류발생!: {}", items.getGoodsNo(), e.getMessage());
						items.setRepresentativeImageUrl(null);
					}
					
				} else {
					items.setRepresentativeImageUrl(null);
				}
				
				try {
                    List<goodsOptionVO> options = mapper.optionList(items.getGoodsNo());
                    if (options != null && !options.isEmpty()) {
                    	items.setDefaultOptionNo(options.get(0).getGoodsOptNo());
                        log.debug("상품 번호 {}의 기본 옵션 번호 설정: {}", items.getGoodsNo(), items.getDefaultOptionNo());
                    } else {
                    	items.setDefaultOptionNo(0); // <-- NULL 대신 0으로 설정
                        log.warn("상품 번호 {}에 대한 옵션 정보가 없으므로 기본 옵션 번호 0을 설정합니다.", items.getGoodsNo());
                    }
                } catch (Exception e) {
                    log.error("상품 번호 {}의 기본 옵션 조회 중 오류 발생!: {}", items.getGoodsNo(), e.getMessage(), e);
                    items.setDefaultOptionNo(0); // <-- 오류 발생 시에도 NULL 대신 0으로 설정
                }
			}
		}
		log.info("goodsList() 서비스 - 상품 목록 조회 및 대표 이미지 설정 완료! {}", (itemList != null ? itemList.size() : 0));
		return itemList;
	}
	
	//굿즈 개별 상세 불러오기
	@Override
	public goodsVO getGoodsDetail(int goodsNo) throws Exception {
		log.info("서비스 계층 getGoodsDetail - 받은 goodsNo: {}", goodsNo);
		goodsVO items = mapper.getGoodsDetail(goodsNo); 
		
		if(items != null) {
			//1.대표 이미지 정보 설정
			if(items.getFileGroupNo() != null && items.getFileGroupNo() > 0) {
				AttachmentFileDetailVO imageFiles;
				try {
					imageFiles = fileService.getRepresentativeFileByGroupNo(items.getFileGroupNo());
					items.setRepresentativeImageFile(imageFiles);
					
					if(imageFiles != null && imageFiles.getWebPath() != null && !imageFiles.getWebPath().isEmpty()) {
						
						items.setRepresentativeImageUrl(imageFiles.getWebPath());
						log.debug("상품 번호 {}의 상세 - 대표 이미지 경로!: {}", items.getGoodsNo(), imageFiles.getWebPath());
					} else {
						
						items.setRepresentativeImageUrl(null);
						log.warn("상품 번호 {} (fileGroupNo: {})에 대한 대표 이미지를 찾을 수 없거나 웹 경로가 없습니다.", items.getGoodsNo(), items.getFileGroupNo());
					}
				} catch (Exception e) {
					log.error("상품 번호 {}의 대표 이미지 조회 중 오류발생!: {}", items.getGoodsNo(), e.getMessage());
					items.setRepresentativeImageUrl(null);
				}
				
				//2.전체 파일 목록 설정
				List<AttachmentFileDetailVO> allAttachedFiles = fileService.getFileDetailsByGroupNo(items.getFileGroupNo());
				items.setAttachmentFileList(allAttachedFiles); //goodsVO의 attachmentFileList 필드에 설정
				if (allAttachedFiles != null) {
					log.debug("상품 번호 {}의 전체 첨부파일 {}개 로드됨.", items.getGoodsNo(), allAttachedFiles.size());
				} else {
					items.setAttachmentFileList(null);
					log.warn("상품 번호 {} (fileGroupNo: {})에 대한 전체 첨부파일 목록을 가져오지 못했습니다..", items.getGoodsNo(), items.getFileGroupNo());
				}
			
			} else {
				items.setRepresentativeImageUrl(null);
			}
			
			//3. 상품의 총 재고 수량 설정
			Integer totalStock = mapper.selectTotalStockForGoods(goodsNo);
			items.setStockRemainQty(totalStock != null ? totalStock : 0);
			log.debug("상품 번호 {} 총 재고 수량: {}	", items.getGoodsNo(), items.getStockRemainQty());
			
            try {
                List<goodsOptionVO> options = mapper.optionList(items.getGoodsNo());
                
                items.setOptions(options);
                
                if (options != null) {
                    log.debug("상품 번호 {}의 옵션 리스트 로드됨. 옵션 개수: {}", items.getGoodsNo(), options.size());
                }
                
                if (options != null && !options.isEmpty()) {
                    items.setDefaultOptionNo(options.get(0).getGoodsOptNo());
                    log.debug("상품 번호 {} 상세 - 기본 옵션 번호 설정: {}", items.getGoodsNo(), items.getDefaultOptionNo());
                } else {

                    items.setDefaultOptionNo(0); // <-- NULL 대신 0으로 설정
                    log.warn("상세 조회 상품 번호 {}에 대한 옵션 정보가 없습니다.", items.getGoodsNo());
                }
            } catch (Exception e) {
                log.error("상세 조회 상품 번호 {}의 기본 옵션 조회 중 오류 발생!: {}", items.getGoodsNo(), e.getMessage(), e);

                items.setDefaultOptionNo(0); // <-- 오류 발생 시에도 NULL 대신 0으로 설정
            }
			
			log.debug("조회된 상품 판매가: {}", items.getGoodsPrice());
			log.debug("조회된 상품 등록일: {}", items.getGoodsRegDate());
		} else {
			log.warn("getGoodsDetail: goodsNo {}에 해당하는 상품 정보 없음!", goodsNo);
		}
		
		return items;
	}
	
	//옵션 리스트 가져오기
	@Override
	public List<goodsOptionVO> optionList(int goodsNo) {
		return mapper.optionList(goodsNo);
	}
	
	//굿즈 상태 코드 가져오기
	@Override
	public List<goodsVO> getgoodsStatus() {
		return mapper.getgoodsStatus();
	}
	
	//굿즈 현재 총재고 가져오기
	@Override
	public List<goodsStockVO> getgoodsTotalStock() {
		return mapper.getgoodsTotalStock();
	}
	
	// IGoodsMapper.xml의 getOptionDetail 쿼리를 호출하는 서비스 메서드 구현
    @Override
    public goodsOptionVO getGoodsOption(int goodsOptNo) {
        log.info("getGoodsOption() 서비스 호출! 옵션 번호: {}", goodsOptNo);
        return mapper.getOptionDetail(goodsOptNo); // XML 매퍼의 ID를 호출합니다.
    }
	
	//상품 리스트 싹 다 페이지네이션으로 가져오기
	@Override
    public void retrieveGoodsList(PaginationInfoVO<goodsVO> pagingVO) {
        // 1. 검색 조건에 맞는 전체 상품 수를 조회해서 PagingVO에 설정
        int totalRecord = goodsSearchMapper.selectGoodsCount(pagingVO);
        pagingVO.setTotalRecord(totalRecord);
        
        // 2. 페이지네이션이 적용된 상품 목록을 조회
        List<goodsVO> dataList = goodsSearchMapper.selectGoodsList(pagingVO);
        pagingVO.setDataList(dataList);
    }
	
	@Override
	public void retrieveUserGoodsList(PaginationInfoVO<goodsVO> pagingVO) {
		// 1. 총 상품 개수 조회
        int totalRecordCount = goodsSearchMapper.selectUserGoodsListCount(pagingVO);
        pagingVO.setTotalRecord(totalRecordCount);

        // 2. 현재 페이지에 해당하는 상품 목록 조회
        List<goodsVO> dataList = goodsSearchMapper.selectUserGoodsList(pagingVO);
        pagingVO.setDataList(dataList);
		
	}

	@Override
    public List<ArtistGroupVO> getArtistGroups() {
        log.info("### GoodsServiceImpl - getArtistGroups() 호출: 아티스트 그룹 목록 조회 시작");
        List<ArtistGroupVO> artistGroups = mapper.selectAllArtistGroups();
        log.info("### GoodsServiceImpl - getArtistGroups() 호출: 조회된 아티스트 그룹 수 = {}", artistGroups != null ? artistGroups.size() : 0);
        return artistGroups;
    }

	@Override
	public List<goodsVO> getBestSellingGoods(int i) {
		List<goodsVO> goodsList = mapper.getBestSellingGoods(i);
		for(goodsVO goods : goodsList) {
			Integer fileGroupNo = goods.getFileGroupNo();
			if(fileGroupNo != null && fileGroupNo > 0) {
				try {
					AttachmentFileDetailVO file = fileService.getRepresentativeFileByGroupNo(fileGroupNo);
					if(file != null && file.getWebPath() != null) {
						goods.setRepresentativeImageUrl(file.getWebPath());
					}
				} catch (Exception e) {
					log.error("대표 이미지 조회 중 오류..", e);
				}
			}
		}
		
		
		return goodsList;
	}
}
