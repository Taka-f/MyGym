class GymsController < ApplicationController

  def index
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(gym_params)
  end

  private

  def gym_params
    params.require(:gym).permit(:name, :description, :number, :address)
  end
end
