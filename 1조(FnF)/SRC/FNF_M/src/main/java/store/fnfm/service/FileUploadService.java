package store.fnfm.service;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Calendar;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("fileUploadService")
public class FileUploadService {
	private final String uploadPath = "/SpringHome/fnfm7/src/main/webapp/static/img/fileupload";
	//Windows의 경우에는 JVM이 자동으로 Eclipse의 workspace의 drive를 인식한다.
	public String restore(MultipartFile multipartFile, HttpServletRequest requ) {
		//this.uploadPath = uploadPath;
		String savedFileName = null;
		
		 /** 웹어플리케이션상의 절대경로 **/
	      ServletContext context = requ.getSession().getServletContext();
	      /** 파일 업로드의 절대경로 **/
	      String realFolder = context.getRealPath("/");
	      /** 파일 업로드할 폴더경로 **/
	      String uploadPath = realFolder +"static/img";
	      // File.separator == /
	      
	      System.out.println("웹어플리케이션상의 절대경로 = "+context);
	      System.out.println("realFolder = "+realFolder);
	      System.out.println("uploadPath = "+uploadPath);
		try {
			String originalName = multipartFile.getOriginalFilename();
			String extName = originalName.substring(originalName.lastIndexOf("."),originalName.length());
			long fileSize = multipartFile.getSize();
			savedFileName = this.generateSavedName(extName);
			
			System.out.println("originalName = " + originalName);
			System.out.println("extName = " + extName);
			System.out.println("fileSize = " + fileSize);
			System.out.println("savedFileName = " + savedFileName);
			
			byte [] buffers = null;
			File file = null;
			try{
				buffers = multipartFile.getBytes();
				file = new File(uploadPath + "/" + savedFileName);
				System.out.println(">>>>>>>>>>>>>>>>>>>>"+file);
				FileOutputStream fos = new FileOutputStream(file);
				fos.write(buffers);
				fos.close();
			}catch(Exception e) {
				System.out.println("오류발생 : " + e);
			}
		}catch(Exception ex) {
			System.out.println(ex);
		}	
		return savedFileName;
	}
	
	
	private String generateSavedName(String extName) {
		String newName = "";
		Calendar now = Calendar.getInstance();
		newName += now.get(Calendar.YEAR);
		newName += now.get(Calendar.MONTH) + 1;
		newName += now.get(Calendar.DATE);
		newName += now.get(Calendar.HOUR_OF_DAY);
		newName += now.get(Calendar.MINUTE);
		newName += now.get(Calendar.SECOND);
		newName += now.get(Calendar.MILLISECOND);
		newName += extName;
		return newName;
	}
}
