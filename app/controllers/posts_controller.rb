class PostsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create,:index]
    before_action :get_id
    def index
    end

    def show
        @post=@user.posts.find(params[:id])
    end

    def view
    end
    
    def new
        @post = @user.posts.build
    end
    
    def create
        @post = @user.posts.build(post_params)
        if @post.save
        redirect_to user_path(current_user.id),notice:"Post was Successfully created!"
        else
        flash[:error] = "Error- please try to create an account again."
        redirect_to new_user_post_path
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
        redirect_to @post
        else
        render edit_post_path
        end   
    end
    
    def destroy
        debugger
        if @post.destroy
        flash[:notice]="Successfully deleted"
        redirect_to posts_path
        end
    end  
    
    private
    def get_id
        @user=User.find(params[:user_id])
    end  
    def post_params
        params.require(:post).permit(:description,:image)
    end    
end
