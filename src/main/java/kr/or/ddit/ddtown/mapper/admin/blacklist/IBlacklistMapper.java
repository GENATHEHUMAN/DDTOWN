package kr.or.ddit.ddtown.mapper.admin.blacklist;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.blacklist.BlacklistVO;

@Mapper
public interface IBlacklistMapper {

	public List<BlacklistVO> blackList(PaginationInfoVO<BlacklistVO> pagingVO);
	public int selectBlacklistCount(PaginationInfoVO<BlacklistVO> pagingVO);
	
	public BlacklistVO blackDetail(int banNo);
	
	public int checkMemberId(String memUsername);
	public int checkIdBlacklist(String memUsername);
	public int blackSignup(BlacklistVO blacklistVO) throws Exception;
	public int memListStatUpdate(BlacklistVO blacklistVO);
	
	public int blackUpdate(BlacklistVO blacklistVO);
	
	public int blackDelete(BlacklistVO blacklistVO);
	public int blackDelete2(String memUsername);
	
	public int blacklistCnt();
	public List<Map<String, Object>> blackReasonCnts();
	public int totalBlakcCount(Map<String, Object> totalCountParams);		

	public List<String> getAutoReleaseTargetUsernames(LocalDate today);
	public int uploadBlackScheduler(LocalDate today);
	public int memberStateUpdate(@Param("usernames")List<String> targetUsernames);

}
