class LikesController < ApplicationController
    def create
        @post=Post.find(params[:post_id])
        @like=@post.likes.build
        if @like.save
            @like.update(count:@post.likes.count)
            flash[:success]="Post Liked!"
        else
            flash[:error]="Failed to like the post!"
        end
        redirect_to user_path(@post.user, @post)      
    end    
end
