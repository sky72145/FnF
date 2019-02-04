package store.fnfm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import store.fnfm.service.MembersService;
import store.fnfm.service.OrdersService;
import store.fnfm.vo.MembersVO;
import store.fnfm.vo.MyOrderVO;

@Controller
public class MembersController {
	@Autowired
	private MembersService service;
	@Autowired
	private OrdersService oservice;
	@Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping({"/get","/modifys","/remove","/myorder"})
	public void get(@RequestParam("user_id") String user_id,Model model) {
		model.addAttribute("member",service.get(user_id));
		model.addAttribute("order",oservice.selectList(user_id));
	}
	
	@PostMapping("/modifys")
	public String modify(MembersVO member, RedirectAttributes rttr) {
		member.setPassword(this.bcryptPasswordEncoder.encode(member.getPassword()));
		if(service.modifys(member)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/";
	}
	@PostMapping("/remove")
	public String remove(MembersVO member, RedirectAttributes rttr,Model model) {
		if(service.remove(member)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:logout";
	}
	@PostMapping("/myorder")
	public String myorder(MyOrderVO myorder,RedirectAttributes rttr,HttpServletRequest request) {
		HttpSession Session = request.getSession();
		String user_id = (String)Session.getAttribute("user_id");
		if(oservice.modifyorder(myorder)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/myorder?user_id="+user_id;
	}
	@RequestMapping("/mile")
	public void mile(@RequestParam("user_id") String user_id,Model model) {
		model.addAttribute("mile",service.mile(user_id));
	}
	/** 페이지 이동 **/
	@RequestMapping("/mymsdviews")
	public String mymsdviews(@RequestParam("user_id") String user_id) {
		return "mymsdviews";//views-->.jsp
	}
	/** 페이지 이동 **/
	@RequestMapping("/mymrcviews")
	public String mymrcviews(@RequestParam("user_id") String user_id) {
		return "mymrcviews";//views-->.jsp
	}
	
}
