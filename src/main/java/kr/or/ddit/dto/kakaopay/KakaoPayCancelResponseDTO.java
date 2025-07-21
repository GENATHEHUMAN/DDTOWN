package kr.or.ddit.dto.kakaopay;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class) // snake_case를 camelCase로 자동 매핑
public class KakaoPayCancelResponseDTO {
    private String aid; // 요청 고유 번호
    private String tid; // 결제 고유 번호
    private String cid; // 가맹점 코드
    private String status; // 결제 상태 (CANCELED, PARTIAL_CANCELED 등)
    private String partnerOrderId; // 가맹점 주문 번호
    private String partnerUserId; // 가맹점 회원 ID
    private String itemName; // 상품명
    private String itemCode; // 상품 코드
    private Integer quantity; // 상품 수량

    private Amount amount; // 취소 요청한 금액 정보 (DTO 재활용)
    private Amount approvedCancelAmount; // 누적으로 취소된 금액
    private Amount canceledAmount; // 이번 요청으로 취소된 금액 (amount 필드와 다름)
    private Amount remainAmount; // 취소 후 남은 금액

    private String createdAt; // 결제 준비 요청 시각
    private String approvedAt; // 결제 승인 시각
    private String canceledAt; // 결제 취소 시각

    private String payload; // 기타 파라미터
}
