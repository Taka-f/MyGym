class GymsController < ApplicationController
  before_action :find_gym, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  
  def index
    if params[:area].blank?
      @gyms = Gym.all.order("created_at DESC")
    else
      @area_id = Area.find_by(name: params[:area]).id
      @gyms = Gym.where(area_id: @area_id).order("created_at DESC")
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
    @areas = Area.all.map{ |a| [a.name, a.id] }
  end

  def create
    @gym = current_user.gyms.build(gym_params)
    @gym.area_id = params[:area_id]

    if @gym.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @areas = Area.all.map{ |a| [a.name, a.id] }
  end

  def update
    @gym.area_id = params[:area_id]

    if @gym.update(gym_params)
      redirect_to gym_path(@gym)
    else
      render 'edit'
    end
  end

  def destroy
    @gym.destroy
    redirect_to root_path
  end 

  private

  def gym_params
    params.require(:gym).permit(:name, :description, :number, :address, :area_id, :picture, :time, :url)
  end

  def find_gym
    @gym = Gym.find(params[:id])
  end
  
end
