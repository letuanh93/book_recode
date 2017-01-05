class UsersController < ApplicationController
  before_action :load_user, only: [:destroy]
  load_and_authorize_resource

  def index
    # @users1 = User.order(created_at: :DESC).paginate page: params[:page], per_page:20
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    # byebug
  end

  def search
    index
    render :index
  end

  def destroy
    if @user.destroy
      authorize! :destroy, @user
      flash[:success] = "deleted"
    else
      flash[:danger] = "delete failed"
    end
    redirect_to users_path
  end

  private
    def load_user
      @user = User.find_by id: params[:id]
      if @user.nil?
        flash[:danger] = "User not found"
        redirect_to users_path
      end
    end
end
