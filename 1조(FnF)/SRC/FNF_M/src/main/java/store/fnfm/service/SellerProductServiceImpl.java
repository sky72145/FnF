package store.fnfm.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import store.fnfm.dao.SellerProductDAO;
import store.fnfm.vo.SellerProductVO;

@Service("sellerProductService")
public class SellerProductServiceImpl implements SellerProductService {
	@Autowired
	SellerProductDAO sellerProductDAO;
	
	@Override
	public int pcodeCheck(String pcode) {
		return this.sellerProductDAO.pcodeCheck(pcode);
	}
	@Override
	public int create(SellerProductVO productVO) {
		return this.sellerProductDAO.create(productVO);
	}
	@Override
	public void insertProduct(SellerProductVO productVO) {
		this.sellerProductDAO.insertProduct(productVO);
	}

	@Override
	public void selectProduct(Map map) {
		this.sellerProductDAO.selectProduct(map);
	}

	@Override
	public void select(Map map) {
		this.sellerProductDAO.select(map);
	}

	@Override
	public int updateProduct(SellerProductVO productVO) {
		return this.sellerProductDAO.updateProduct(productVO);
	}
	@Override
	public void deleteProduct(int idx) {
		this.sellerProductDAO.deleteProduct(idx);
	}
	
	@Override
	public void getTotalCount(Map map) {
		this.sellerProductDAO.getTotalCount(map);
	}
	
	/**####################################################**/
	/**파일업로드**/
	/**####################################################**/
	private final String PATH = "/SpringHome/FNF_kakao/src/main/webapp/static/img";	//저장할 폴더
	//Windows의 경우에는 JVM이 자동으로 workspace의 drive를 인식한다.
	public String restore(MultipartFile multipartFile,HttpServletRequest request) {//filename에 넣어야하니 return String;
		
		/** 웹어플리케이션상의 절대경로 **/
		ServletContext context = request.getSession().getServletContext();
		/** 파일 업로드의 절대경로 **/
		String realFolder = context.getRealPath("/");
		/** 파일 업로드할 폴더경로 **/
		String uploadPath = realFolder +"static/img";
		// File.separator == /
		
		System.out.println("웹어플리케이션상의 절대경로 = "+context);
		System.out.println("realFolder = "+realFolder);
		System.out.println("uploadPath = "+uploadPath);
		
		String savedFileName=null;
		try {
			String originalName = multipartFile.getOriginalFilename();
			String extName = originalName.substring(originalName.lastIndexOf("."),  originalName.length());
			long fileSize = multipartFile.getSize();
			savedFileName = this.generateSavedName(extName);
			/*
			System.out.println("originalName = " + originalName);//originalName = 감자.jpg
			System.out.println("extName = " + extName);//extName = .jpg
			System.out.println("fileSize = " + fileSize);//fileSize = 16670
			System.out.println("저장될 파일 이름 : "+ savedFileName);//2018122523163260.jpg
			 */
			
			/** 파일 업로드**/
			byte[] buffers = multipartFile.getBytes();
			File file = new File(uploadPath + "/" + savedFileName);// C:/~/20181220112317266.jpg
			System.out.println(file);
			FileOutputStream fos = new FileOutputStream(file);
			fos.write(buffers);
			fos.close();
			/** 파일 업로드**/
			
		}catch(Exception ex) {
			System.out.println(ex);
		}
		return savedFileName;
	}

	private String generateSavedName(String extName) {
		String newName= "";
		Calendar now = Calendar.getInstance();
		newName += now.get(Calendar.YEAR);//yyyy
		newName += now.get(Calendar.MONTH)+1;//mm
		newName += now.get(Calendar.DATE);//dd
		newName += now.get(Calendar.HOUR_OF_DAY);//hh
		newName += now.get(Calendar.MINUTE);//MM
		newName += now.get(Calendar.SECOND);//ss
		newName += now.get(Calendar.MILLISECOND);//ms
		newName += extName;//확장자
		return newName;
	}
	/**####################################################**/
	/**파일업로드**/
	/**####################################################**/
	
	@Override
	public List<SellerProductVO> list(SellerProductVO productVO) {
		return this.sellerProductDAO.list(productVO);//판매자상품검색된 list 받아오기
	}
	@Override
	public void getSearchTotalCount(Map map) {
		this.sellerProductDAO.getSearchTotalCount(map);
	}
	@Override
	public void selectSearch(Map map) {
		this.sellerProductDAO.selectSearch(map);//판매자상품검색된 list 받아오기
	}


	

}//class
