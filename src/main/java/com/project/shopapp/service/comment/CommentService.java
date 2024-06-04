package com.project.shopapp.service.comment;

import com.project.shopapp.dtos.CommentDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Comment;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.User;
import com.project.shopapp.repositories.CommentRepository;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentService implements ICommentService {
    private final CommentRepository commentRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    @Override
    @Transactional
    public Comment insertComment(CommentDTO comment) throws Exception {
        User existingUser = userRepository.findById(comment.getUserId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find user with id: " + comment.getUserId()));
        Product product = productRepository.findById(comment.getProductId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find Product with id: " + comment.getProductId()));
        Comment newComment = Comment.builder()
                .content(comment.getContent())
                .user(existingUser)
                .product(product)
                .build();
        return commentRepository.save(newComment);
    }

    @Override
    @Transactional
    public void deleteComment(Long commentId) {
        commentRepository.deleteById(commentId);
    }

    @Override
    public void updateComment(CommentDTO comment, Long id) throws Exception {
        Comment exsiting = commentRepository.findById(id)
                .orElseThrow(()-> new DataNotFoundException("Comment not found"));
        exsiting.setContent(comment.getContent());
        commentRepository.save(exsiting);
    }

    @Override
    public List<Comment> getCommentByUserAndProduct(Long userId, Long productId) {
        return commentRepository.findByUserIdAndProductId(userId, productId);
    }

    @Override
    public List<Comment> getCommentProduct(Long productId) {
        return commentRepository.findByProductId(productId);
    }

}
