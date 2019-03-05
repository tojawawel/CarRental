class CarsController < ApplicationController
  before_action :set_car, only: %i[show edit update destroy]

  def index
    @cars = Car.all.page(params[:page]).per(6)
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    if @car.save
      flash[:success] = 'Car was successfully created'
      redirect_to car_path(@car)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      flash[:success] = 'Car was successfully updated'
      redirect_to car_path(@car)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @car.destroy
    flash[:danger] = 'Car was successfully deleted'
    redirect_to cars_path
  end

  private

  def car_params
    car_params = params.require(:car).permit(:brand, :model, :year, :price, :description, :carpic)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end
