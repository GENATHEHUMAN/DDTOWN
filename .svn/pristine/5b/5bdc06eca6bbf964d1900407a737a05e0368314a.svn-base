package kr.or.ddit.ddtown.mapper.common;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.common.CommonCodeDetailVO;
import kr.or.ddit.vo.common.CommonCodeGroupVO;

@Mapper
public interface ICommonCodeMapper {
	
	/**
	 * 사용중인 상세코드 목록 조회
	 * @param commCodeGrpNo	공통코드 그룹번호
	 * @return CommonCodeDetailVO 리스트
	 */
	public List<CommonCodeDetailVO> selectCommonCodeDetails(String commCodeGrpNo);
	
	/**
	 * 상세코드 목록 조회 ( 전부 )
	 * @param commCodeGrpNo	공통코드 그룹번호
	 * @return	CommonCodeDetailVO 리스트
	 */
	public List<CommonCodeDetailVO> selectAllCommonCodeDetails(String commCodeGrpNo);
	
	/**
	 * 특정 공통 상세코드번호로 상세정보 조회
	 * @param commCodeDetNo	공통 상세코드 번호
	 * @return	CommonCodeDetailVO 객체
	 */
	public CommonCodeDetailVO selectOneCommonCodeDetail(String commCodeDetNo);
	
	/**
	 * 모든 공통 코드그룹 목록 조회
	 * @return CommonCodeGroupVO 리스트
	 */
	public List<CommonCodeGroupVO> selectAllCommonCodeGroups();
}
