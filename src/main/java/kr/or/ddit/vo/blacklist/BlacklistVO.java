package kr.or.ddit.vo.blacklist;

import java.time.LocalDate;

import lombok.Data;

@Data
public class BlacklistVO {
	private int banNo;					//차단 번호
	private String memUsername;		//차단 대상 회원
	private String empUsername;		//차단 담당자
	private String banReasonCode;		//차단 사유 코드
	private String banReasonDetail;	//상세 차단 사유
	private LocalDate banStartDate;		//차단 시작 일시		(날짜비교를 위해 banStartDate의 타입을 LocalDate로 변경)
	private LocalDate banEndDate;		//차단 해제 일시
	private LocalDate banRegDate;		//차단 기록 생성일시
	private String banActYn;			//차단 활성 여부
	
	private String peoFirstNm;	//이름
	private String peoLastNm;	//성
	
	
}
