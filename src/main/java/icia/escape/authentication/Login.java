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
import icia.escape.beans.Members;
import icia.escape.beans.Stores;
import icia.escape.db.AuthenticationMapper;
import icia.escape.utils.Encryption;
import icia.escape.utils.ProjectUtils;

@Service
public class Login {
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


	public Login() {
		mav = new ModelAndView();

	}
	
	/*사용자 관련된 METHOD 연결*/
	public ModelAndView memberController(String serviceCode, Members... mem) {
		if (mem.length == 0) {
			switch (serviceCode) {
			case "0":
				basicPage();
				break;
			}

		} else {
			switch(serviceCode) {
			case "1":
				getNewPage(mem[0]);
				break;
			case "M1":
				logInMember(mem[0]);
				break;
			case "M2":
				logOutMember(mem[0]);
				break;
			}
		}
		return mav;
	}
	
	/*업체 관련된 METHOD 연결*/
	public ModelAndView storeController(String serviceCode, Stores... sr) {

		switch(serviceCode) {
		case "S1":
			logInStore(sr[0]);
			break;
		case "S2":
			logOutStore(sr[0]);
			break;
		}

		return mav;
	}


	/*사용자 로그인*/
	private void logInMember(Members mem) {
		boolean isAccessCheck = false;
		String page  = "basic";
		String message = "로그인 정보를 확인해주세요";
		
		String pwd = null;
		
		if((pwd = ((Members)this.am.isMember(mem)).getMmPassword()) != "") {
			if(enc.matches(mem.getMmPassword(), pwd)) {
			/*로그인 상태코드 : 1111*/
			mem.setStCode("1111");
			mem.setMmCode((((Members)this.am.isMember(mem)).getMmCode()));
							
							if(this.convertToBoolean(this.am.insMembersAccessHistory(mem))) {
								isAccessCheck =  true;
								page = "basic";
								message = "정상적으로 로그인하였습니다.";
							}else {
								message = "로그인 실패";
							}
						}else {message = "잘못된 비밀번호 입니다";}
					}else {message = "잘못된 비밀번호 입니다";}

					if(isAccessCheck) {
						try {
							/*메인페이지에서 보여줄 아이디 저장*/
							this.mav.addObject("userInfo", this.am.getMemberInfo(mem));
							pu.setAttribute("userInfo", mav.getModel().get("userInfo"));
							
							/*사용자 IP 저장*/
							this.mav.addObject("accessInfo", this.am.getMemberAccessInfo(mem));
							pu.setAttribute("sessionInfo", mav.getModel().get("accessInfo"));
							page = "memberMain";

						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					this.mav.addObject("msg",message);
					mav.setViewName(page);
		}
		

	/*업체 로그인*/
	private void logInStore(Stores sr) {
		
		boolean isAccessCheck = false;
		String page  = "basic";
		String message = "로그인 정보를 확인해주세요";
		
		String pwd = null;
		
		
		if((pwd = ((Stores)this.am.isStores(sr)).getSrPassword()) != "") {
			if(enc.matches(sr.getSrPassword(), pwd)) {
			/*로그인 상태코드 : 1111*/
			sr.setStCode("1111");
			sr.setSrCode(((Stores)this.am.isStores(sr)).getSrCode());
			
							if(this.convertToBoolean(this.am.insStoresAccessHistory(sr))) {
								isAccessCheck =  true;
								page = "basic";
								message = "정상적으로 로그인하였습니다.";
							}else {
								message = "로그인 실패";
							}
							
						}else {message = "잘못된 비밀번호 입니다";}
					}else {message = "잘못된 비밀번호 입니다";}

					if(isAccessCheck) {
						try {
							/*메인페이지에서 보여줄 아이디 저장*/
							this.mav.addObject("userInfo", this.am.getStoreInfo(sr));
							pu.setAttribute("userInfo", mav.getModel().get("userInfo"));
							
							/*업체 IP 저장*/
							this.mav.addObject("accessInfo", this.am.getStoreAccessInfo(sr));
							pu.setAttribute("sessionInfo", mav.getModel().get("accessInfo"));
							page = "storeMain";

						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					this.mav.addObject("msg",message);
					mav.setViewName(page);
		}
		
	
    /*사용자 로그아웃*/
	private void logOutMember(Members mem) {
		
		String page = "redirect:/";
		this.mav.getModel().remove("msg");
		this.mav.getModel().remove("accessInfo");
		this.mav.getModel().remove("userInfo");
		
		try {
			/*로그아웃 상태코드 : 2222*/
			mem.setStCode("2222");
			this.am.insMembersAccessHistory(mem);

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {pu.removeAttribute("sessionInfo"); 
			     pu.removeAttribute("userInfo");} catch(Exception e) {e.printStackTrace();}
		}

		mav.setViewName(page);
	}
	
	/*업체 로그아웃*/
	private void logOutStore(Stores sr) {
		String page = "redirect:/";
		this.mav.getModel().remove("msg");
		this.mav.getModel().remove("accessInfo");
		this.mav.getModel().remove("userInfo");
		try {
			/*로그아웃 상태코드 : 2222*/
			sr.setStCode("2222");
			this.am.insStoresAccessHistory(sr);
            
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {pu.removeAttribute("sessionInfo");
				 pu.removeAttribute("userInfo");} catch(Exception e) {e.printStackTrace();}
		}

		mav.setViewName(page);
	}

	
	/*페이지 이동*/
	private void getNewPage(Members mem) {
		String page = mem.getPageName();
		this.mav.setViewName(page);
	}

	/*첫 메인화면*/
	private void basicPage() {
		this.mav.setViewName("basic");

	}


	public boolean convertToBoolean(int value) {
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
