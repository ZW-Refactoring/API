package com.zero.map;


import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MapController {
	
    private final MapService mapService;

    @GetMapping("/mapList")
    public String mapList(Model m) {
        List<MapVO> mapList = mapService.selectMapView();
        m.addAttribute("mapList", mapList);
        return "map/map";
    }
	
    @GetMapping(value = "/mapSidebar", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ModelMap mapList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam double lat,
            @RequestParam double lng) {
    		
    	int totalCount = mapService.getMapCountWithinRadius(lat, lng);
    	
        int offset = (page - 1) * size;
        int startPage = (page - 1) / size * size + 1;
        int pageCount = (totalCount-1)/size+1;
        int sizeBlock = 5;
        int prevBlock=(page-1)/sizeBlock *sizeBlock;
        int nextBlock=prevBlock +(sizeBlock+1);

        List <MapVO> mapList = mapService.getMapAll(lat, lng, offset, size);
        ModelMap map = new ModelMap();
        map.put("totalCount", totalCount);
        map.put("pageCount", pageCount);
        map.put("mapList", mapList);
        map.put("startPage", startPage); // 블럭 처리 때 사용하는 변수
        map.put("sizeBlock", sizeBlock);
        map.put("prevBlock",prevBlock);
        map.put("nextBlock",nextBlock);
        
        return map;
    }
      @GetMapping("/mapList/searchShop")
    public String searchKeyword(Model model, 
    		 @RequestParam(value="cate", defaultValue = "0", required=false) int cate,
    		@RequestParam(value="type", defaultValue="", required=false) String type, 
    		@RequestParam(value="keyword", defaultValue="",required=false) String keyword) {
    	List<MapVO> mapList = new ArrayList<>();
    	switch(type) {
    	case "shop_category":
    		if(cate!=0) {
    			mapList = mapService.searchCategory(cate);
    		}
    		break;
    	case "shop_name":
    	case "addr":
    		if(!keyword.equals("")){
    			mapList = mapService.searchKeyword(type, keyword);
    		}
    		break;
    	default:
    		mapList = mapService.selectMapView();
    	}
    	
        model.addAttribute("mapList", mapList);
        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("cate", cate);
        
        if(mapList.isEmpty()) {
        	return "map/map";
    	}else {
    		return "map/map2";
    	}
    }
   
}
