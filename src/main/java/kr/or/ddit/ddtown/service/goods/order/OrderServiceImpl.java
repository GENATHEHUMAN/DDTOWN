package kr.or.ddit.ddtown.service.goods.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.ddtown.mapper.orders.ICancelMapper;
import kr.or.ddit.ddtown.mapper.orders.IOrderMapper;
import kr.or.ddit.ddtown.service.file.IFileService;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.file.AttachmentFileDetailVO;
import kr.or.ddit.vo.goods.goodsVO;
import kr.or.ddit.vo.order.OrderCancelVO;
import kr.or.ddit.vo.order.OrderDetailVO;
import kr.or.ddit.vo.order.OrdersVO;
import kr.or.ddit.vo.order.PaymentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OrderServiceImpl implements IOrderService {
	
	@Autowired
	private IOrderMapper orderMapper;
	
	@Autowired
	private IFileService fileService; // FileService 주입
	
	@Autowired
	private ICancelMapper cancelMapper;
	
    // (선택 사항) 코드명을 자주 조회한다면 캐싱하여 성능 향상
    private final Map<String, String> commonCodeCache = new ConcurrentHashMap<>();


	@Override
	@Transactional // 주문과 주문 상세는 한 트랜잭션으로 묶여야 합니다.
	public int createOrder(OrdersVO order, List<OrderDetailVO> orderDetails) {
		log.info("createOrder() 호출 - 주문 생성 시작. username: {}", order.getMemUsername());

		try {
			// 1. ORDERS 테이블에 주문 기본 정보 삽입
			int orderResult = orderMapper.insertOrder(order);
			if (orderResult == 0) {
				throw new RuntimeException("OrdersVO 삽입 실패: 데이터베이스에 주문 기본 정보를 저장할 수 없습니다.");
			}
			
			int createdOrderNo = order.getOrderNo();
			log.info("새로운 주문 생성 완료. orderNo: {}", createdOrderNo);

			// 2. ORDER_DETAIL 테이블에 주문 상세 정보 삽입
			if (orderDetails != null && !orderDetails.isEmpty()) {
				for (OrderDetailVO detail : orderDetails) {
					detail.setOrderNo(createdOrderNo); 
					int detailResult = orderMapper.insertOrderDetail(detail);
					if (detailResult == 0) {
						throw new RuntimeException("OrderDetailVO 삽입 실패: 주문 상세 정보를 저장할 수 없습니다. 상품번호: " + detail.getGoodsNo());
					}
				}
				log.info("주문 상세 {}건 삽입 완료.", orderDetails.size());
			}

			return createdOrderNo; 
		} catch (Exception e) {
			log.error("createOrder() 주문 생성 중 오류 발생: {}", e.getMessage(), e);
			throw new RuntimeException("주문 생성 실패", e);
		}
	}

	@Override
	public void savePaymentReadyInfo(PaymentVO payment) {
		log.info("savePaymentReadyInfo() 호출 - 결제 준비 정보 저장. orderNo: {}, tid: {}",
	             payment.getOrderNo(), payment.getTid());
		try {
			int result = orderMapper.insertPaymentReadyInfo(payment);
			if (result == 0) {
				throw new RuntimeException("PaymentVO 결제 준비 정보 삽입 실패: 데이터베이스에 결제 준비 정보를 저장할 수 없습니다.");
			}
			log.info("PaymentVO 결제 준비 정보 저장 완료. orderNo: {}", payment.getOrderNo());
		} catch (Exception e) {
			log.error("savePaymentReadyInfo() 결제 준비 정보 저장 중 오류 발생: {}", e.getMessage(), e);
			throw new RuntimeException("결제 준비 정보 저장 실패", e);
		}
	}

	@Override
	public void updateOrderStatus(int orderNo, String statusCode) {
		log.info("updateOrderStatus() 호출 - orderNo: {}, statusCode: {}", orderNo, statusCode);
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("orderNo", orderNo);
			params.put("statusCode", statusCode);
			int result = orderMapper.updateOrderStatus(params);
			if (result == 0) {
				log.warn("updateOrderStatus() 주문 상태 업데이트 실패 또는 대상 없음. orderNo: {}", orderNo);
			}
		} catch (Exception e) {
			log.error("updateOrderStatus() 주문 상태 업데이트 중 오류 발생: {}", e.getMessage(), e);
			throw new RuntimeException("주문 상태 업데이트 실패", e);
		}
	}

	@Override
	public void updatePaymentStatus(int orderNo, String statusCode) {
		log.info("updatePaymentStatus() 호출 - orderNo: {}, statusCode: {}", orderNo, statusCode);
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("orderNo", orderNo);
			params.put("statusCode", statusCode);
			int result = orderMapper.updatePaymentStatus(params);
			if (result == 0) {
				log.warn("updatePaymentStatus() 결제 상태 업데이트 실패 또는 대상 없음. orderNo: {}", orderNo);
			}
		} catch (Exception e) {
			log.error("updatePaymentStatus() 결제 상태 업데이트 중 오류 발생: {}", e.getMessage(), e);
			throw new RuntimeException("결제 상태 업데이트 실패", e);
		}
	}


	@Override
	public OrdersVO getOrderByOrderNo(int orderNo) {
		log.info("getOrderByOrderNo() 호출 - orderNo: {}", orderNo);
		try {
			return orderMapper.selectOrderByOrderNo(orderNo);
		} catch (Exception e) {
			log.error("getOrderByOrderNo() 주문 정보 조회 중 오류 발생: {}", e.getMessage(), e);
			throw new RuntimeException("주문 정보 조회 실패", e);
		}
	}

	@Override
	public PaymentVO getPaymentReadyInfoByOrderNo(int orderNo) {
		log.info("getPaymentReadyInfoByOrderNo() 호출 - orderNo: {}", orderNo);
		try {
			return orderMapper.selectPaymentReadyInfoByOrderNo(orderNo);
		} catch (Exception e) {
			log.error("getPaymentReadyInfoByOrderNo() 결제 준비 정보 조회 중 오류 발생: {}", e.getMessage(), e);
			throw new RuntimeException("결제 준비 정보 조회 실패", e);
		}
	}

	@Override
	@Transactional
	public void updateOrder(OrdersVO order) {
		log.info("updateOrder() 호출 - orderNo: {}", order.getOrderNo());
		try {
			int result = orderMapper.updateOrder(order);
			if (result == 0) {
				log.warn("updateOrder() 주문 정보 전체 업데이트 실패 또는 대상 없음. orderNo: {}", order.getOrderNo());
			}
		} catch (Exception e) {
			log.error("updateOrder() 주문 정보 전체 업데이트 중 오류 발생: {}", e.getMessage(), e);
			throw new RuntimeException("주문 정보 전체 업데이트 실패", e);
		}
	}

	@Override
	@Transactional 
	public void updatePaymentInfo(PaymentVO payment) {
		log.info("updatePaymentInfo() 호출 - orderNo: {}", payment.getOrderNo());
		try {
			int result = orderMapper.updatePaymentInfo(payment);
			if (result == 0) {
				log.warn("updatePaymentInfo() 결제 정보 전체 업데이트 실패 또는 대상 없음. orderNo: {}", payment.getOrderNo());
			}
		} catch (Exception e) {
			log.error("updatePaymentInfo() 결제 정보 전체 업데이트 중 오류 발생: {}", e.getMessage(), e);
			throw new RuntimeException("결제 정보 전체 업데이트 실패", e);
		}
	}

	@Override
    public List<OrderDetailVO> getOrderDetailsByOrderNo(int orderNo) {
        log.info("getOrderDetailsByOrderNo() 호출 - orderNo: {}", orderNo);
        List<OrderDetailVO> orderDetails = orderMapper.selectOrderDetailsByOrderNo(orderNo);

        if (orderDetails != null) {
            for (OrderDetailVO detail : orderDetails) {
                
                if (detail.getGoodsFileGroupNo() != 0) {
                    try {
                        AttachmentFileDetailVO representativeFile = fileService.getRepresentativeFileByGroupNo(detail.getGoodsFileGroupNo());
                        if (representativeFile != null && representativeFile.getWebPath() != null) {
                            detail.setRepresentativeImageUrl(representativeFile.getWebPath());
                        }
                    } catch (Exception e) {
                        log.error("대표 이미지 조회 중 오류 발생 (goodsNo: {}): {}", detail.getGoodsNo(), e.getMessage());
                  
                    }
                }
            }
        }
        return orderDetails;
    }

	@Override
    public OrdersVO retrieveOrderDetail(int orderNo) {
		int concertCheck = orderMapper.getConcertCheck(orderNo);
		OrdersVO order = null;
		if(concertCheck > 0) {
			order = orderMapper.getTicketNameAndPrice(orderNo);			
		}else {
			order = orderMapper.getOrderDetailsWithAllInfo(orderNo);
		}
		
		if (order != null && order.getOrderDetailList() != null) {
	        for (OrderDetailVO detail : order.getOrderDetailList()) {
	            if (detail.getGoodsFileGroupNo() != 0 && detail.getGoodsFileGroupNo() > 0) {
	                try {
	                    AttachmentFileDetailVO representativeFile = fileService.getRepresentativeFileByGroupNo(detail.getGoodsFileGroupNo());
	                    if (representativeFile != null && representativeFile.getWebPath() != null) {
	                        detail.setRepresentativeImageUrl(representativeFile.getWebPath());
	                    }
	                } catch (Exception e) {
	                    log.error("대표 이미지 조회 중 오류 발생 (goodsNo: {}): {}", detail.getGoodsNo(), e.getMessage());
	                }
	            }
	        }
	    }
		
        return order;
    }

	@Transactional
	@Override
	public void insertOrderCancel(OrderCancelVO orderCancelVO) {
		log.info("### [OrderService.insertOrderCancel] 서비스 진입. OrderCancelVO: {}", orderCancelVO);
        try {

        		cancelMapper.insertOrderCancel(orderCancelVO); 
            log.info("### [OrderService.insertOrderCancel] ORDER_CANCEL DAO 호출 성공.");
        } catch (Exception e) {
            log.error("### [OrderService.insertOrderCancel] ORDER_CANCEL 정보 삽입 중 DB 오류 발생: {}", e.getMessage(), e);
            throw e; 
        }
    }
	
	@Override
	public goodsVO getGoodsByGoodsNo(int goodsNo) {
		return orderMapper.getGoodsByGoodsNo(goodsNo);
	}

	@Override
    public int selectMyOrderCount(PaginationInfoVO<OrdersVO> pagingVO) {
        return orderMapper.selectMyOrderCount(pagingVO);
    }

    @Override
    public List<OrdersVO> selectMyOrderList(PaginationInfoVO<OrdersVO> pagingVO) {
        return orderMapper.selectMyOrderList(pagingVO);
    }

    @Override
    public int getTodayOrders() {
        log.info("getTodayOrders() 호출 - 오늘 주문 건수 조회");
        try {

            return orderMapper.getTodayOrdersCount();
        } catch (Exception e) {
            log.error("getTodayOrders() 오늘 주문 건수 조회 중 오류 발생: {}", e.getMessage(), e);
            throw new RuntimeException("오늘 주문 건수 조회 실패", e);
        }
    }


    
}