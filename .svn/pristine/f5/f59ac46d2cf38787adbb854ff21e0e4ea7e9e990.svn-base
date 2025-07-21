package kr.or.ddit.ddtown.service.admin.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.admin.member.IMemberAdminMapper;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.member.MemCodeListVO;
import kr.or.ddit.vo.member.MemberAdminVO;
import kr.or.ddit.vo.member.membership.MembershipSubscriptionsVO;
import kr.or.ddit.vo.order.OrderCancelVO;
import kr.or.ddit.vo.order.OrdersVO;

@Service
public class MemberAdminService implements IMemberAdminService {

	@Autowired
	private IMemberAdminMapper memberAdminMapper;

	@Override
	public List<MemberAdminVO> getMemberList() {

		List<MemberAdminVO> memberVO = memberAdminMapper.getMemberList();

		return memberVO;
	}

	@Override
	public MemberAdminVO getMember(String memUsername) {

		MemberAdminVO memberVO = memberAdminMapper.getMember(memUsername);

		return memberVO;
	}

	@Override
	public List<MemCodeListVO> getCodeList() {

		List<MemCodeListVO> codeList = memberAdminMapper.getCodeList();

		return codeList;
	}

	@Override
	public ServiceResult updateMember(MemberAdminVO memberVO) {
		ServiceResult result = null;

		int status = memberAdminMapper.updateMember(memberVO);

		memberVO.getPeopleVO().setUsername(memberVO.getMemUsername());

		int sta = memberAdminMapper.updatePeople(memberVO.getPeopleVO());

		if(status > 0 && sta > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult deleteMember(String memUsername) {

		ServiceResult result = null;

		int status = memberAdminMapper.deleteMember(memUsername);

		int stat = memberAdminMapper.deletePeople(memUsername);

		if(status > 0 && stat > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}

		return result;
	}

	@Override
	public int getTotalRecord(PaginationInfoVO<MemberAdminVO> pagingVO, String searchCode) {
		return memberAdminMapper.getTotalRecord(pagingVO, searchCode);
	}

	@Override
	public List<MemberAdminVO> getDataList(PaginationInfoVO<MemberAdminVO> pagingVO, String searchCode) {
		return memberAdminMapper.getDataList(pagingVO, searchCode);
	}

	/**
	 * 신규 가입자 수 가져오기
	 */
	@Override
	public int getTodayRegisterUser() {
		return memberAdminMapper.getTodayRegisterUser();
	}

	@Override
	public int getTotalMemCnt() {
		return memberAdminMapper.getTotalMemCnt();
	}

	@Override
	public int getGeneralMemCnt() {
		return memberAdminMapper.getGeneralMemCnt();
	}

	@Override
	public int getOutMemCnt() {
		return memberAdminMapper.getOutMemCnt();
	}

	@Override
	public int getBlackMemCnt() {
		return memberAdminMapper.getBlackMemCnt();
	}

	@Override
	public List<MemberAdminVO> joinComuList(String memUsername) {
		return memberAdminMapper.joinComuList(memUsername);
	}

	@Override
	public List<Map<Object, Object>> cntChartData(MemberAdminVO memberAdminVO) {
		
		Map<Object, Object> postMap = new HashMap<>();
		
		Map<Object, Object> replyMap = new HashMap<>();
		
		List<Map<Object, Object>> dataList = new ArrayList<>();
		
		List<Integer> postCntList = memberAdminMapper.postCntList(memberAdminVO);
		
		List<Integer> replyCntList = memberAdminMapper.replyCntList(memberAdminVO);
		
		postMap.put("label", "게시글");
		postMap.put("data", postCntList);
		postMap.put("borderColor", "#ff6384");
		postMap.put("backgroundColor","#ff6384cf");
		postMap.put("borderWidth","3");
		
		replyMap.put("label", "댓글");
		replyMap.put("data", replyCntList);
		replyMap.put("borderColor", "#36a2eb");
		replyMap.put("backgroundColor","#36a2ebb5");
		replyMap.put("borderWidth","3");
		
		
		dataList.add(postMap);
		dataList.add(replyMap);
		
		return dataList;
	}

	@Override
	public List<Map<Object, Object>> membershipList(String memUsername) {
		List<MembershipSubscriptionsVO> mainVO = memberAdminMapper.membershipList(memUsername);
		
		List<Map<Object, Object>> list = new ArrayList<>();
		
		if(mainVO.size() > 0 && mainVO != null) {
			for(int i=0; i<mainVO.size(); i++) {
				String mainMemUsername = mainVO.get(i).getMemUsername();
				int mainMbspNo = mainVO.get(i).getMbspNo();
				
				Map<Object, Object> map = new HashMap<>();
				List<MembershipSubscriptionsVO> subVO = memberAdminMapper.subMembershipList(mainMemUsername, mainMbspNo);
				if(subVO.size() > 0 && subVO != null) {
					for(int j=0; j<subVO.size(); j++) {
						map.put(j, subVO.get(j));
					}
				}
				
				mainVO.get(i).setSubMembership(map);
				
				Map<Object, Object> listMap = new HashMap<>();
				listMap.put(i, mainVO.get(i));
				list.add(listMap);
			}
		}
		return list;
	}

	@Override
	public List<OrdersVO> orderVOList(String memUsername) {
		
		List<OrdersVO> ordersVOList = memberAdminMapper.ordersVOList(memUsername);
		
		return ordersVOList;
	}

	@Override
	public List<Map<Object, Object>> orderCntList(String memUsername) {
		
		List<Integer> cancelCnt = memberAdminMapper.cancelCnt(memUsername);
		
		List<Integer> sellCnt = memberAdminMapper.sellCnt(memUsername);
		
		List<Integer> totalSellCnt = memberAdminMapper.totalSellCnt(memUsername);
		
		List<Map<Object, Object>> dataList = new ArrayList<>();
		
		Map<Object, Object> cancelMap = new HashMap<>();
		cancelMap.put("label", "취소금액");
		cancelMap.put("type", "bar");
		cancelMap.put("data", cancelCnt);
		cancelMap.put("borderColor", "#ff6384");
		cancelMap.put("backgroundColor","#ff6384b3");
		cancelMap.put("borderWidth","3");
		
		Map<Object, Object> sellMap = new HashMap<>();
		sellMap.put("label", "판매금액");
		sellMap.put("type", "bar");
		sellMap.put("data", sellCnt);
		sellMap.put("borderColor", "#36a2eb");
		sellMap.put("backgroundColor","#36a2ebc4");
		sellMap.put("borderWidth","3");
		
		Map<Object, Object> totalMap = new HashMap<>();
		totalMap.put("label", "누적금액");
		totalMap.put("type", "line");
		totalMap.put("data", totalSellCnt);
		totalMap.put("borderColor", "#4bc0c0");
		totalMap.put("backgroundColor","#4bc0c0b8");
		totalMap.put("borderWidth","2");
		totalMap.put("pointStyle","rect");
		
		dataList.add(cancelMap);
		dataList.add(sellMap);
		dataList.add(totalMap);
		
		return dataList;
	}

	@Override
	public List<OrdersVO> selectOrderList(PaginationInfoVO<OrdersVO> pagingVO) {
		
		List<OrdersVO> orderList = null;
		
		orderList = memberAdminMapper.sellOrderList(pagingVO);
		
		return orderList;
	}

	@Override
	public int orderListTotalRecord(PaginationInfoVO<OrdersVO> pagingVO) {
		
		int totalRecord = 0;
		
		totalRecord = memberAdminMapper.sellOrderTotal(pagingVO);
		
		
		return totalRecord;
	}

	@Override
	public List<OrderCancelVO> cancelOrderList(PaginationInfoVO<OrdersVO> pagingVO) {
		List<OrderCancelVO> cancelOrderList = null;
		
		cancelOrderList = memberAdminMapper.cancelOrderList(pagingVO);
		
		return cancelOrderList;
	}

	@Override
	public int cancelListTotalRecord(PaginationInfoVO<OrdersVO> pagingVO) {
		int totalRecord = 0;
		
		totalRecord = memberAdminMapper.cancelListTotalRecord(pagingVO);
		
		return totalRecord;
	}
}
