package com.zero.waste.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.ui.Model;

import com.zero.map.MapVO;
@Mapper
public interface MapMapper {
	int registMap(MapVO mapInfo);
	
	int addlatlng(String addr);
	
	List<MapVO> selectMapView();

	List<MapVO> searchKeyword(@Param("type")String type, @Param("keyword")String keyword);
	
	List<MapVO> searchCategory(int cate);

	List<MapVO> getMapAll(double lat, double lng, int offset, int size);

	int getMapAllCount();

	int getMapCountWithinRadius(double lat, double lng);

	List<MapVO> searchShop2(int shopCategory, String shopName, String addr);

}
