package kr.or.ddit.ddtown.controller.admin.goods;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.service.admin.goods.items.IAdminGoodsService;
import kr.or.ddit.ddtown.service.goods.main.IGoodsService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.artist.ArtistGroupVO;
import kr.or.ddit.vo.goods.goodsOptionVO;
import kr.or.ddit.vo.goods.goodsVO;
import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
@RequestMapping("/admin/goods/items")
public class AdminGoodsItemsController {
	
	@Autowired
	private IGoodsService goodsservice;
	
	@Autowired
	private IAdminGoodsService admingoodsservice;
	
    @GetMapping("/list")
    public String goodsItemList(Model model,
            @RequestParam(name="currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(required = false) String searchWord,
            @RequestParam(name="searchType", required = false) String searchType,
            @RequestParam(name="statusFilter", required = false) String statusFilter, 
            @RequestParam(name="artGroupNo", required = false) String artGroupNo 
    		) {
                
            PaginationInfoVO<goodsVO> pagingVO = new PaginationInfoVO<>();
            pagingVO.setCurrentPage(currentPage);
            
            Map<String, Object> searchMap = new HashMap<>();
            if (searchWord != null && !searchWord.isEmpty()) {
                searchMap.put("searchWord", searchWord);
            }
            if (searchType != null && !searchType.isEmpty()) {
                searchMap.put("searchType", searchType);
            }
            if (statusFilter != null && !statusFilter.isEmpty()) { 
                searchMap.put("statusFilter", statusFilter);
            }
            
            if (artGroupNo != null && !artGroupNo.isEmpty()) {
                searchMap.put("artGroupNo", artGroupNo);
            }
            
            pagingVO.setSearchMap(searchMap); 

            log.info("### AdminGoodsItemsController - goodsItemList 호출: currentPage={}, searchMap={}",
                     pagingVO.getCurrentPage(), pagingVO.getSearchMap());

            admingoodsservice.retrieveGoodsList(pagingVO);
            
            List<Map<String, Object>> goodsStatusCounts = admingoodsservice.getGoodsStatusCounts();
            log.info("컨트롤러에서 모델에 추가할 goodsStatusCounts: {}", goodsStatusCounts); 
            model.addAttribute("goodsStatusCounts", goodsStatusCounts);
            
            int totalAllGoodsCount = admingoodsservice.getTotalGoodsCount();
            model.addAttribute("totalAllGoodsCount", totalAllGoodsCount); 
            
            List<Map<String, Object>> goodsStockCountsList = admingoodsservice.getGoodsStockCounts(); 
            log.info("컨트롤러에서 모델에 추가할 goodsStockCounts (재고별): {}", goodsStockCountsList);
            model.addAttribute("goodsStockCountsList", goodsStockCountsList); 
            
            model.addAttribute("pagingVO", pagingVO);
            
            List<ArtistGroupVO> artistGroups = admingoodsservice.getArtistGroupsForForm();
            model.addAttribute("artistGroups", artistGroups);
            
            log.info("최종 상품 상태 값 로깅..");
            List<goodsVO> currentGoodsList = pagingVO.getDataList();
            if(currentGoodsList != null && !currentGoodsList.isEmpty()) {
                for(goodsVO goods: currentGoodsList) {
                    log.info("상품번호: {}, 상품명: {}, 상태(Eng): {}, 상태(Kor): {}, 현재고: {}",
                            goods.getGoodsNo(),
                            goods.getGoodsNm(),
                            goods.getStatusEngKey(),
                            goods.getStatusKorName(),
                            goods.getStockRemainQty());
                }
            } else {
                log.info("조회된 최종 상품 목록이 없습니다.");
            }
            log.info("--- 최종 상품 상태 값 로깅 끝 ---");
            
            return "admin/goods/items/itemsList";
    }
	
	@GetMapping("/detail")
	public String goodsItemDetail(@RequestParam("id") int goodsNo, 
			RedirectAttributes ra,
			Model model
			) throws Exception { 
		log.info("상품 상세 페이지 요청! goodsNo: {}", goodsNo);
		
		goodsVO items = goodsservice.getGoodsDetail(goodsNo);
		
		if(items == null) {
			log.warn("goodsNo {}에 해당하는 상품 정보를 찾을 수 없습니다!", goodsNo);
			ra.addFlashAttribute("errorMessage", "상품 정보를 찾을 수 없습니다!");
			return "redirect:/admin/goods/items/list";
		}
		
		model.addAttribute("items", items); 
		List<goodsOptionVO> optionList = goodsservice.optionList(goodsNo);
		model.addAttribute("optionList", optionList);
		
		return "admin/goods/items/itemsDetail";
	}
	
	@GetMapping("/form")
	public String goodsItemFormPage(Model model) {
		log.info("상품 등록 폼 요청");
		
		List<ArtistGroupVO> artistList = admingoodsservice.getArtistGroupsForForm();
		
		log.info("컨트롤러 - artistList is null: {}", (artistList == null));
		
		if(artistList != null) {
			log.info("컨트롤러 - artistList size: {}", artistList.size());
			for (ArtistGroupVO artist : artistList) {
				log.info("컨트롤러 - Artist: No={}, Name={}", artist.getArtGroupNo(), artist.getArtGroupNm());
			}
		}
		
		model.addAttribute("artistList", artistList);
		
		goodsVO currentItem = new goodsVO();
		log.info("컨트롤러 - item.artGroupNo: {}", currentItem.getArtGroupNo());
		
		model.addAttribute("item", currentItem);
		
		return "admin/goods/items/itemsForm";
	}
	
	@PostMapping("/form")
	public String goodsItemForm(
			@ModelAttribute goodsVO goods, 
			RedirectAttributes ra,
			Model model,
			HttpServletRequest request
			) {
	    log.warn("<<<<< CONTROLLER POST /items/register 진입! Thread: {}, SessionId: {} >>>>>", 
	            Thread.currentThread().getName(), 
	            request.getSession().getId()); 
		
		log.info("goodsItemRegister() 실행!!! goodsVO: {}", goods);
		log.info("옵션 개수: {}", goods.getOptions() != null ? goods.getOptions().size() : 0);
		
		String goPage = "";
		
		try { 
			ServiceResult result = admingoodsservice.itemsRegister(goods); 
			
			if (ServiceResult.OK.equals(result)) { 
				ra.addAttribute("successMessage", "상품 등록이 성공했습니다!!");
				goPage = "redirect:/admin/goods/items/list";
			} else {
				log.warn("상품 등록 실패: {}", goods.getGoodsNo());
				
				model.addAttribute("errorMessage", "상품 등록에 실패했습니다!! 입력 내용을 확인하세요!!");
				model.addAttribute("item", goods);

				List<ArtistGroupVO> artistList = admingoodsservice.getArtistGroupsForForm();
				model.addAttribute("artistList", artistList);
				
				goPage = "admin/goods/items/itemsForm";
			}
			
		} catch (Exception e) { 
			log.error("상품 등록 중 시스템 오류 발생", e);
			
			model.addAttribute("errorMessage", "시스템 오류로 인해 상품 등록에 실패했습니다. (" + e.getMessage() +")");
			
			List<ArtistGroupVO> artistList = admingoodsservice.getArtistGroupsForForm();
			model.addAttribute("artistList", artistList);
			
			goPage = "admin/goods/items/itemsForm";
		} 
		
		return goPage;
	}
	
	@GetMapping("/update")
	public String goodsItemUpdateFormPage(
			@RequestParam("id") int goodsNo, 
			Model model,
			RedirectAttributes ra
			) {
		log.info("상품 수정 폼 요청! goodsNo: {}", goodsNo);
		
		try {
			goodsVO modItems = goodsservice.getGoodsDetail(goodsNo);
			
			if(modItems == null) {
				log.warn("goodsNo {}에 해당하는 상품 정보를 찾을 수 없어 수정 폼을 표시할 수 없습니다!!", goodsNo);
				ra.addAttribute("errorMessage", "수정할 상품 정보를 찾을 수 없습니다!!");
				return "redirect:/admin/goods/items/list"; 
			}
			
			model.addAttribute("item", modItems); 
			
			List<ArtistGroupVO> artistList = admingoodsservice.getArtistGroupsForForm();
			model.addAttribute("artistList", artistList);
			
			return "admin/goods/items/itemsUpdate";
			
		} catch (Exception e) {
			log.error("상품 수정 폼 로딩 중 오류 발생! goodNo: {}", goodsNo, e);
			ra.addFlashAttribute("errorMessage", "상품 정보를 불러오는 중 오류가 발생했습니다!");
			return "redirect:/admin/goods/items/list";
		}
	}
	
	@PostMapping("/update")
	public String goodsItemUpdateForm (
			@ModelAttribute("item") goodsVO goods,
			BindingResult bindingResult,
			@RequestParam(name="deleteAttachDetailNos", required=false) String deleteAttachDetailNosCsv, 
			@RequestParam(name="deleteOptionNos", required=false) String deleteOptionNosCsv, 
			RedirectAttributes ra,
			Model model,
			HttpServletRequest request
			) {
		
		log.warn("<<<<<< Controller POST /items/update 진입! Thread: {}, SessionId: {}",
				Thread.currentThread().getName(),
				request.getSession().getId());
		
		log.info("goodsItemUpdateFrom 실행..!!! goodsVO: {}", goods);
		log.info("넘어온 옵션 개수: {}", goods.getOptions() != null ? goods.getOptions().size()	 :0);
		log.info("삭제할 이미지 ID 문자열: {}", deleteAttachDetailNosCsv);
		log.info("삭제할 옵션 ID 문자열: {}", deleteOptionNosCsv);
		
		String goPage = "";
		
		List<Integer> imageIdsToDelete = new ArrayList<>();
		
		if(deleteAttachDetailNosCsv != null && !deleteAttachDetailNosCsv.isEmpty()) {
			String[] idsArray = deleteAttachDetailNosCsv.split(",");
			
			for(String idStr : idsArray) {
				if(!idStr.trim().isEmpty()) {
					try {
						imageIdsToDelete.add(Integer.parseInt(idStr.trim()));
					} catch (NumberFormatException e) {
						log.warn("유효하지 않은 삭제 파일 ID: {}", idStr);
					}
				}
			}
		}
		
		goods.setDeleteAttachDetailNos(imageIdsToDelete);
		
		List<Integer> optionIdsToDelete = new ArrayList<>();
		
		if(deleteOptionNosCsv != null && !deleteOptionNosCsv.isEmpty()) {
			String[] idsArray = deleteOptionNosCsv.split(",");
			
			for(String idStr : idsArray) {
				if (!idStr.trim().isEmpty()) {
					try {
						optionIdsToDelete.add(Integer.parseInt(idStr.trim()));
					} catch (NumberFormatException e) {
						log.warn("유효하지 않은 삭제 옵션 ID: {}", idStr);
					}
				}
			}
		}
		
		goods.setDeleteOptionNos(optionIdsToDelete);
		
		if(bindingResult.hasErrors()) {
			log.warn("상품 수정 유효성 검사 오류 발생! 오류 개수: {}", bindingResult.getErrorCount());
			
			model.addAttribute("errorMessage", "입력값에 오류가 있습니다!!");
			
			List<ArtistGroupVO> artistList = admingoodsservice.getArtistGroupsForForm();
			model.addAttribute("artistList", artistList);
			
			return "admin/goods/items/itemsUpdate";
		}
		
		try {
			ServiceResult result = admingoodsservice.updateGoodsItem(goods);
			
			if (ServiceResult.OK.equals(result)) {
				ra.addFlashAttribute("successMessage", "상품 정보가 성공적으로 수정됐습니다!!");
				goPage = "redirect:/admin/goods/items/detail?id=" + goods.getGoodsNo(); 
			} else {
				log.warn("상품 수정 실패!! goodsNo: {}", goods.getGoodsNo());
				
				model.addAttribute("errorMessage", "상품 수정에 실패했습니다!! 다시 시도해주세요!");
				model.addAttribute("item", goods);
				
				List<ArtistGroupVO> artistList = admingoodsservice.getArtistGroupsForForm();
				model.addAttribute("artistList", artistList);
				goPage = "admin/goods/items/itemsUpdate";
			}
		} catch (IllegalArgumentException iae) { 
			log.warn("상품 수정 중 유효하지 않은 인자 예외 발생: {}", iae.getMessage());
			model.addAttribute("errorMessage", iae.getMessage()); 
			
			model.addAttribute("item", goods);
			List<ArtistGroupVO> artistList = admingoodsservice.getArtistGroupsForForm();
			model.addAttribute("artistList",artistList);
			
			goPage = "admin/goods/items/itemsUpdate";
		} catch (Exception e) {
			log.error("상품 수정 중 시스템 오류 발생", e);
			model.addAttribute("errorMessage", "시스템 오류로 인해 상품 수정에 실패했습니다!!");
			
			model.addAttribute("item", goods);
			List<ArtistGroupVO> artistList = admingoodsservice.getArtistGroupsForForm();
			model.addAttribute("artistList",artistList);
			
			goPage = "admin/goods/items/itemsUpdate";
		}
		
		return goPage;
	}
	
	@PostMapping("/delete")
    public String deleteGoodsItems(
    		@RequestParam("goodsNo") int goodsNo, 
    		RedirectAttributes ra
    		) {
        log.info(">>>>>> 컨트롤러 deleteGoodsItems 진입! goodsNo: {} <<<<<<", goodsNo);
        try {
            ServiceResult result = admingoodsservice.deleteGoodsItems(goodsNo);

            if (result == ServiceResult.OK) {
                ra.addFlashAttribute("message", "상품이 성공적으로 삭제되었습니다.");
                log.info("상품(goodsNo:{}) 삭제 성공!! 목록으로 리다이렉트!", goodsNo);
                return "redirect:/admin/goods/items/list"; 
            } else {
                ra.addFlashAttribute("errorMessage", "상품 삭제에 실패했습니다!!!");
                log.warn("상품(goodsNo:{}) 삭제 실패!! 서비스 결과: {}", goodsNo, result);

                return "redirect:/admin/goods/items/detail?id=" + goodsNo; 
            }
        } catch (Exception e) {
            
            log.error("상품(goodsNo:{}) 삭제 중 예상치 못한 오류 발생: {}", goodsNo, e.getMessage(), e);
            ra.addFlashAttribute("errorMessage", "상품 삭제 중 예상치 못한 오류가 발생했습니다: " + e.getMessage());

            return "redirect:/admin/goods/items/detail?id=" + goodsNo; 
        }
    }
}
    
