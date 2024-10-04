package com.zero.board.comment;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
public class Comment {
    private int commentId;
    private int boardId;
    private String commentContent;
    private String userid;
    private Timestamp commentCreatedDate;
}
