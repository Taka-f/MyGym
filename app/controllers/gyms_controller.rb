class GymsController < ApplicationController
  before_action :find_gym, only: [:show, :edit, :update, :destroy]
  def index
    @gyms = Gym.all.order("created_at DESC")
  end

  def show
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
    params.require(:gym).permit(:name, :description, :number, :address, :area_id)
  end

  def find_gym
    @gym = Gym.find(params[:id])
  end
end
