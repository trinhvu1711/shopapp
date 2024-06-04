package com.project.shopapp.service.comment;

import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.dtos.CommentDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Category;
import com.project.shopapp.models.Comment;
import com.project.shopapp.responses.CategoriesResponse;
import org.springframework.data.domain.PageRequest;

import java.util.List;

public interface ICommentService {
    Comment insertComment(CommentDTO comment) throws Exception;
    void deleteComment(Long commentId);
    void updateComment(CommentDTO comment, Long id) throws Exception ;
    List<Comment> getCommentByUserAndProduct(Long userId, Long productId);
    List<Comment> getCommentProduct(Long productId);
}
