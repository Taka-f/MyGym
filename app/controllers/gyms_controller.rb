class GymsController < ApplicationController
  before_action :find_gym, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :areas, only: [:new, :create, :edit, :update]
  
  def index
    if params[:area].blank?
      @gyms = Gym.all.order("created_at DESC").page(params[:page]).per(4)
    else
      @area_id = Area.find_by(name: params[:area]).id
      @gyms = Gym.where(area_id: @area_id).order("created_at DESC").page(params[:page]).per(4)
    end
  end

  def show
    if @gym.reviews.blank?
      @average_review = 0
    else
      @average_review = @gym.reviews.average(:rating).round(2)
    end
  end

  def new
    @gym = current_user.gyms.build
  end

  def create
    @gym = current_user.gyms.build(gym_params)
    @gym.area_id = params[:area_id]

    if @gym.save
      flash[:notice] = "#{@gym.name}を投稿しました"
      redirect_to @gym
    else
      flash[:error_messages] = @gym.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    @gym.area_id = params[:area_id]

    if @gym.update(gym_params)
      flash[:notice] = "#{@gym.name}の投稿を編集しました"
      redirect_to @gym
    else
      flash[:error_messages] = @gym.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @gym.destroy
    flash[:notice] = "#{@gym.name}の投稿を削除しました"
    redirect_to root_path
  end 

  private

  def gym_params
    params.require(:gym).permit(:name, :description, :number, :address, :area_id, :picture, :time, :url, :area_id)
  end

  def find_gym
    @gym = Gym.find(params[:id])
  end
  
  def areas
    @areas = Area.all.map{ |a| [a.name, a.id] }
  end

end
