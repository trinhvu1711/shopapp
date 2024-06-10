package com.project.shopapp.controller;

import com.project.shopapp.dtos.CommentDTO;
import com.project.shopapp.models.User;
import com.project.shopapp.responses.CommentResponse;
import com.project.shopapp.service.comment.CommentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//@Validated
@RestController
@RequestMapping("${api.prefix}/comments")
@RequiredArgsConstructor
public class CommentController {
    private final CommentService commentService;

    @GetMapping("")//http://localhost:8088/api/v1/comments
    public ResponseEntity<List<CommentResponse>> getAllComment(
            @RequestParam(value = "user_id", required = false) Long userId,
            @RequestParam("product_id") Long productId
    ) {
        List<CommentResponse> comments;
        if (userId == null) {
            comments = commentService.getCommentProduct(productId);
        } else {
            comments = commentService.getCommentByUserAndProduct(userId, productId);
        }
        return ResponseEntity.ok(comments);
    }

    @PostMapping("")
    public ResponseEntity<?> createComment(
            @Valid @RequestBody CommentDTO commentDTO) {
        try {
            User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (user.getId() != commentDTO.getUserId()) {
                return ResponseEntity.badRequest().body("You cannot comment as another user");
            }
            return ResponseEntity.ok(commentService.insertComment(commentDTO));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }

    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateComment(
            @PathVariable Long id,
            @Valid @RequestBody CommentDTO commentDTO
    ) {
        try {
            commentService.updateComment(commentDTO, id);
            return ResponseEntity.ok("Update comment successfully");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred during comment update.");
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteComment(@PathVariable Long id) {
        commentService.deleteComment(id);
        return ResponseEntity.ok("Delete comment with id " + id);
    }

    @GetMapping("/{id}")//http://localhost:8088/api/v1/comments
    public ResponseEntity<List<CommentResponse>> getCommentByProduct(@PathVariable Long id) {
        List<CommentResponse> response = commentService.getCommentProduct(id);
        return ResponseEntity.ok(response);
    }
}
