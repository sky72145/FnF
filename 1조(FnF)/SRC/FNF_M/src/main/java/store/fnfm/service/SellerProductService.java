package store.fnfm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import store.fnfm.vo.SellerProductVO;


public interface SellerProductService {
	int pcodeCheck(String pcode);
	int create(SellerProductVO productVO);//productRegister
	void getTotalCount(Map map);//페이징
	void insertProduct(SellerProductVO productVO);//productInsert
	void selectProduct(Map map);//productDetail
	void select(Map map);//productList
	int updateProduct(SellerProductVO	 productVO);//productUpdate
	void deleteProduct(int idx);
	String restore(MultipartFile file,HttpServletRequest request);//fileUpload
	List<SellerProductVO> list(SellerProductVO productVO);//검색data list 받아오기
	void selectSearch(Map map);//검색된 productList
	void getSearchTotalCount(Map map);//검색결과페이징
}
