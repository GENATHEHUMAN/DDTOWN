package kr.or.ddit.vo.concert;

import lombok.Data;

@Data
public class ConcertHallVO {

	private int concertHallNo;		// 콘서트 장 번호
	private String concertAddress;	// 콘서트 장 주소
	private String concertHallNm;	// 콘서트 장 이름
	private int concertCapacity;	// 콘서트 수용인원
}
