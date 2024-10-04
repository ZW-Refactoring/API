package com.zero.board.comment;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/comment")
public class CommentController {
    private final CommentService commentService;

    @PreAuthorize("isAuthenticated()")
    @PostMapping()
    public @ResponseBody List<Comment> save(@ModelAttribute Comment comment) {
        String userid = getCurrentUsername();
        comment.setUserid(userid);
        commentService.save(comment);
        // 해당 게시글에 작성된 댓글 리스트를 가져옴
        List<Comment> commentDTOList = commentService.findAll(comment.getBoardId());
        return commentDTOList;
    }

    @PreAuthorize("isAuthenticated()")
    @DeleteMapping("/{commentId}")
    @ResponseBody
    public String deleteComment(@PathVariable("commentId") int commentId) {
        String userid = getCurrentUsername();
        boolean success = commentService.deleteComment(commentId, userid);
        if (success) {
            return "success"; // 삭제 성공 시 "success" 문자열을 반환합니다.
        } else {
            return "failure"; // 삭제 실패 시 "failure" 문자열을 반환합니다.
        }
    }

    private String getCurrentUsername() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            return ((UserDetails)principal).getUsername();
        } else {
            return null;
        }
    }
}
