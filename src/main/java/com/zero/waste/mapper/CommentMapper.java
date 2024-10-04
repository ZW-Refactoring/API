package com.zero.waste.mapper;

import com.zero.board.comment.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CommentMapper {

    void save(Comment comment);

    List<Comment> findAll(int boardId);

    int deleteComment(@Param("commentId") int commentId, @Param("userid") String userid);
}
