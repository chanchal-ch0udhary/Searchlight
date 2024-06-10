class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create,:index]
    before_action :get_id,only: [:show,:view,:edit,:update,:destroy]
    def index
      @users=User.all.with_attached_image
      # render json: @users, user: ::UserSerializer
    end

    def show
        if @user.posts.any?
            @posts=@user.posts
        else
          render :show
        end
    end

    def view
        if @user.posts.any?
          @posts=@user.posts
        else
          render :show
        end
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.create(user_params)
      if @user.valid?
        session[:user_id] = @user.id
        redirect_to @user
      else
        flash[:error] = "Error- please try to create an account again."
        redirect_to new_user_path
      end
    end

    def edit
    end

    def update
       if @user.update(user_params)
        redirect_to @user
       else
        render edit_user_path
       end   
    end
    
    def destroy
      if @user.destroy
      flash[:notice]="Successfully deleted"
      redirect_to users_path
      end
    end  
  
    private
    def get_id
      @user=User.find(params[:id])
    end  
    def user_params
      params.require(:user).permit(:id,:email, :password, :image,:name,:bio)
    end
end
