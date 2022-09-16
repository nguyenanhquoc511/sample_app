class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return redirect_to users_path if @user.nil?
  end

  def new
    # flash[:success] = "ABCD"
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "users_controller.welcome_message"
      redirect_to @user
    else
      flash.now[:danger] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
