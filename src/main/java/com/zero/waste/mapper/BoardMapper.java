package com.zero.waste.mapper;

import com.zero.board.Board;
import com.zero.board.Criteria;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<String> getAllBoardLinks();

    List<Board> getListLimit();

    // 게시판 관련
    List<Board> getList(Criteria cri);
    void insert(Board vo);
    Board read(int idx);
    void update(Board vo);
    void delete(int idx);
    int totalCount(Criteria cri);
}
