package com.zero.board.comment;

import com.zero.waste.mapper.CommentMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class CommentServiceImpl implements CommentService{

    private final CommentMapper commentMapper;

    @Override
    public void save(Comment comment) {
        commentMapper.save(comment);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Comment> findAll(int boardId) {
        return commentMapper.findAll(boardId);
    }

    @Override
    public boolean deleteComment(int commentId, String userid) {
        try {
            int result = commentMapper.deleteComment(commentId, userid);
            return result == 1;
        } catch (DataAccessException e) {
            return false;
        }
    }
}
