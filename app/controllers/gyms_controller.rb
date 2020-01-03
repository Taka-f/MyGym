class GymsController < ApplicationController
  before_action :find_gym, only: [:show, :edit, :update, :destroy]
  def index
    @gyms = Gym.all.order("created_at DESC")
  end

  def show
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(gym_params)

    if @gym.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
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
    params.require(:gym).permit(:name, :description, :number, :address)
  end

  def find_gym
    @gym = Gym.find(params[:id])
  end
end
