package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.NoticeDAO;
import store.fnfm.vo.NoticeVO;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	NoticeDAO noticeDao;
	
	@Override
	public void insertBoard(NoticeVO noticeVo) {
		//System.out.println(faqVo);
		this.noticeDao.create(noticeVo);
	}

	@Override
	public void select(Map map) {
		this.noticeDao.readAll(map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.noticeDao.getTotalCount(map);
	}

	@Override
	public void selectBoard(Map map) {
		this.noticeDao.read(map);
	}

	@Override
	public void updateBoard(NoticeVO noticeVo) {
		this.noticeDao.update(noticeVo);
	}

	@Override
	public void deleteBoard(int idx) {
		this.noticeDao.delete(idx);
	}

	@Override
	public void readnum(int idx) {
		this.noticeDao.readnumCount(idx);
	}

	@Override
	public void search(Map map) {
		this.noticeDao.searchAll(map);
	}

	@Override
	public void searchCount(Map map) {
		this.noticeDao.searchCount(map);
	}


}
