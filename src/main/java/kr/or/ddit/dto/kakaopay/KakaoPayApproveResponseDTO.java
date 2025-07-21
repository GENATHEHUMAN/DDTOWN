package kr.or.ddit.dto.kakaopay;

import lombok.Data;

@Data
public class KakaoPayApproveResponseDTO {
	private String aid; // 요청 고유 번호
    private String tid; // 결제 고유 번호
    private String cid; // 가맹점 코드
    private String sid; // 정기 결제용 SID (정기 결제 시)
    private String partner_order_id; // 가맹점 주문 번호
    private String partner_user_id; // 가맹점 회원 ID
    private String item_name; // 상품명
    private String item_code; // 상품 코드 (선택 사항)
    private Integer quantity; // 상품 수량
    private Amount amount; // 결제 금액 정보 (Amount DTO 객체)
    private String created_at; // 결제 준비 요청 시각
    private String approved_at; // 결제 승인 시각
    private String payload; // 기타 파라미터 (최대 200자)

}
