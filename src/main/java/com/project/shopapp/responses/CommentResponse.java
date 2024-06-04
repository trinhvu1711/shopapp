package com.project.shopapp.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.shopapp.models.Comment;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentResponse {
    @JsonProperty("content")
    private String content;

    //user's information
    @JsonProperty("user")
    private UserResponse userResponse;

    @JsonProperty("updated_at")
    private LocalDateTime updatedAt;
    public static CommentResponse fromComment(Comment comment) {
        return CommentResponse.builder()
                .content(comment.getContent())
                .userResponse(UserResponse.fromUser(comment.getUser()))
                .updatedAt(comment.getUpdatedAt())
                .build();
    }
}
