class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show destroy]
  before_action :set_car, only: %i[create destroy]

  def index
    @reviews = Review.all
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.car = @car
    if @review.save
      flash[:success] = "Review added!"
      redirect_to car_path(@car)
    else
      render 'cars/show'
    end
  end

  def destroy
    @review.destroy
    redirect_to car_path(@car)
  end

  private

  def review_params
    review_params = params.require(:review).permit(:body)
  end

  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end

  def set_car
    @car = Car.find(params[:car_id])
  end
end
