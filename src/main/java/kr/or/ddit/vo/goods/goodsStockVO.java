package kr.or.ddit.vo.goods;

import java.util.Date;

import lombok.Data;

@Data
public class goodsStockVO {
	
	//상품별 총 재고 조회용
	private int stockNo; //재고 번호
	private int goodsOptNo;  //옵션 번호
	private String stockTypeCode; //재고 분류 코드
	private int goodsNo; //상품 번호
	private int stockSafeQty; //안전 재고 수량
    private Integer stockRemainQty; //옵션의 현재고량
	private int stockNewQty; //신규 재고 수량
	private int stockUnitCost; //단위 원가
	private Date stockModDate; //최종 수정 일시
	
	private int totalStockQty; //상품 총 재고 수량

}
