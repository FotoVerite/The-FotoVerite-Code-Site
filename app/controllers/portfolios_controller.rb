class PortfoliosController < ApplicationController
  
  layout 'public'
  
  def index
    @portfolios = Portfolio.all
  end
  
  def show
    @portfolio = Portfolio.find(params[:id])
    @photos = @portfolio.photos.paginate(:page => params[:page], :per_page => 4)
  end
  
end
