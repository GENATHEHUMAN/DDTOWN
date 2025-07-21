package kr.or.ddit.ddtown.service.emp.artist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.ddtown.mapper.emp.artist.IAlbumMapper;
import kr.or.ddit.vo.artist.AlbumVO;

@Service
public class AlbumServiceImpl implements IAlbumService{
	
	@Autowired
	private IAlbumMapper albumMapper;
		
	@Override
	public List<AlbumVO> getAllAlbums() {
		return albumMapper.getAllAlbums();
	}

	@Override
	public List<AlbumVO> getAlbumsWithoutGroup() {
		return albumMapper.getAlbumsWithoutGroup();
	}

}
