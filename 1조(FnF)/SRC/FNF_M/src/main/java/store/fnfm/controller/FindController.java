package store.fnfm.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import store.fnfm.comm.JSONUtil;
import store.fnfm.service.FindService;
import store.fnfm.vo.LoginVO;

@Controller
public class FindController {
	@Resource
	private FindService findService;
	private LoginVO loginVo;
	
	@Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

	//아이디 찾기
	@RequestMapping(value="idsearchok", method=RequestMethod.POST)
	public void idsearchok(LoginVO loginVo, HttpServletResponse response) throws IOException {
		System.out.println(loginVo);
		
		loginVo = findService.searchId(loginVo);
		Map<String, Object> map = new HashMap<>();
		map.put("loginVO", loginVo);
		
		System.out.println(map);
		
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(JSONUtil.MapToJson(map));
	}
	
	//비밀번호 찾기
	@RequestMapping(value="/pwsearchok", method=RequestMethod.POST)
	@ResponseBody
	public Map pwsearchok(@RequestBody LoginVO loginVo) throws IOException {
		/////////user가 보낸 정보들
		String userid = loginVo.getUser_id();
		String email = loginVo.getEmail();
		String question = loginVo.getQuestion();
		String answer = loginVo.getAnswer();
		
		System.out.println("여기까지 이상없음");
		LoginVO loginVo2 = findService.selectUser2(loginVo); //디비에서 정보가져옴
		System.out.println(loginVo2);
		String password = null;
		String loginVo3 = null;
		if(userid.equals(loginVo2.getUser_id()) && email.equals(loginVo2.getEmail()) && 
				question.equals(loginVo2.getQuestion()) && answer.equals(loginVo2.getAnswer())){
			int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
			password = String.valueOf(ran);
            System.out.println("password = " + password);
            loginVo2.setPassword(password);
            loginVo3 = loginVo2.getPassword(); //loginVo3 여기서 따로 변수를 만들어서 유저에게 암호화되지 않는 비밀번호를 보여줌
            loginVo2.setPassword(this.bcryptPasswordEncoder.encode(loginVo2.getPassword())); // 이게 비밀번호 암호화 하는거. 위에 A	utowired 해줘야함
            findService.updatepw(loginVo2); // 해당 유저의 DB정보 변경 //암호화 과정을 거친 비밀번호 update
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		map.put("loginVO", loginVo3);
		return map;
	}
}
