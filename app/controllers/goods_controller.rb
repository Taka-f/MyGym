class GoodsController < ApplicationController
  before_action :set_review

  def create
    @good = Good.create(user_id: current_user.id, review_id: params[:review_id])
    @goods = Good.where(review_id: params[:review_id])
    @review.reload
  end

  def destroy
    good = Good.find_by(user_id: current_user.id, review_id: params[:review_id])
    good.destroy
    @goods = Good.where(review_id: params[:review_id])
    @review.reload
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
    # @review.id = parmas[:review_id]
  end

  # ---------------------
  # def create
  #   @good = current_user.goods.create(review_id: params[:review_id])
  #   redirect_back(fallback_location: gym_review_path)
  # end

  # def destroy
  #   @good = Good.find_by(review_id: params[:review_id], user_id: current_user.id)
  #   @good.destroy
  #   redirect_back(fallback_location: gym_review_path)
  # end
    
end
