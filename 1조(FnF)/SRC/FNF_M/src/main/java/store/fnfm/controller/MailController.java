package store.fnfm.controller;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import store.fnfm.service.SellerService;
import store.fnfm.service.UserService;
import store.fnfm.vo.SellerVO;
import store.fnfm.vo.UserVO;
 
@Controller
public class MailController {

  @Autowired
  private JavaMailSender mailSender;

  @Autowired
  SellerService sellerService;
  
  @Autowired
  UserService userService;

  // mailForm
  @RequestMapping(value="/admin/mail/{user_id}",method = RequestMethod.GET)
  @ResponseBody
  public ModelAndView mailForm(@PathVariable String user_id) {
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("user_id", user_id);
	  this.sellerService.mail(map);
	  List<SellerVO> list = (List<SellerVO>)map.get("result");
	  SellerVO seller = list.get(0);
	  ModelAndView mav = new ModelAndView();
	  mav.addObject("data", seller);
	  mav.setViewName("mailForm");
	  return mav;

  }
  
  @RequestMapping(value="/admin/mailappr/{user_id}",method = RequestMethod.GET)
  @ResponseBody
  public ModelAndView mailForm2(@PathVariable String user_id) {
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("user_id", user_id);
	  this.sellerService.mail(map);
	  List<SellerVO> list = (List<SellerVO>)map.get("result");
	  SellerVO seller = list.get(0);
	  ModelAndView mav = new ModelAndView();
	  mav.addObject("data", seller);
	  mav.setViewName("mailFormAppr");
	  return mav;

  }

  @RequestMapping(value="/admin/maila/{user_id}",method = RequestMethod.GET)
  @ResponseBody
  public ModelAndView mailFormA(@PathVariable String user_id) {
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("user_id", user_id);
	  this.sellerService.mail(map);
	  List<SellerVO> list = (List<SellerVO>)map.get("result");
	  SellerVO seller = list.get(0);
	  ModelAndView mav = new ModelAndView();
	  mav.addObject("data", seller);
	  mav.setViewName("mailFormA");
	  return mav;

  }
  
  @RequestMapping(value="/admin/mailu/{user_id}",method = RequestMethod.GET)
  @ResponseBody
  public ModelAndView mailFormU(@PathVariable String user_id) {
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("user_id", user_id);
	  this.userService.mail(map);
	  List<UserVO> list = (List<UserVO>)map.get("result");
	  UserVO user = list.get(0);
	  ModelAndView mav = new ModelAndView();
	  mav.addObject("data", user);
	  mav.setViewName("mailFormU");
	  return mav;

  }


  // mailSending 코드
  @RequestMapping(value = "/admin/mailSending", method = RequestMethod.POST)
  public String mailSending(HttpServletRequest request) {

    String setfrom = "fnfm1229@gmail.com";         
    String tomail  = request.getParameter("tomail");     // 받는 사람 이메일
    String title   = request.getParameter("title");      // 제목
    String content = request.getParameter("content");    // 내용

    try {
      MimeMessage message = mailSender.createMimeMessage();
      MimeMessageHelper messageHelper 
                        = new MimeMessageHelper(message, true, "UTF-8");
 
      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
      messageHelper.setTo(tomail);     // 받는사람 이메일
      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
      messageHelper.setText(content);  // 메일 내용


      mailSender.send(message);
    } catch(Exception e){
      System.out.println(e);
    }

    return "adminSeller";
  }
  
  @RequestMapping(value = "/admin/mailSendingU", method = RequestMethod.POST)
  public String mailSendingU(HttpServletRequest request) {

    String setfrom = "fnfm1229@gmail.com";         
    String tomail  = request.getParameter("tomail");     // 받는 사람 이메일
    String title   = request.getParameter("title");      // 제목
    String content = request.getParameter("content");    // 내용

    try {
      MimeMessage message = mailSender.createMimeMessage();
      MimeMessageHelper messageHelper 
                        = new MimeMessageHelper(message, true, "UTF-8");
 
      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
      messageHelper.setTo(tomail);     // 받는사람 이메일
      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
      messageHelper.setText(content);  // 메일 내용


      mailSender.send(message);
    } catch(Exception e){
      System.out.println(e);
    }

    return "adminCustomer";
  }
} 