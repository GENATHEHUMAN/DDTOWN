package kr.or.ddit.ddtown.service.goods.cancel.user;

import kr.or.ddit.ServiceResult;

public interface IUserCancelService {
	/**
     * 사용자로부터의 주문 취소 요청을 처리합니다.
     * @param orderNo 주문 번호
     * @param cancelReasonCode 취소 사유 코드 (사용자 선택)
     * @param cancelReasonDetail 취소 상세 사유 (사용자 입력)
     * @param memUsername 취소를 요청한 회원 아이디 (세션에서 가져옴)
     * @return ServiceResult.OK 또는 ServiceResult.FAILED
     */
    public ServiceResult processUserOrderCancel(Integer orderNo, String cancelReasonCode, String cancelReasonDetail, String memUsername);

}
