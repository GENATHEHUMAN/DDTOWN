package kr.or.ddit.dto.kakaopay;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class CancelRequest {
	private String cid; // 가맹점 코드
    private String tid; // 결제 고유 번호
    private Integer cancelAmount; // 취소 금액
    private Integer cancelTaxFreeAmount; // 취소 비과세 금액 (0으로 보내는 경우가 많음)
}
