package kr.or.ddit.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BaseVO {
	private int page = 1;
	private String searchType;
	private String searchWord;
	
	
	public BaseVO(int page, String searchType, String searchWord) {
		super();
		this.page = page;
		this.searchType = searchType;
		this.searchWord = searchWord;
	}
}
