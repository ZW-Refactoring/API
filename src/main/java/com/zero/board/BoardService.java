package com.zero.board;

import com.rometools.rome.io.FeedException;

import java.io.IOException;
import java.util.List;

public interface BoardService {
    void fetchAndSaveRssFeed() throws IOException, FeedException;

    List<Board> getListLimit();

    // 게시판 관련
    public List<Board> getList(Criteria cri);
    public Board get(int boardId);
    public void modify(Board vo);
    public void remove(int boardId);
    public int totalCount(Criteria cri);
}
