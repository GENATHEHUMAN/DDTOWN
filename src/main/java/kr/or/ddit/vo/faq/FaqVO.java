package kr.or.ddit.vo.faq;

import java.util.Date;

import kr.or.ddit.vo.BaseVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@NoArgsConstructor
public class FaqVO extends BaseVO{

	private int faqNo;
	private String empUsername;
	private String faqCategory;
	private String faqTitle;
	private String faqAnswer;
	private Date faqRegDate;
	private Date faqModDate;
	private int faqTotalRow;
	
	private int totalRecord;
	
	private String description;
	
	private FaqVO(int page, String searchType, String searchWord) {
		super(page, searchType, searchWord);
	}
	
}
