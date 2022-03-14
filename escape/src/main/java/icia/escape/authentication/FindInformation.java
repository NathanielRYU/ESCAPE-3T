package icia.escape.authentication;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.servlet.ModelAndView;

import icia.escape.beans.Stores;
import icia.escape.db.AuthenticationMapper;
import icia.escape.utils.Encryption;
import icia.escape.utils.ProjectUtils;

@Service
public class FindInformation {
	private ModelAndView mav;

	@Autowired
	private AuthenticationMapper om;
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
	
	
	public FindInformation() {
		mav = new ModelAndView();

	}

	public ModelAndView BackController(int serviceData, Stores... emp) {

		if (emp.length == 0) {
			switch (serviceData) {
			case 1:
				accessform();
				break;
			}

		} else {
			switch (serviceData) {
			case 2:
				accessCtl(emp[0]);
				break;
			case 3:
				accessOut(emp[0]);
				break;
			case 4:
				accessRefreshCtl(emp[0]);
				break;
			case 5:
				sendEmail(emp[0]);
				break;
			case 6:
				authEmail(emp[0]);
				break;
			case 7:
				modPassword(emp[0]);
				break;
			}
		}
		return mav;
	}
    
	private void modPassword(Stores emp) {
		boolean tran = false;
		String message = "패스워드 변경 실패";
		String page = "password";
		// update
		// propagation , isolation 설정
		this.setTransactionConf(this.dtmdf.PROPAGATION_REQUIRED,this.dtmdf.ISOLATION_READ_COMMITTED,false);
		//emp.setEmPassWord(this.enc.encode(emp.getEmPassWord()));
		if(this.convertToBool(this.om.updPassword(emp))){
			tran = true;
			message = "패스워드가 안전하게 변경되었습니다. 로그인 후 서비스를 이용해 주세요.";
			page = "index";
		}
		this.setTransactionEND(tran);
		
		this.mav.addObject("msg",message);
		this.mav.setViewName(page);
		
	}
	
	private void authEmail(Stores emp) {
		String code = null;
		this.mav.addObject("msg", "변경할 패스워드를 입력해주세요~");
		
		try {
			code = this.enc.aesDecode(emp.getAuthCode(), "changePWD");
		} catch (Exception e) {e.printStackTrace();}
		
		this.mav.addObject("seCode", code.substring(0,code.indexOf(":")));
		this.mav.addObject("emCode", code.substring(code.indexOf(":")+1));
		this.mav.setViewName("modPassword");
	} 
	
	private void sendEmail(Stores emp) {
		/* 해당사원의 Email 일치 여부 확인 : DATABASE 작업 
		 * stCode, elCode, email
		 * */
		
		/* Email Info */
		boolean isSendMail = false;
		String message = "등록된 정보와 일치하지 않습니다.";
		String page = "password";
		
		if(this.convertToBool(this.om.isMember(emp))) {
			String auth = emp.getSeCode() + ":" + emp.getEmCode();
			try {
				auth = this.enc.aesEncode(auth, "changePWD");
			} catch (Exception e) {e.printStackTrace();}
			/* Email Info */
			String subject = "Modify Your Password";
			String contents = "<a href='http://192.168.0.100/EmailAuth?authCode=" + auth + "'>인증 작업을 위해 이동해 주세요</a>";
			
			String from = "secuandb4@naver.com";
			String to = emp.getEmail();
			
			/* Creation MimeMessage */
			MimeMessage mail = javaMail.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail, "UTF-8");
			
			try {
				helper.setFrom(from);
				helper.setTo(to);
				helper.setSubject(subject);
				helper.setText(contents, true);
				javaMail.send(mail);
				isSendMail = true;
			} catch (MessagingException e) {isSendMail = false; e.printStackTrace();}
				message = isSendMail? "Mail이 발송되었습니다. 패스워드 변경 후 접속하시기 바랍니다.":"메일 발송 실패!";
				page = "index";
			
		}
		/* message 작성*/
		this.mav.addObject( "msg", message);
		
