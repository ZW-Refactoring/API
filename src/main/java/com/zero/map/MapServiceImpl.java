package com.zero.map;


import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.zero.waste.mapper.MapMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MapServiceImpl implements MapService {
	
	private final MapMapper mapMapper;
	
	@Override
	public int registMap(MapVO mapInfo) {
		return mapMapper.registMap(mapInfo);
	}

	@Override 
	public List<MapVO> selectMapView() {
		return mapMapper.selectMapView();
	}

	@Override
	public List<MapVO> searchKeyword(String type, String keyword) {
		return mapMapper.searchKeyword(type, keyword);
	}
	
	@Override
	public List<MapVO> searchCategory(int cate){
		return mapMapper.searchCategory(cate);
	}
	
	
	@Override
	 public List<MapVO> getMapAll(double lat, double lng, int offset, int size) {
        return mapMapper.getMapAll(lat, lng, offset, size);
    }
	
	@Override
	public 	int getMapAllCount() {
		return mapMapper.getMapAllCount();
	}

	@Override
	public int getMapCountWithinRadius(double lat, double lng) {
	    return mapMapper.getMapCountWithinRadius(lat, lng);
	}

	@Override
	public List<MapVO> searchShop2(int shopCategory, String shopName, String addr) {
		return mapMapper.searchShop2(shopCategory, shopName, addr);
	}






}