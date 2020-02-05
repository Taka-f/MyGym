class GymsController < ApplicationController
  before_action :find_gym, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :areas, only: [:new, :create, :edit, :update]
  
  def index
    @q = Gym.ransack(params[:q])
    @areas = Area.all
    @tags = Tag.all
    @gyms = @q.result(distinct: true).includes(:area, :reviews).order("created_at DESC").page(params[:page]).per(4)

    @like_ranks = Gym.create_like_ranks
    @review_ranks = Gym.create_review_ranks
  end

  def search
    @q = Gym.ransack(params[:q])
    @gyms = @q.result(distinct: true).includes(:area).page(params[:page]).per(4)
  end

  def show
    
    # if @gym.reviews.blank?
    #   @average_review = 0
    # else
    #   @average_review = @gym.reviews.average(:rating).round(2)
    # end
    @like_ranks = Gym.includes(:reviews).create_like_ranks
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
    params.require(:gym).permit({pictures: []}, :name, :description, :number, :address, :area_id, :time, :url, :area_id, tag_ids: [])
  end

  def find_gym
    @gym = Gym.find(params[:id])
  end
  
  def areas
    @areas = Area.all.map{ |a| [a.name, a.id] }
  end

end
