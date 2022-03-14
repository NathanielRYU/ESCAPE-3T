package icia.escape.beans;

import java.util.List;

import lombok.Data;

@Data
public class Orders {
	private String olCode;
	private String seCode;
	private String emCode;
	private String olStatus;
	private List<OrderDetail> otList;
}
