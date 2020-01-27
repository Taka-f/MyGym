class LikesController < ApplicationController
  before_action :set_gym

  def create
    @like = Like.create(user_id: current_user.id, gym_id: params[:gym_id])
    @likes = Like.where(gym_id: params[:gym_id])
    @gym.reload
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, gym_id: params[:gym_id])
    like.destroy
    @likes = Like.where(gym_id: params[:gym_id])
    @gym.reload
  end

  private

  def set_gym
    @gym = Gym.find(params[:gym_id])
  end

end
