class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(8).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user

    # 自分と相手が同一人物でない場合のみDMの判定を行う
  if @user != current_user
    # 自分と相手、それぞれの所属している全Room IDを取得
    current_user_rooms = Entry.where(user_id: current_user.id).pluck(:room_id)
    another_user_rooms = Entry.where(user_id: @user.id).pluck(:room_id)

    # 共通のRoom IDがあるか確認（積集合 & ）
    common_room_id = (current_user_rooms & another_user_rooms).first

    if common_room_id
      @is_room = true
      @room_id = common_room_id
    else
      # 共通の部屋がなければ、新規作成用のインスタンスを用意
      @room = Room.new
      @entry = Entry.new
    end
  end
end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  


  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end

end
