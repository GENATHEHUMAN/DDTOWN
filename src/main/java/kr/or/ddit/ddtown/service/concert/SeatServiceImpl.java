package kr.or.ddit.ddtown.service.concert;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.ddtown.mapper.concert.seat.ISeatMapper;
import kr.or.ddit.vo.common.CommonCodeDetailVO;
import kr.or.ddit.vo.concert.ConcertSeatMapVO;
import kr.or.ddit.vo.concert.ConcertVO;
import kr.or.ddit.vo.concert.SeatVO;
import kr.or.ddit.vo.concert.TicketVO;

@Service
public class SeatServiceImpl implements ISeatService {

	@Autowired
	private ISeatMapper seatMapper;

	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	/**
	 * 콘서트 예정 목록 불러오기
	 */
	@Override
	public List<ConcertVO> selectConcertList() {
		return seatMapper.selectConcertList();
	}

	/**
	 * 모든 정보 다들어있는 좌석정보 인서트
	 */
	@Transactional
	@Override
	public void insertSeat(SeatVO seatVO) {
		seatMapper.insertSeat(seatVO);
	}

	/**
	 * 좌석정보를 불러오기위한 티켓정보 가져오기
	 */
	@Override
	public List<TicketVO> getTicketInfo(int concertNo) {
		return seatMapper.getTicketInfo(concertNo);
	}

	/**
	 * 좌석등급 가져오기
	 */
	@Override
	public List<ConcertSeatMapVO> getSeatGradeInfo(int concertNo) {
		return seatMapper.getSeatGradeInfo(concertNo);
	}

	/**
	 * 콘서트 생성시 티켓정보 생성하기
	 * @return
	 */
	@Transactional
	@Override
	public ServiceResult insertTicket(ConcertVO concertVO, int goodsNo) {
		// 콘서트 별 좌석 등급 및 가격 매핑 테이블 생성
		int concertNo = concertVO.getConcertNo();
		int concertHallNo = concertVO.getConcertHallNo();
		int batchSize = 300;
		List<String> seatSectionList = seatMapper.selectSeatSection(concertHallNo);
		List<ConcertSeatMapVO> csmList = new ArrayList<>();
		for(String seatSection : seatSectionList) {
			ConcertSeatMapVO csmVO = new ConcertSeatMapVO();
			csmVO.setConcertNo(concertNo);
			csmVO.setSeatSection(seatSection);
			if(seatSection.equals("A")||seatSection.equals("C")) {
				csmVO.setSeatGradeCode("SGC003");
				csmVO.setSeatPrice(140000);
			}else if(seatSection.equals("B")) {
				csmVO.setSeatGradeCode("SGC002");
				csmVO.setSeatPrice(160000);
			}else if(seatSection.equals("D")||seatSection.equals("E")) {
				csmVO.setSeatGradeCode("SGC004");
				csmVO.setSeatPrice(110000);
			}
			csmList.add(csmVO);
		}
		int status = 0;
		try (SqlSession sqlSession = sqlSessionFactory.openSession(ExecutorType.BATCH)) {
			ISeatMapper mapper = sqlSession.getMapper(ISeatMapper.class);
			for(ConcertSeatMapVO csmVO : csmList) {
				mapper.insertConcertSeatMap(csmVO);
				status++;

				if(status % batchSize == 0) {
					sqlSession.flushStatements();
				}
			}
			sqlSession.flushStatements();

			status = 0;

			List<TicketVO> ticketList = new ArrayList<>();
			// 티켓 정보 생성
			List<SeatVO> seatList = seatMapper.getSeatInfo(concertHallNo);

			for(SeatVO seat : seatList) {
				TicketVO ticketVO = new TicketVO();
				ticketVO.setConcertHallNo(concertHallNo);
				ticketVO.setConcertNo(concertNo);
				ticketVO.setSeatNo(seat.getSeatNo());
				ticketVO.setGoodsNo(goodsNo);
				ticketList.add(ticketVO);
			}

			for(TicketVO ticketVO : ticketList) {
				mapper.insertTikcet(ticketVO);
				status++;

				if(status % batchSize == 0) {
					sqlSession.flushStatements();
				}
			}
			sqlSession.flushStatements();
			return status > 0 ? ServiceResult.OK : ServiceResult.FAILED ;
		} catch (Exception e) {
			throw new RuntimeException("콘서트 좌석 맵 배치 삽입 중 오류 발생",e);
		}

	}

	/**
	 * 공통 코드 테이블에서 좌석 등급 정보 가져오기
	 */
	@Override
	public List<CommonCodeDetailVO> selectGradeList() {
		return seatMapper.selectGradeList();
	}

	/**
	 * concert_seat_map 좌석등급및 가격정보 수정 및
	 * ticket 가격 정보 수정
	 * @param csmVO
	 * @return
	 */
	@Transactional
	@Override
	public ServiceResult updateConcertSeatMap(ConcertSeatMapVO csmVO) {
		ServiceResult result = null;
		// concert_seat_map 수정
		int status = seatMapper.updateConcertSeatMap(csmVO);
		if(status > 0) {
			// ticket 가격 정보 수정
			status = seatMapper.updateTicket(csmVO);
			if(status > 0) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAILED;
			}
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
}
