package com.zero.board;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@ToString
public class Board {
    private int boardId;                // 글번호
    private String boardTitle;          // 타이틀
    private String boardLink;           // 링크
    private String boardDescription;    // 내용
    private String boardAuthor;         // 작성자
    private Date boardDate;             // 가져온 날짜
    private int boardAvailable;         // 삭제된 글인지 여부

    public Board() {
    }

    public Board(String boardTitle, String boardLink, String boardDescription, String boardAuthor, Date boardDate, int boardAvailable) {
        this.boardTitle = boardTitle;
        this.boardLink = boardLink;
        this.boardDescription = boardDescription;
        this.boardAuthor = boardAuthor;
        this.boardDate = boardDate;
        this.boardAvailable = boardAvailable;
    }
}
