package kr.or.ddit.ddtown.mapper.emp.artist;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.artist.AlbumVO;

@Mapper
public interface IAlbumMapper {

	public List<AlbumVO> getAllAlbums();

	public List<AlbumVO> getAlbumsWithoutGroup();

}
