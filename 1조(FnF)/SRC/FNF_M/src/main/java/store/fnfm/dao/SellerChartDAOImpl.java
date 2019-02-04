package store.fnfm.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("sellerChartDAO")
public class SellerChartDAOImpl implements SellerChartDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void productChart(Map map) {
		this.sqlSession.selectList("SellerChart.ChartSelectOne",map);
	}

	@Override
	public void MCount(Map map) {
		this.sqlSession.selectOne("SellerChart.paycount",map);//결제 건 수
	}

	@Override
	public void KCount(Map map) {
		this.sqlSession.selectOne("SellerChart.kcount",map);
	}

	@Override
	public void productPrice(Map map) {
		this.sqlSession.selectList("SellerChart.PriceChartSelectOne",map);
	}

	@Override
	public void MonthSales(Map map) {
		this.sqlSession.selectList("SellerChart.MonthSalesChart",map);
	}

}
