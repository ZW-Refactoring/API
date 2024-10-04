package com.zero.board.comment;

import java.util.List;

public interface CommentService {

    void save(Comment comment);

    List<Comment> findAll(int boardId);

    boolean deleteComment(int commentId, String userid);
}
