package com.zero.map;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

public interface MapService {
	
	int registMap(MapVO mapInfo);
	List<MapVO> selectMapView();
	List<MapVO> searchKeyword(String type, String keyword);
	List<MapVO> searchCategory(int cate);
	int getMapCountWithinRadius(double lat, double lng);
	List<MapVO> getMapAll(double lat, double lng, int offset, int size);
	int getMapAllCount();
	List<MapVO> searchShop2(int shopCategory, String shopName, String addr);
}