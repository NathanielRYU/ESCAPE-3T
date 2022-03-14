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
public class FindInformation {
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
	
	
	public FindInformation() {
		mav = new ModelAndView();

	}

	public ModelAndView memberController(String serviceCode, Members... mem) {

		switch (serviceCode) {
		case "M5":
			findMemberId(mem[0]);
			break;
		case "M6":
			sendMemberEmail(mem[0]);
			break;
		case "M7":
			memberAuth(mem[0]);
			break;	
		case "M8":
			modMem(mem[0]);
			break;	
		}
		
		return mav;
	}
	
	public ModelAndView storeController(String serviceCode, Stores... sr) {

		switch (serviceCode) {
		case "S5":
			findStoreId(sr[0]);
			break;
		case "S6":
			sendStoresEmail(sr[0]);
			break;
		case "S7":
			storeAuth(sr[0]);
			break;	
		case "S8":
			modStore(sr[0]);
			break;		
		}
		return mav;
	}
    
	//사용자 아이디 찾기
	private void findMemberId(Members mem) {
	 String page = "findMemberId";
	 if(this.am.findMemberId(mem) != null){
		 this.mav.addObject("memberId", this.am.findMemberId(mem));
		 page = "resultMemberId";
	 }else {
		 this.mav.addObject("msg", "회원정보를 찾을 수 없습니다.");
	 }
	 
	 this.mav.setViewName(page);
	}
	
	//업체 아이디 찾기
	private void findStoreId(Stores sr) {
	 String page = "findStoreId";
	 
	 if(this.am.findStoreId(sr) != null) {
		 this.mav.addObject("storeId", this.am.findStoreId(sr));
		 page = "resultStoreId";
	 }else {
		 this.mav.addObject("msg", "회원정보를 찾을 수 없습니다.");
	 }
	 
	 this.mav.setViewName(page);
	 
	}
	
	
	//사용자 비밀번호 찾기 :: 회원 유효성 체크 --> 이메일 전송
	private void sendMemberEmail(Members mem) {
		System.out.println(mem);
		/*Email Info*/
		boolean isSendMail = false;
		String message = "등록된 정보와 일치하지 않습니다.";
		String page = "findMemberPassword";
		
		if((this.am.checkMember(mem)!= null)) {
			mem.setMmName(this.am.checkMember(mem));
			String memberInfo = mem.getMmId() + ":" + mem.getMmName();
			
			try {
				this.enc.aesEncode(memberInfo, "changePWD");
			} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
					| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
					| BadPaddingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			/*EmailInfo*/
			String subject = "비밀번호를 변경해주세요/ 여기가 좋을 지도";
			String contents = "<a href='http://localhost/memberAuth?authCode="+ memberInfo +"'>인증작업을 위해 이동해주세요</a>";
		
			String from = "iciabeju@naver.com";
			String to = mem.getMmEmail();
			
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
				page = "basic";
			
		}
			
		/*이메일 저장*/
		this.mav.addObject("mmEmail", mem.getMmEmail());
		/* message 작성*/
		this.mav.addObject( "msg", message);
		
		/* page */
		this.mav.setViewName(page);
	}
	
	//사용자 비밀번호 찾기 : Email 변경 Form
	private void memberAuth(Members mem) {
		String code = null;
		this.mav.addObject("msg", "변경할 패스워드를 입력해주세요~");
		
		try {
			code = this.enc.aesDecode(mem.getAuthCode(), "changePWD");
		} catch (Exception e) {e.printStackTrace();}
		
		this.mav.addObject("mmId", code.substring(0,code.indexOf(":")));
		this.mav.addObject("mmName", code.substring(code.indexOf(":")+1));
		this.mav.setViewName("newMemPw");
	} 
	
	//사용자 비밀번호 찾기 : 비밀번호 변경
	private void modMem(Members mem) {
		boolean tran = false;
		String message = "패스워드 변경 실패";
		String page = "newMemPw";
		// update
		// propagation , isolation 설정
		this.setTransactionConf(this.dtmdf.PROPAGATION_REQUIRED,this.dtmdf.ISOLATION_READ_COMMITTED,false);
		mem.setMmPassword((this.enc.encode(mem.getMmPassword())));
		if(this.convertToBool(this.am.updMmPassword(mem))){
			tran = true;
			message = "패스워드가 안전하게 변경되었습니다. 로그인 후 서비스를 이용해 주세요.";
			page = "memberLogIn";
		}
		this.setTransactionEND(tran);
		
		this.mav.addObject("msg",message);
		this.mav.setViewName(page);
		
	}
	
	//업체 비밀번호 찾기 :: 회원 유효성 체크 --> 이메일 전송
	private void sendStoresEmail(Stores sr) {
		
		/*Email Info*/
		boolean isSendMail = false;
		String message = "등록된 정보와 일치하지 않습니다.";
		String page = "findStorePassword";
		
		if((this.am.checkStore(sr)!= null)) {
			sr.setSrName(this.am.checkStore(sr));
			String storeInfo = sr.getSrId() + ":" + sr.getSrName();
			
			try {
				this.enc.aesEncode(storeInfo, "changePWD");
			} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
					| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
					| BadPaddingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			/*EmailInfo*/
			String subject = "비밀번호를 변경해주세요/ 여기가 좋을 지도";
			String contents = "<a href='http://localhost/storeAuth?authCode="+ storeInfo +"'>인증작업을 위해 이동해주세요</a>";
		
			String from = "iciabeju@naver.com";
			String to = sr.getSrEmail();
			
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
				page = "basic";
			
		}
		/*이메일 저장*/
		this.mav.addObject("srEmail", sr.getSrEmail());
		/* message 작성*/
		this.mav.addObject( "msg", message);
		
		/* page */
		this.mav.setViewName(page);
	}
	
	//업체 비밀번호 찾기 : Email 변경 Form
	private void storeAuth(Stores sr) {
		String code = null;
		this.mav.addObject("msg", "변경할 패스워드를 입력해주세요~");
		
		try {
			code = this.enc.aesDecode(sr.getAuthCode(), "changePWD");
		} catch (Exception e) {e.printStackTrace();}
		
		this.mav.addObject("srId", code.substring(0,code.indexOf(":")));
		this.mav.addObject("srName", code.substring(code.indexOf(":")+1));
		this.mav.setViewName("newSrPw");
	} 
	
	//업체 비밀번호 찾기 : 비밀번호 변경
	private void modStore(Stores sr) {
		boolean tran = false;
		String message = "패스워드 변경 실패";
		String page = "newSrPw";
		// update
		// propagation , isolation 설정
		this.setTransactionConf(this.dtmdf.PROPAGATION_REQUIRED,this.dtmdf.ISOLATION_READ_COMMITTED,false);
		sr.setSrPassword((this.enc.encode(sr.getSrPassword())));
		if(this.convertToBool(this.am.updSrPassword(sr))){
			tran = true;
			message = "패스워드가 안전하게 변경되었습니다. 로그인 후 서비스를 이용해 주세요.";
			page = "storeLogIn";
		}
		this.setTransactionEND(tran);
		
		this.mav.addObject("msg",message);
		this.mav.setViewName(page);
		
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
