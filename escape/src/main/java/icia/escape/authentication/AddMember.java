package icia.escape.authentication;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import icia.escape.beans.Members;
import icia.escape.beans.Stores;
import icia.escape.db.AuthenticationMapper;
import icia.escape.utils.Encryption;
import icia.escape.utils.ProjectUtils;

@Service
public class AddMember {
	private ModelAndView mav;

	@Autowired
	private AuthenticationMapper am;
	@Autowired
	private ProjectUtils pu;
	@Autowired
	private Encryption enc;
	@Autowired
	JavaMailSenderImpl javaMail;

	@Autowired
	private DataSourceTransactionManager dtm;

	private DefaultTransactionDefinition dtmdf;
	private TransactionStatus dtmStatus;

	public AddMember() {
		mav = new ModelAndView();
	}

	public ModelAndView backController(String serviceCode, Model model) {
		if(model == null) {

		}else {
			switch(serviceCode) {
			case "M3":
				checkMemberId(model);
				break;
			case "M4":
				memberSignUp(model);
				break;
			case "S3":
				checkStoreId(model);
				break;
			case "S4":
				storeSignUp(model);
				break;
			}
		}return mav;
	}

	//사용자 회원가입 : 아이디 중복 체크
	private void checkMemberId(Model model) {
		String message = "이미 사용된 아이디입니다. 다른 아이디를 입력해주세요.";

		if(!this.convertToBoolean(this.am.checkMemberId((Members)model.getAttribute("memberId")))) {
			message = "아이디 사용이 가능합니다";
		}

		model.addAttribute("msg", message);
	}

	//사용자 회원가입 : 회원가입
	private void memberSignUp(Model model) {
		boolean check = false;
		String message = "회원가입이 실패하였습니다.";
		String mmCode ="";
		String page = "addMember";
		int i = 1;
		//Transaction
		this.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		if((mmCode = this.am.checkMemberCode((Members)model.getAttribute("memberData"))) != null) {

			String codeNumber = Integer.toString((Integer.parseInt(mmCode.substring(2, 4)) + i));
			if(codeNumber.length() ==1) {
				mmCode = "M" + "00"+ codeNumber;
			}else if(codeNumber.length() ==2) {
				mmCode = "M" + "0"+ codeNumber;
			}else {
				mmCode = "M" +  codeNumber;
			}
			((Members)model.getAttribute("memberData")).setMmCode(mmCode);

		}
		if((Members)model.getAttribute("memberData") != null) {
			((Members)model.getAttribute("memberData")).setMmPassword(enc.encode(((Members)model.getAttribute("memberData")).getMmPassword()));

			if(this.convertToBoolean(this.am.insMember((Members)model.getAttribute("memberData")))) {
				check = true;
				message = "회원가입이 완료되었습니다.";
				page = "completeSignUpMember";
				try {
					mav.addObject("memberInfo", ((Members)model.getAttribute("memberData")));
					pu.setAttribute("memberInfo",mav.getModel().get("memberInfo"));
					mav.addObject("msg", message);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		//Transaction End
		this.setTransactionEnd(check);

		
		this.mav.setViewName(page);
		
	}



	//업체 회원가입 : 아이디 중복 체크
	private void checkStoreId(Model model) {

		String message = "이미 사용된 아이디입니다. 다른 아이디를 입력해주세요.";
		if(!this.convertToBoolean(this.am.checkStoreId((Stores)model.getAttribute("storeId")))) {
			message = "아이디 사용이 가능합니다";
		}

		model.addAttribute("msg", message);
	}

	//업체 회원가입 : 회원가입
	private void storeSignUp(Model model) {
		String page = "addStore";
		
		boolean check = false;
		String message = "회원가입이 실패하였습니다.";
		String srCode ="";
		int i = 1;
		
		((Stores)model.getAttribute("storeData")).setSrImage("noImage/jpg");
		//Transaction
		this.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,TransactionDefinition.ISOLATION_READ_COMMITTED, false);

		if((srCode = this.am.checkStoreCode((Stores)model.getAttribute("storeData"))) != null) {

			String codeNumber = Integer.toString((Integer.parseInt(srCode.substring(2, 4)) + i));
			if(codeNumber.length() ==1) {
				srCode = "S" + "00"+ codeNumber;
			}else if(codeNumber.length() ==2) {
				srCode = "S" + "0"+ codeNumber;
			}else {
				srCode = "S" +  codeNumber;
			}
			((Stores)model.getAttribute("storeData")).setSrCode(srCode);

		}
		if((Stores)model.getAttribute("storeData") != null) {
			((Stores)model.getAttribute("storeData")).setSrPassword(enc.encode(((Stores)model.getAttribute("storeData")).getSrPassword()));

			if(this.convertToBoolean(this.am.insStore((Stores)model.getAttribute("storeData")))) {
				check = true;
				message = "회원가입이 완료되었습니다.";
				page = "completeSignUpMember";
				try {
					mav.addObject("storeInfo", ((Stores)model.getAttribute("storeData")));
					pu.setAttribute("storeInfo",mav.getModel().get("storeInfo"));
					mav.addObject("msg", message);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
		}

		//Transaction End
		this.setTransactionEnd(check);

		
		this.mav.setViewName(page);
	}
	
	
	//Transaction PROPAGATION
	private void setTransactionConf(int propa, int iso, boolean isRead) {
		this.dtmdf = new DefaultTransactionDefinition();
		this.dtmdf.setPropagationBehavior(propa);
		this.dtmdf.setIsolationLevel(iso);
		this.dtmdf.setReadOnly(false);
		this.dtmStatus = this.dtm.getTransaction(dtmdf);
	}
	//Transaction End
	private void setTransactionEnd(boolean tran) {
		if(tran) this.dtm.commit(dtmStatus);
		else this.dtm.rollback(dtmStatus);
	}

	private boolean convertToBoolean(int value) {
		return (value > 0)? true : false;
	}
}


