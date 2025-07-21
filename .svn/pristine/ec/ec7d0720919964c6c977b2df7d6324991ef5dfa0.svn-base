package kr.or.ddit.ddtown.service.goods.cart;

import java.util.List;

import kr.or.ddit.vo.goods.GoodsCartVO;
import kr.or.ddit.vo.order.OrderDetailVO;

public interface ICartService {

	//카트에 넣을 때 사용자 아이디 가져오기
	public List<GoodsCartVO> getCartItemsUsername(String userId);

	//장바구니에 담아서 업데이트 하기
	public void addOrUpdateCartItem(GoodsCartVO cart);
	
	//장바구니에 담긴 상품 삭제하기
	public int deleteCartItem(int cartNo);
	
	//장바구니에서 선택해서 일괄 삭제하기!!
	public int deleteSelectedCartItems(List<Integer> cartNoList);
	
	//장바구니에서 수량 수정하고 업뎃하기!
	public int updateCartQuantity(GoodsCartVO cart);

	public void clearCart(String username);
	
	/**
     * 특정 장바구니 번호(cartNo) 리스트와 사용자 ID에 해당하는 장바구니 상품들을 조회합니다.
     *
     * @param cartNoList 조회할 장바구니 번호 리스트
     * @param username   현재 로그인한 사용자 ID (보안을 위해 필수)
     * @return 조회된 GoodsCartVO 리스트
     * @throws Exception DB 조회 중 발생할 수 있는 예외
     */
	public List<GoodsCartVO> getCartItemsByCartNos(List<Integer> selectedCartNos, String username) throws Exception;

	public void processCartAfterPayment(String username, List<OrderDetailVO> paidOrderDetails, boolean isFromCart);

	public int getCartItemCount(String memUsername);
}
