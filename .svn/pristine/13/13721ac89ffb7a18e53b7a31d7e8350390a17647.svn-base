package kr.or.ddit.vo.member.membership;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonInclude;

import kr.or.ddit.vo.common.CommonCodeDetailVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MembershipSubscriptionsVO {
	
	@JsonInclude(JsonInclude.Include.NON_NULL)
	private LocalDateTime mbspSubModDate;	// 구독/갱신 일시
	private String mbspSid;					// 정기결제 고유 번호
	private String mbspCid;					// 가맹점 번호
	private Integer mbspSubNo;				// 구독 번호
	private Integer mbspNo;					// 멤버십 번호
	private String memUsername;				// 회원 아이디
	private Integer orderDetNo;				// 주문 상세 번호
	private String mbspSubStatCode;			// 구독 상태 코드
	
	@JsonInclude(JsonInclude.Include.NON_NULL)
	private LocalDateTime mbspSubStartDate;	// 멤버십 시작 일시
	@JsonInclude(JsonInclude.Include.NON_NULL)
	private LocalDateTime mbspSubEndDate;	// 멤버십 종료 일시
	
	private String mbspNm;					// 멤버십명
	private String artGroupNo;				// 아티스트 그룹번호
	private String artGroupNm;				// 아티스트 그룹명
	private String empUsername;				// 직원명
	private String mbspPrice;				// 멤버십 가격
	private String profileImg;				// 아티스트 그룹 프로필 이미지
		
	private MembershipDescriptionVO membershipDesc;		// 멤버십 상세정보
	private CommonCodeDetailVO codeDetailVO;			// 멤버십 구독 상태코드 상세
	
	private Map<Object, Object> subMembership;		// 이전 멤버십 목록
	
	private Integer membershipGoodsNo;		// 멤버십 상품 번호
	
	// -- 통계 데이터를 위한 필드 --
	// 월별 신규 가입자 수 통계용
	private String month;					// 월
	private Integer count;					// 가입자 수
	
	// 가장 많이 결제한 사용자 통계용
	private Long totalAmount;				// 총 결제 금액
	private String memNicknm;				// 사용자 닉네임
	
	public Date getSubStartDate() {
		if(this.mbspSubStartDate == null) return null;
		return Date.from(this.mbspSubStartDate.atZone(ZoneId.systemDefault()).toInstant());
	}
	
	public Date getSubModDate() {
		if(this.mbspSubModDate == null) return null;
		return Date.from(this.mbspSubModDate.atZone(ZoneId.systemDefault()).toInstant());
	}
	
	public Date getSubEndDate() {
		if(this.mbspSubEndDate == null) return null;
		return Date.from(this.mbspSubEndDate.atZone(ZoneId.systemDefault()).toInstant());
	}
	
	public long getdDay() {
		if(this.mbspSubStartDate == null) {
			return 0;
		}
		
		// 오늘 날짜
		LocalDate today = LocalDate.now();
		
		LocalDate startDate = this.mbspSubStartDate.toLocalDate();
		
		// 두 날짜 사이의 일수 차이, 시작일 포함
		return ChronoUnit.DAYS.between(startDate, today) + 1;
	}
}


