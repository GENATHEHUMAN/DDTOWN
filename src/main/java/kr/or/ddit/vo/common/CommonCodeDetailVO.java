package kr.or.ddit.vo.common;

import lombok.Data;

@Data
public class CommonCodeDetailVO {

	private String commCodeDetNo;		// 공통 상세번호
	private String commCodeGrpNo;		// 공통 코드그룹번호
	private String commCodeDetNm;		// 공통 상세코드명
	private String useYn;				// 사용여부
	private String description;			// 공통 상세옵션명
	
	private CommonCodeGroupVO commonCodegroup;		// 해당 그룹 정보
	
	private int codeCnt;				// 해당 코드를 가지고 있는 정보 수
}
