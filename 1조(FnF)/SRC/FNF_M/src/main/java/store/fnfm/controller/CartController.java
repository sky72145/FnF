package store.fnfm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import store.fnfm.service.CartService;
import store.fnfm.vo.CartVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class CartController {
	@Autowired
	CartService cartService;
	
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	
	/*장바구니 비우기 */
	@RequestMapping(value = "/del/{user_id}", method = RequestMethod.GET)
	public String cart_allDel(@PathVariable String user_id) {
		this.cartService.allDelete(user_id);
		return "redirect:/cart";
		
	}
	
	/*장바구니 추가가존 상품 확인후 업데이트*/
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String cart_insert(@RequestParam("pcode") String pcode,@RequestParam("product_count") int product_count, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		
		Map<String, Object> map = new HashMap<String, Object>();
		int count = cartService.updatecheck(user_id,pcode);
	/*	기존상품이 있는지여부 확인*/
		if(count == 0) {
			map.put("user_id",user_id);
			map.put("pcode",pcode);
			map.put("product_count",product_count);
			this.cartService.insert(map);
		}else {
			map.put("user_id",user_id);
			map.put("pcode",pcode);
			map.put("product_count",product_count);
			this.cartService.update(map);
		}
		return "redirect:/cart";
	}
	
	/*세션으로 userid받아서 카트리스트 출력*/
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public ModelAndView cart_id(HttpSession session,Model model, ModelAndView mav) {
		Map<String, Object> map = new HashMap<String, Object>();
		String user_id=(String)session.getAttribute("user_id");
		map.put("user_id",user_id);
		
		this.cartService.read(map);
		List<CartVO> list = (List<CartVO>)map.get("result");
		int productSum = cartService.productSum(user_id);
		/*배송비*/
		int fee = productSum >= 50000 ? 0 : 2500;
		map.put("count", list.size());
		map.put("productSum", productSum);
		map.put("fee", fee);
		map.put("allSum", productSum+fee);
		model.addAttribute("cartList", list);
		mav.setViewName("cart");
		mav.addObject("map",map);
		return mav;
		
	}
	
	/*장바구니 수량 수정*/
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modify(@RequestParam("pcode") String[] pcode,@RequestParam("product_count") int[] product_count, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		for(int i=0; i<pcode.length; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("user_id", user_id);
			map.put("product_count",product_count[i]);
			map.put("pcode", pcode[i]);
			cartService.cartModify(map);
		}
		return "redirect:/cart";
	}
	/*개별 카트 삭제*/
	@RequestMapping(value = "/selectdel/", method = RequestMethod.GET)
	public String select_delete(@RequestParam int cart_idx[]) {
		for(int i=0; i<cart_idx.length; i++) {
			cartService.selectDel(cart_idx[i]);
		}
	
	return "redirect:/cart";
	}
	
	/*장바구니 추가가존 상품 확인후 업데이트*/
	@RequestMapping(value = "/cart_order", method = RequestMethod.POST)
	public String cart_order(@RequestParam("pcode") String pcode,@RequestParam("product_count") int product_count, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		Map<String, Object> map = new HashMap<String, Object>();
		int count = cartService.updatecheck(user_id,pcode);
	/*	기존상품이 있는지여부 확인*/
		if(count == 0) {
			map.put("user_id",user_id);
			map.put("pcode",pcode);
			map.put("product_count",product_count);
			this.cartService.insert(map);
		}else {
			map.put("user_id",user_id);
			map.put("pcode",pcode);
			map.put("product_count",product_count);
			this.cartService.update(map);
		}
		return "redirect:/order";
	}

}

