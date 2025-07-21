package kr.or.ddit.ddtown.mapper.goods;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.goods.GoodsCartVO;

@Mapper
public interface IGoodsCartMapper {
	
	//카트에 회원마다 다르게 담아올 리스트!~
	public List<GoodsCartVO> selectCartItemsUsername(String userId);
	
	//카트에 있는 상품 중복인지 확인하려고 가져오기!
	public GoodsCartVO selectCartItem(GoodsCartVO cart);
	
	//카트에 상품 담아서 정보 넘기기~~!!
	public void insertCartItem(GoodsCartVO cart);
	
	//카트에 담긴 상품 재고 업뎃하기!!
	public void updateCartItemQuantity(GoodsCartVO existingCartItem);
	
	//카트에 담긴 상품 삭제하기!
	public int deleteCartItem(int cartNo);
	
	//카트에 선택된 상품 일괄 삭제하기!
	public int deleteSelectedCartItems(List<Integer> cartNoList);
	
	//장바구니에 담긴 상품 수량 변경하기!!
	public int updateCartQuantity(GoodsCartVO cart);

	public int deleteCartByUsername(String username);

	 /**
     * 선택된 장바구니 번호 목록과 사용자명으로 장바구니 아이템 정보를 조회합니다.
     * @param paramMap cartNos (List<Integer>)와 username (String)을 포함하는 Map
     * @return 조회된 GoodsCartVO 리스트
     */
    public List<GoodsCartVO> getCartItemsByCartNosAndUser(Map<String, Object> paramMap);
    
    /**
	 * 특정 사용자의 장바구니에서 특정 상품(상품번호, 옵션번호)에 해당하는 장바구니 아이템을 조회합니다.
	 * (수량 업데이트를 위해 현재 수량과 cartNo를 가져옴)
	 * @param params (memUsername, goodsNo, goodsOptNo)
	 * @return 조회된 GoodsCartVO (없으면 null)
	 */
	public GoodsCartVO selectCartItemByGoodsInfo(Map<String, Object> params);

	/**
	 * 특정 회원의 장바구니에 담긴 전체 상품의 총 개수(수량 합계)를 조회합니다.
	 * 이는 장바구니 뱃지에 표시될 숫자가 됩니다.
	 * @param memUsername 회원 아이디
	 * @return 해당 회원의 장바구니에 담긴 상품의 총 수량 (상품 종류 수 아님)
	 */
	public int getCartItemCount(String memUsername);
}
