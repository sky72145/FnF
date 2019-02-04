package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.SellerChartDAO;

@Service("sellerChartService")
public class SellerChartServiceImpl implements SellerChartService {
	@Autowired
	SellerChartDAO sellerChartDAO;
	
	@Override
	public void productChart(Map map) {
		this.sellerChartDAO.productChart(map);//상품별 판매수
	}

	@Override
	public void MCount(Map map) {
		this.sellerChartDAO.MCount(map);//결제 건 수
	}

	@Override
	public void KCount(Map map) {
		this.sellerChartDAO.KCount(map);
	}

	@Override
	public void productPrice(Map map) {
		this.sellerChartDAO.productPrice(map);//상품별 매출액
	}

	@Override
	public void MonthSales(Map map) {
		this.sellerChartDAO.MonthSales(map);
	}

}
