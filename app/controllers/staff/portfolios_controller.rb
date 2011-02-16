class Staff::PortfoliosController < ApplicationController

  layout 'staff'

  before_filter :confirm_logged_in

  def index
    @portfolios = Portfolio.paginate(:page => params[:page])
  end

  def new
    @count = Portfolio.count + 1
    @portfolio = Portfolio.new(:position => @count)
  end

  def create
    new_position = params[:portfolio].delete(:position).to_i
    @portfolio = Portfolio.new(params[:portfolio])
    if @portfolio.save
      @portfolio.insert_at(new_position)
      flash[:notice] = 'Portfolio type was successfully created.'
      redirect_to staff_portfolio_path(@portfolio)
    else
      @count = Portfolio.count + 1
      render("new")
    end
  end
  
  def photos
    edit
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
    @count = Portfolio.count
  end

  def update
    new_position = params[:portfolio].delete(:position).to_i
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.update_attributes(params[:portfolio])
      if new_position != @portfolio.position
        @portfolio.remove_from_list
        @portfolio.insert_at(new_position)
      end
      flash[:notice] = 'Portfolio type was successfully updated.'
      redirect_to staff_portfolio_path(@portfolio)
    else
      @count = Portfolio.count
      render("edit")
    end
  end

  def show
    @portfolio = Portfolio.find(params[:id])
  end

  def delete
    # delete allows user to reconfirm the deletion before destroying it
    @portfolio = Portfolio.find(params[:id])
  end

  def destroy
    portfolio = Portfolio.find(params[:id])
    if portfolio && portfolio.destroy
      flash[:notice] = "The portfolio was deleted."
    else
      flash[:notice] = "The portfolio was not deleted."
    end
    redirect_to staff_portfolios_path
  end

end