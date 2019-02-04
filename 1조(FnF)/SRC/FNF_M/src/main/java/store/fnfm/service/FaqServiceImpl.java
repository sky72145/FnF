package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.FaqDAO;
import store.fnfm.vo.FaqVO;

@Service("faqService")
public class FaqServiceImpl implements FaqService {
	@Autowired
	FaqDAO faqDao;
	
	@Override
	public void insertBoard(FaqVO faqVo) {
		//System.out.println(faqVo);
		this.faqDao.create(faqVo);
	}

	@Override
	public void select(Map map) {
		this.faqDao.readAll(map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.faqDao.getTotalCount(map);
	}

	@Override
	public void selectBoard(Map map) {
		this.faqDao.read(map);
	}

	@Override
	public void updateBoard(FaqVO faqVo) {
		this.faqDao.update(faqVo);
	}

	@Override
	public void deleteBoard(int idx) {
		this.faqDao.delete(idx);
	}

	@Override
	public void readnum(int idx) {
		this.faqDao.readnumCount(idx);
	}

	@Override
	public void search(Map map) {
		this.faqDao.searchAll(map);
	}

	@Override
	public void searchCount(Map map) {
		this.faqDao.searchCount(map);
	}
}
