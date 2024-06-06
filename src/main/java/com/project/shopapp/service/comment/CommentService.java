package com.project.shopapp.service.comment;

import com.project.shopapp.dtos.CommentDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Comment;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.User;
import com.project.shopapp.repositories.CommentRepository;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.repositories.UserRepository;
import com.project.shopapp.responses.CommentResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

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
                .user(existingUser).product(product)
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
                .orElseThrow(() -> new DataNotFoundException("Comment not found"));
        exsiting.setContent(comment.getContent());
        commentRepository.save(exsiting);
    }

    @Override
    public List<CommentResponse> getCommentByUserAndProduct(Long userId, Long productId) {
        List<Comment> comments = commentRepository.findByUserIdAndProductId(userId, productId);
        return comments.stream()
                .map(CommentResponse::fromComment)
                .collect(Collectors.toList());
    }

    @Override
    public List<CommentResponse> getCommentProduct(Long productId) {
        List<Comment> comments = commentRepository.findByProductId(productId);
        return comments.stream()
                .map(CommentResponse::fromComment)
                .collect(Collectors.toList());
    }

}
