package kr.or.ddit.vo.inquiry;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class InqBaseVO {

	private int page = 1;
	private String searchType;
	private String searchWord;
	private String searchStatType;
	
	public InqBaseVO(int page, String searchType, String searchWord, String searchStatType) {
		super();
		this.page = page;
		this.searchType = searchType;
		this.searchWord = searchWord;
		this.searchStatType = searchStatType;
	}
	
}
