package icia.escape.controller;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import icia.escape.authentication.AddMember;
import icia.escape.authentication.FindInformation;
import icia.escape.authentication.Login;
import icia.escape.beans.Members;
import icia.escape.beans.Stores;
import icia.escape.beans.UploadFiles;

@RestController
public class AuthenticationController {
	
	@Autowired
	Login log;
	@Autowired
	AddMember am;
	@Autowired
	FindInformation fi;
	
	private static final Logger logger = LoggerFactory.getLogger(AuthenticationController.class);
	
	/*메인페이지 이동*/
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView accessform() {
		return log.memberController("0");
	}
	
	/*새로운 페이지 이동*/
	@PostMapping("/GetNewPage")
	public ModelAndView getNewPage(@ModelAttribute Members mem) {
		return log.memberController("1", mem);
	}
	
	/****************************로그인********************************/
	/*사용자 로그인*/
	@PostMapping("/LogInMember")
	public ModelAndView logInMember(@ModelAttribute Members mem) {
		return log.memberController("M1", mem);
	}
	
	/*업체 로그인*/
	@PostMapping("/LogInStore")
	public ModelAndView logInStore(@ModelAttribute Stores sr) {
		return log.storeController("S1", sr);
	}
	
	/****************************로그아웃********************************/
	/*사용자 로그아웃*/
	@PostMapping("/LogOutMember")
	public ModelAndView logOutMember(@ModelAttribute Members mem) {
		return log.memberController("M2", mem);
	}
	
	/*업체 로그아웃*/
	@PostMapping("/LogOutStore")
	public ModelAndView logOutStore(@ModelAttribute Stores sr) {
		return log.storeController("S2", sr);
	}
	/****************************회원가입********************************/
	/*사용자 회원가입 :아이디 중복 체크*/
	@PostMapping(value= "/CheckMemberId",  produces="application/json; charset=UTF-8")
	public  String checkMemberId(Model model, @RequestBody List<Members> mem) {
		am.backController("M3",model.addAttribute("memberId", mem.get(0)));
		return model.getAttribute("msg").toString();
	}
	/*사용자 회원가입 : 회원 정보 저장*/
	@PostMapping(value="/MemberSignUp" , produces="application/json; charset=UTF-8")
	public  ModelAndView memberSignUp(Model model, @RequestBody List<Members> mem) {
		return am.backController("M4",model.addAttribute("memberData", mem.get(0)));
	}
	/*업체 회원가입 :아이디 중복 체크*/
	@PostMapping(value= "/CheckStoreId",  produces="application/json; charset=UTF-8")
	public  String checkStoreId(Model model, @RequestBody List<Stores> sr) {
		am.backController("S3",model.addAttribute("storeId", sr.get(0)));
		return model.getAttribute("msg").toString();
	}
	/*업체 회원가입 : 회원 정보 저장*/
	@PostMapping(value="/StoreSignUp", produces="application/json; charset=UTF-8")
	public ModelAndView storeSignUp(Model model, @RequestBody List<Stores> sr) {
		return am.backController("S4",model.addAttribute("storeData", sr.get(0)));
	}
	/****************************아이디 찾기********************************/
	/*사용자 아이디 찾기*/
	@PostMapping("/FindMemberId")
	public ModelAndView findMemberId(@ModelAttribute Members mem) {
		
		return fi.memberController("M5", mem);
	}
	
	/*업체 아이디 찾기*/
	@PostMapping("/FindStoreId")
	public ModelAndView findStoreId(@ModelAttribute Stores sr) {
		System.out.println(sr);
		return fi.storeController("S5", sr);
	}
	
	/*******************************비밀번호 찾기*************************/
	/*사용자 비밀번호 찾기 : 이메일 전송*/
	@PostMapping("/sendMemberEmail")
	public ModelAndView sendMemberEmail(@ModelAttribute Members mem) {
		return fi.memberController("M6", mem);
	}
	/*사용자 비밀번호 찾기 : 비밀번호 변경 Form*/
	@PostMapping("/memberAuth")
	public ModelAndView memberAuth(@ModelAttribute Members mem) {
		return fi.memberController("M7", mem);
	}
	/*사용자 비밀번호 찾기 : 비밀번호 변경*/
	@PostMapping("/updMemberPwd")
	public ModelAndView updMemberPwd(@ModelAttribute Members mem) {
		return fi.memberController("M8", mem);
	}
	/*업체 비밀번호 찾기 : 이메일 전송*/
	@PostMapping("sendStoreEmail")
	public ModelAndView sendStoreEmail(@ModelAttribute Stores sr) {
		return fi.storeController("S6", sr);
	}
	/*업체 비밀번호 찾기 : 비밀번호 변경 Form*/
	@PostMapping("/storeAuth")
	public ModelAndView storeAuth(@ModelAttribute Stores sr) {
		return fi.storeController("S7", sr);
	}
	/*업체 비밀번호 찾기 : 비밀번호 변경*/
	@PostMapping("/updStorePwd")
	public ModelAndView updStorePwd(@ModelAttribute Stores sr) {
		return fi.storeController("S8", sr);
	}
	
	//	@RequestMapping(value = "/Access", method = RequestMethod.POST)
//	public ModelAndView access(@ModelAttribute Employee emp) {
//		return auth.BackController(2, emp);
//	}
//	
//	@RequestMapping(value = "/Refresh", method = {RequestMethod.POST})
//	public ModelAndView accessRefresh(@ModelAttribute Employee emp) {
//		return auth.BackController(4, emp);
//	}
//
//	@RequestMapping(value = "/AccessOut", method = RequestMethod.GET
//			)
//	public ModelAndView accessOut(@ModelAttribute Employee emp) {
//		
//		return auth.BackController(3, emp);
//	}
//	
//	@RequestMapping(value = "/PasswordForm", method = {RequestMethod.GET})
//	public String passwordForm() {
//		return "password";
//	}
//	
//	@RequestMapping(value = "/uploadForm", method = {RequestMethod.GET})
//	public String uploadForm() {
//		return "upload";
//	}
//	
//	@PostMapping("/MultiPart2")
//	@ResponseBody
//	public String fileUpload(@RequestParam("files") MultipartFile[] uploadfiles, @ModelAttribute UploadFiles uf) {
//		
//		for(MultipartFile mf : uploadfiles) {
//			File saveFile = new File("D:\\", mf.getOriginalFilename());
//			try {
//				mf.transferTo(saveFile);
//			}catch(Exception e) {e.printStackTrace();}
//		}
//		return "upload";
//	}
//	
//	
//	@RequestMapping(value = "/FindPassword", method = {RequestMethod.POST})
//	public ModelAndView sendEmail(@ModelAttribute Employee emp) {
//		return auth.BackController(5, emp);
//	}
//	
//	@RequestMapping(value = "/Management", method = RequestMethod.POST
//			)
//	public ModelAndView accessMgm(@ModelAttribute Employee emp) {
//		return mgm.BackController(1, emp);
//	}
//	
//	@RequestMapping(value = "/EmailAuth", method = RequestMethod.GET
//			)
//	public ModelAndView emailAuth(@ModelAttribute Employee emp) {
//		return auth.BackController(6, emp);
//	}
//	
//	@RequestMapping(value = "/ModPassword", method = RequestMethod.POST
//			)
//	public ModelAndView modPassword(@ModelAttribute Employee emp) {
//		return auth.BackController(7, emp);
//	}
//	
//	@RequestMapping(value = "/Sales", method = RequestMethod.POST
//			)
//	public ModelAndView accessSales(@ModelAttribute Employee emp) {
//		return sls.BackController(0, emp);
//	}
	
}