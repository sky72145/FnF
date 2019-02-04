package store.fnfm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import store.fnfm.service.CartService;
import store.fnfm.service.OrderService;
import store.fnfm.vo.CartVO;
import store.fnfm.vo.OrderVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class OrderController {
	@Autowired
	CartService cartService;
	@Autowired
	OrderService orderService;
	String orderid;
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	/*배송지 정보값가져오기*/
	@RequestMapping(value = "/order", method = RequestMethod.GET)
	public ModelAndView orders(HttpSession session, ModelAndView mav, Model model) {
		/*pcode 값가져오기*/
		Map<String, Object> map = new HashMap<String, Object>();
		String user_id=(String)session.getAttribute("user_id");
		map.put("user_id", user_id);
		if(user_id == null) {
			mav.setViewName("error");
			return mav;
		}else {
		this.orderService.pcode_get(map);
		List<OrderVO> list = (List<OrderVO>)map.get("result");
		/*배송지 user정보가져오기*/
		mav.addObject("user",orderService.userinfo(user_id));
		model.addAttribute("plist", list);
		mav.setViewName("order");
		return mav;
		}
	}
	/*order */
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	@ResponseBody
	public Map order(HttpSession session, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		String user_id=(String)session.getAttribute("user_id");
		map.put("user_id",user_id);
		this.cartService.read(map);
		List<CartVO> list = (List<CartVO>)map.get("result");
		Map<String, Object> data = new HashMap<String, Object>();
		int productSum = cartService.productSum(user_id);
		int fee = productSum >= 50000 ? 0 : 2500;
		int mile = orderService.mile_remain(user_id);
		data.put("code", Boolean.TRUE);
		data.put("productSum", productSum);
		data.put("fee", fee);
		data.put("mile_remain", mile);
		data.put("allSum", productSum+fee);
		data.put("data", list);
		return data;
	}
	
	@RequestMapping(value = "/order_ing", method = RequestMethod.POST)
	public String result(HttpSession session,@RequestParam("pay") String pay, @RequestParam("receiver_name") String receiver_name,
			@RequestParam("zipcode") int zipcode, @RequestParam("address1") String address1, @RequestParam("address2") String address2,
			@RequestParam("phone") String phone, @RequestParam("email") String email, @RequestParam("del_message") String del_message,
			@RequestParam("mile_used") int mile_used,@RequestParam("pcode") String pcode[]){
		String user_id=(String)session.getAttribute("user_id");
		Map<String, Object> map = new HashMap<String, Object>();
		/*배송비를제외한 물품합계*/
		int productSum = cartService.productSum(user_id);
		/*배송비*/
		int fee = productSum >= 50000 ? 0 : 2500;
		/*적립마일리지*/
		int mile_give = (int)(productSum*0.01);
		
		/*주문번호, 결제일자 계산*/
		SimpleDateFormat date = new SimpleDateFormat ("yyyyMMddHHmmss");
		SimpleDateFormat date2 = new SimpleDateFormat ("yyyy-MM-dd-HH:mm:ss");
		Date time = new Date();
		String idx = date.format(time);
		String pdate = date2.format(time);
		String orderid = idx;
		String pay_date = pdate;
		int totalprice = productSum + fee - mile_used;
		String status = null;
		if(pay.equals("무통장")) {
			status="입금대기";
		}else{
			status="결제완료";
		}
		map.put("idx", orderid); map.put("user_id", user_id);
		map.put("receiver_name", receiver_name); 
		map.put("pay", pay);
		map.put("pay_date", pay_date); map.put("zipcode", zipcode);
		map.put("address1", address1); map.put("address2", address2);
		map.put("mile_give", mile_give); map.put("mile_used", mile_used);
		map.put("del_message", del_message); map.put("phone", phone);
		map.put("del_price", fee); map.put("email", email);
		map.put("totalprice", totalprice);
		map.put("status", status);
		this.orderService.insert(map);
		System.out.println(map);
		/*마일리지 추가*/
		Map<String, Object> add_mile = new HashMap<String, Object>();
		add_mile.put("user_id", user_id);
		add_mile.put("mile_give", mile_give);
		this.orderService.addmile(user_id, mile_give);
		/*사용마일리지*/
		Map<String, Object> minus_mile = new HashMap<String, Object>();
		minus_mile.put("user_id", user_id);
		minus_mile.put("mile_used", mile_used);
		this.orderService.minusmile(user_id, mile_used);
		/*orderdetial로 insert*/
		this.orderService.insertdetial(orderid);
		session.setAttribute("order_id", orderid);
		
		/*product_count 조절*/
		for(int i=0; i<pcode.length; i++) {
		Map<String, Object> pcount = new HashMap<String, Object>();
		pcount.put("idx",orderid);
		pcount.put("pcode", pcode[i]);
		this.orderService.product_update(pcount);
	}
		return "redirect:/order_f";
	}
		
	@RequestMapping(value = "/order_f", method = RequestMethod.GET)
	public ModelAndView order_finsh(HttpSession session,ModelAndView mav, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		String user_id=(String)session.getAttribute("user_id");
		String order_id= (String) session.getAttribute("order_id");
		map.put("user_id",user_id);
		this.cartService.read(map);
		
		List<CartVO> list = (List<CartVO>)map.get("result");
		int productSum = cartService.productSum(user_id);
		int fee = productSum >= 50000 ? 0 : 2500;
		
		map.put("count", list.size());
		map.put("productSum", productSum);
		map.put("fee", fee);
		map.put("allSum", productSum+fee);
		model.addAttribute("cartList", list);
		mav.addObject("vo",orderService.result(order_id));
		mav.addObject("map",map);
		mav.setViewName("order_f");
		this.cartService.allDelete(user_id);
		return mav;
		
	}
	
	@RequestMapping(value = "/user_address", method = RequestMethod.GET)
	public String useraddress(HttpSession session, ModelAndView mav,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		String user_id=(String)session.getAttribute("user_id");
		map.put("user_id",user_id);
		this.orderService.useraddress(map);
		List<OrderVO> list = (List<OrderVO>)map.get("result");
		model.addAttribute("addr", list);
		return "useraddress";
		
	}
}

