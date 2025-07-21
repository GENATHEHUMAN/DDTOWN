package kr.or.ddit.ddtown.mapper.corporate;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.artist.ArtistGroupVO;

@Mapper
public interface ICorporateMapper {

	List<ArtistGroupVO> getGroupList();

}
