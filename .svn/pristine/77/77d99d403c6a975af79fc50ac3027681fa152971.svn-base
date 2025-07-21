package kr.or.ddit.vo.goods;

import lombok.Data;

@Data
public class goodsOptionVO {
	private int goodsOptNo; //옵션 번호
	private int goodsNo; //상품 번호
	private String goodsOptNm; //옵션명
	private String goodsOptFixYn = "N"; //고정 옵션 여부
	private String goodsOptEtc; //비고
	private int goodsOptSec; //출력 순서
	private int goodsOptPrice; //옵션 가격
	
	private Integer stockRemainQty; //옵션의 현재고량
	
	//초기 옵션 재고 수량 받아올 필드
	private Integer initialStockQty;
	
	//해당 옵션의 재고 정보를 담을 goodsStockVO 객체 추가 ⭐
	private goodsStockVO goodsStock; 
	
	private int cancelPrice;
}
