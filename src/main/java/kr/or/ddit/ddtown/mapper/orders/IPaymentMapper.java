package kr.or.ddit.ddtown.mapper.orders;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.order.PaymentVO;

@Mapper
public interface IPaymentMapper {
	
	/**
     * 결제 상태(PAYMENT_STAT_CODE)를 업데이트합니다.
     * @param paymentVO 업데이트할 정보를 담은 PaymentVO 객체 (orderNo, paymentStatCode 필수)
     * @return 업데이트된 행의 수
     */
	public int updatePaymentStatus(PaymentVO paymentToUpdate);

	public PaymentVO selectPaymentByOrderNo(int orderNo);

}
