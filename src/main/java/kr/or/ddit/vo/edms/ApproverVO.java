package kr.or.ddit.vo.edms;

import java.util.Date;

import lombok.Data;

@Data
public class ApproverVO {
	private int apvNo;
	private String empUsername;
	private int edmsNo;
	private String apvStatCode;
	private String apvRejectReason;
	private Date apvResDate;
	private int apvSec;
	private String empName;
	private String empPositionCode;
	private String empPositionNm;
	private String empDepartNm;
}
