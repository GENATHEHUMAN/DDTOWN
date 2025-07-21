package kr.or.ddit.vo.goods;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsWishListVO {
	private String memUsername;
	private int goodsNo;
	private Date wishRegDate;
}
