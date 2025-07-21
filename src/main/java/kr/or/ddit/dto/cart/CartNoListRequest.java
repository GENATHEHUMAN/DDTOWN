package kr.or.ddit.dto.cart;

import java.util.List;

import lombok.Data;

@Data
public class CartNoListRequest {
	private List<Integer> cartNoList;
}
