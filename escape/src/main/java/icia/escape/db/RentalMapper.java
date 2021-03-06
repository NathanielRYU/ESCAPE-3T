package icia.escape.db;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import icia.escape.beans.Goods;
import icia.escape.beans.Stores;

@Mapper
public interface RentalMapper {
	/*************렌탈업체****************/
	/*렌탈업체 상세정보*/
	public List<Stores> getRentalStores(Stores sr);
	/*낚시 렌탈업체 리스트*/
	public int getFishingStoreListCount(Stores sr);
	public List<Stores> getFishingStoreList(Stores sr);
	/*렌탈업체 상세정보불러오기*/
	public List<Stores> chooseStoreInfo(Stores sr);
	
	/***********렌탈 장비***************/
	public int countGoodsList(Goods go);
	public int countStoreGoodsList(Goods go);
	public int countGoods(Goods go);
	public List<Goods>	getAllStoreGoods(Goods go);
	public List<Goods> getStoreGoods(Goods go);
	public List<Goods> getSameTypeGoods(Goods go);
	public Goods getThatStoreThatGoods(Goods go);
	public List<Goods> getThatStoreOtherGoods(Goods go);
	public List<Goods> getThatStoreThatGoodsList(Goods go);
	
	
	/*********장바구니************/
	public Goods getMemberAccessInfo(Goods go);
	public String getMemberCode(Goods go);
	public String getMaxCtCode(List<Goods> list);
	public int insCart(Goods goods);
	public List<Goods> getCartInfo(Goods go);
	public int updCartInfo(Goods go);
	public int delCart(Goods go);
}