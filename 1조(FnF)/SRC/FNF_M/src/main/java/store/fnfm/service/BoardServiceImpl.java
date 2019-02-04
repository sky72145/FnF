package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.BoardDao;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDao boardDao;
	
	@Override
	public void select(Map map) {
		this.boardDao.readAll(map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.boardDao.getTotalCount(map);
	}

	@Override
	public void deleteFaq(int idx) {
		this.boardDao.deleteFaq(idx);
	}

	@Override
	public void deleteNotice(int idx) {
		this.boardDao.deleteNotice(idx);
	}

	@Override
	public void deleteQaa(int idx) {
		this.boardDao.deleteQaa(idx);
	}

	@Override
	public void search(Map map) {
		this.boardDao.search(map);
	}

	@Override
	public void getSearchTotalCount(Map map) {
		this.boardDao.getSearchTotalCount(map);
	}

}