		/* page */
		this.mav.setViewName(page);
	}
	
	private void accessform() {

		try {
			if (this.pu.getAttribute("AccessInfo") != null) {
				pu.setAttribute("AccessInfo", mav.getModel().get("AccessInfo"));
				mav.setViewName("main");
			} else {
				mav.setViewName("index");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void accessRefreshCtl(Stores emp) {
		String page = "redirect:/";
		String message = "다시 로그인 해주세요";
		
		
		try {
			if((Stores)pu.getAttribute("sessionInfo") != null) {
				/* DB Access Log Check */
				this.mav.addObject("AccessInfo", this.om.isAccessInfo(emp));
				page = "main";
				message = "새로고침 하셨습니다.";
			}
		} catch (Exception e) {e.printStackTrace();}
		this.mav.addObject("msg", message);
		this.mav.setViewName(page);
	}
	
	private void accessCtl(Stores emp) {
		boolean isAccessCheck = false;
		String page = "redirect:/";
		String message = "로그인 정보를 확인해 주세요.";
        
		/*
		 * DB Log-in :: myBatis 로그인 성공 : AccessHistory - Insert - Commit -->
		 * isAccessCheck = true;
		 */
		try {
			String pwd;
			if ((pwd = this.om.isEmployee(emp)) != null) {
					if (enc.matches(emp.getEmPassWord(), pwd)) {
						emp.setStCode(9);
//						try {
//							emp.setPublicIp(enc.aesEncode(emp.getPublicIp(), emp.getSeCode() + ":" + emp.getEmName()));
//						} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
//								| NoSuchPaddingException | InvalidAlgorithmParameterException
//								| IllegalBlockSizeException | BadPaddingException e) {
//							e.printStackTrace();
//						}
						
						if (this.convertToBool(this.om.insAccessHistory(emp))) {
							isAccessCheck = true;
							message = "정상적으로 로그인 하셨습니다.";
						}else {
							message = "네트워크가 불안합니다. 잠시 후 다시 와라짜증나니까";
						}
					}
				}
				if (isAccessCheck) {
					this.mav.addObject("AccessInfo", this.om.isAccessInfo(emp));
					pu.setAttribute("AccessInfo", mav.getModel().get("AccessInfo"));
					page = "main";
				}

		} catch (Exception e) {e.printStackTrace();}

		this.mav.addObject("msg", message);
		mav.setViewName(page);
	}

	private void accessOut(Stores emp) {
		String page = "redirect:/";
		this.mav.getModel().remove("msg");
		this.mav.getModel().remove("AccessInfo");

		/*
		 * DB Log-in :: myBatis 로그아웃 : AccessHistory - Insert - Commit --> isAccessCheck
		 * = true;
		 */

		try {

			emp.setStCode(-9);
//			emp.setPublicIp(enc.aesEncode(emp.getPublicIp(), emp.getSeCode() + ":" + emp.getEmName()));

			this.om.insAccessHistory(emp);
//		} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException | NoSuchPaddingException
//				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {
//			e.printStackTrace();
		} finally {
			try {
				pu.removeAttribute("AccessInfo");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		mav.setViewName(page);
	}

	public boolean convertToBool(int value) {
		return (value > 0) ? true : false;
	}
	
	private void setTransactionEND(boolean tran) {
		if(tran) this.dtm.commit(dtmStatus);
		else this.dtm.rollback(dtmStatus);
	}
	
	
	private void setTransactionConf(int propa, int iso, boolean isRead) {
		this.dtmdf = new DefaultTransactionDefinition();
		this.dtmdf.setPropagationBehavior(propa);
		this.dtmdf.setIsolationLevel(iso);
		this.dtmdf.setReadOnly(isRead);
		this.dtmStatus = this.dtm.getTransaction(dtmdf);
	}
}
