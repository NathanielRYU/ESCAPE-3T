package icia.escape.beans;

import lombok.Data;

@Data
public class OrderDetail {
	private String goCode;
	private int goQty;
	private int goDiscount;
	private String olCode;
	private String seCode;
	private String emCode;
}
