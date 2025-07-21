package kr.or.ddit.dto.kakaopay;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;

/**
 * 카카오페이 결제 단건 조회 API 응답 DTO
 * (GET /v1/payment/order 응답 구조를 반영)
 */
@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class KakaoPayInquiryResponseDTO {
    private String tid; // 결제 고유 번호
    private String cid; // 가맹점 코드
    private String status; // 결제 상태 (READY, PAID, CANCELED 등)
    private String partnerOrderId; // 가맹점 주문 번호
    private String partnerUserId; // 가맹점 회원 ID
    private String paymentMethodType; // 결제 수단 (MONEY, CARD)
    private String itemName; // 상품명
    private String itemCode; // 상품 코드
    private Integer quantity; // 상품 수량
    private Amount amount; // 결제 금액 정보 (총 금액, 비과세 등 - 초기 승인 금액 기준)
    private Amount canceledAmount; // 현재까지 누적된 취소 금액 정보
    private Amount cancelAvailableAmount; // 현재 취소 가능한 금액 정보 <--- 이 필드가 중요합니다.
    private String createdAt; // 결제 준비 요청 시각
    private String approvedAt; // 결제 승인 시각
    private String canceledAt; // 결제 취소 시각 (부분 취소/전체 취소 발생 시)
    private String payload; // 기타 파라미터
}
