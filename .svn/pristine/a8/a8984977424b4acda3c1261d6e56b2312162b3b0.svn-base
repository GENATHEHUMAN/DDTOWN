package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class PaginationInfoVO<T> {

	private int totalRecord;		// 총 게시글 수
	private int totalPage;			// 총 페이지 수
	private int currentPage;		// 현재 페이지
	private int screenSize = 10;	// 페이지 당 게시글 수
	private int blockSize = 5;		// 페이지 블록 수
	private int startRow;			// 시작 row
	private int endRow;				// 끝 row
	private int startPage;			// 시작 페이지
	private int endPage;			// 끝 페이지
	private List<T> dataList;		// 결과를 넣을 데이터 리스트
	private String searchType;		// 검색 타입
	private String searchWord;		// 검색 단어
	
	public PaginationInfoVO() {}

	public PaginationInfoVO(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;			// 현재 페이지
		this.endRow = currentPage * screenSize;	// 끝 row
		this.startRow = endRow - (screenSize - 1);
		// 마지막 페이지
		this.endPage = (currentPage + (blockSize - 1)) / blockSize * blockSize;
		// 시작 페이지
		this.startPage = endPage - (blockSize - 1);
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		totalRecord = (int) Math.ceil(totalRecord / (double) screenSize);
	}
	
	public String getPagingHTMl() {
		StringBuffer html = new StringBuffer();
		html.append("<ul class='pagination pagination-sm m0 float-right'>");
		
		// 이전 1 2 3 4 5 다음
		// css양식 정해지면 양식쪽에 이름정해서 삽입
		if(startPage > 1) {
			html.append("<li class='css양식1'><a href='' class='css양식2' "
					+ "data-page='" + (startPage - blockSize) + "'>이전</a></li>");
		}
		
		for(int i = startPage; i <= (endPage < totalPage ? endPage:totalPage); i++) {
			if(i == currentPage) {
				html.append("<li class='css양식3'><span class='css양식2'>"
						+ i + "</span></li>");
			} else {
				html.append("<li class='css양식1'><a href='' class='css양식2' "
						+ "data-page='" + i + "'>" + i + "</a></li>");
			}
		}
		
		if(endPage < totalPage) {
			html.append("<li class='css양식1'><a href='' class='css양식2'"
					+ "data-page='" + (endPage + 1) + "'>다음</a></li>");
		}
		
		html.append("</ul>");
		return html.toString();
	}
	
	
}
