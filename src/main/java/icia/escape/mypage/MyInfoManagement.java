package icia.escape.mypage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import icia.escape.beans.Stores;
import icia.escape.db.AuthenticationMapper;
import icia.escape.beans.Camping;
import icia.escape.beans.Members;
import icia.escape.utils.Encryption;
import icia.escape.utils.ProjectUtils;
import net.coobird.thumbnailator.Thumbnailator;

@Service
public class MyInfoManagement {
	private ModelAndView mav;

	@Autowired
	private AuthenticationMapper om;
	@Autowired
	private ProjectUtils pu;
	@Autowired
	private Encryption enc;
	@Autowired
	private DataSourceTransactionManager dtm;

	private DefaultTransactionDefinition dtmdf;
	private TransactionStatus dtmStatus;

	public MyInfoManagement() {
		mav = new ModelAndView();

	}

	public ModelAndView BackController(int serviceData, Stores... emp) {
		switch (serviceData) {
		case 1:
			accessEntry(emp[0]);
			break;
		case 2:
			accessEntry2(emp[0]);
			break;

		}
		return mav;
	}

	public void AjaxBackController(int serviceData, Model model) {
		switch (serviceData) {
		case 3:
			empListCtl(model);
			break;
		case 4:
			goodsListCtl(model);
			break;
		case 5:
			regEmpForm(model);
			break;
		case 6:
			regEmp(model);
			break;
		case 7:
			updGoodsInfo(model);
			break;
		default:
		}

	}

	private void updGoodsInfo(Model model) {
		boolean tran = false;

		// propagation, iso 설정
		this.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, tran);
		
		((Camping)model.getAttribute("goods")).setGoImgLoc("images/" + ((Camping)model.getAttribute("goods")).getGoImgLoc());
		if (this.convertToBool(this.om.updGoodsInfo((Camping) model.getAttribute("goods")))) {
			File saveFile = null;
			for (MultipartFile mf : (MultipartFile[]) model.getAttribute("file")) {
				saveFile = new File(mf.getOriginalFilename());
				try {
					mf.transferTo(saveFile);
					if(Files.probeContentType(saveFile.toPath()).startsWith("images")) {
						String imgname = ((Camping)model.getAttribute("goods")).getGoImgLoc();
						FileOutputStream thumbnail = new FileOutputStream(new File(imgname.substring(imgname.indexOf("/")+1)));
						Thumbnailator.createThumbnail(mf.getInputStream(),thumbnail,370,250);
						thumbnail.close();
					}
					
				} catch (Exception e) {e.printStackTrace();}
			}
			tran = true;
		}
		this.setTransactionEnd(tran);
		this.goodsListCtl(model);
	}

	public List<Members> AjaxBackController(int serviceData, Members... mem) {
		List<Members> list = null;
		switch (serviceData) {
		case 4:
			list = memListCtl(mem[0]);
			break;
		default:
		}
		return list;
	}

	/* 직원등록 폼 */
	public void regEmpForm(Model model) {
		if (this.convertToBool(this.om.isStore((Stores) model.getAttribute("emp")))) {
			model.addAttribute("RegEmpForm", this.om.getMaxEmp((Stores) model.getAttribute("emp")));
		}
	}

	/* 직원등록 */
	public void regEmp(Model model) {
		boolean tran = false;
		// Explicit Transaction Configuration
		this.setTransactionConf(TransactionDefinition.PROPAGATION_REQUIRED,
				TransactionDefinition.ISOLATION_READ_COMMITTED, false);
		// 비밀번호 암호화
		((Stores) model.getAttribute("emp"))
				.setEmPassWord(enc.encode(((Stores) model.getAttribute("emp")).getEmPassWord()));
		if (this.convertToBool(this.om.insEmployee((Stores) model.getAttribute("emp")))) {
			model.addAttribute("empList", this.om.getEmpList((Stores) model.getAttribute("emp")));

			tran = true;
		}
		this.setTransactionEnd(tran);
	}

	/* Transaction PROPAGATION */
	private void setTransactionConf(int propa, int iso, boolean isRead) {
		this.dtmdf = new DefaultTransactionDefinition();
		this.dtmdf.setPropagationBehavior(propa);
		this.dtmdf.setIsolationLevel(iso);
		this.dtmdf.setReadOnly(isRead);
		this.dtmStatus = this.dtm.getTransaction(dtmdf);
	}

	/* Transaction End */
	private void setTransactionEnd(boolean tran) {
		if (tran) {
			this.dtm.commit(dtmStatus);
		}

		else {
			this.dtm.rollback(dtmStatus);
		}
	}

	public boolean convertToBool(int value) {
		return (value > 0) ? true : false;
	}

	/*
	 * Transaction PROPAGATION -REQUIRED :트랜잭션을 발생시키고자 할 때 이미 시작된 트랜잭션이 있다면 참여시키고
	 * 없다면 새로시작 -SUPPORT :트랜젝션을 발생시키고자 할 때 이미 시작된 트랜젝션이 있다면 참여시키고 없다면 트랜젝션 없이 진행
	 * -MANDATORY : 트랜젝션을 발생시키고자 할 때 이미 시작된 트랜젝션이 있다면 참여시키고 없다면 예외 발생 -REQUIRES_NEW
	 * :무조건 새로운 트랜잭션 (JOB과 JOB) -NOT_SUPPORTED:트랜잭션을 만들지 않음
	 * 
	 * 
	 * 
	 * 
	 * Transaction ISOLATION :여러개의 트랜잭션 사이에서의 노출방법 1. READ_COMMITED 2.
	 * READ_UNCOMMITED* 3. SERIALIZATION
	 */

	private void empListCtl(Model model) {

		System.out.println(((Stores) model.getAttribute("emp")).getSeCode());
		model.addAttribute("empList", this.om.getEmpList((Stores) model.getAttribute("emp")));

	}

	private void goodsListCtl(Model model) {

		model.addAttribute("goodsList", this.om.getGoodsList());

	}

	private List<Members> memListCtl(Members mem) {

		System.out.println("기준이는 바보바보야");
		return this.om.getMemList(mem);

	}

	private void accessEntry(Stores emp) {

		try {
			if (this.pu.getAttribute("AccessInfo") != null) {
				if (this.om.isClass(emp).equals("AD")) {

					mav.setViewName("management");
				} else {
					mav.setViewName("main");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void accessEntry2(Stores emp) {

		try {
			if (this.pu.getAttribute("AccessInfo") != null) {
				mav.setViewName("sales");
			} else {
				mav.setViewName("index");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
