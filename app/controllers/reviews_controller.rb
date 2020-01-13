class ReviewsController < ApplicationController
  before_action :find_gym
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]


  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.gym_id = @gym.id
    @review.user_id = current_user.id

    if @review.save
      flash[:notice] = 'レビューを投稿しました'
      redirect_to @gym
    else
      flash[:error_messages] = @review.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @gym
    else
      flash[:error_messages] = @review.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = 'レビューを削除しました'
    redirect_to @gym
  end

  private
  
    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_gym
      @gym = Gym.find(params[:gym_id])
    end

    def find_review
      @review = Review.find(params[:id])
    end

end
