require 'spec_helper'

describe PortfoliosController do

  describe "GET 'index'" do

    it "should be a success" do
      get :index
      response.should be_success
    end

    it "should find all portfolios and assign it to portfolios" do
      @portfolio = Factory(:portfolio)
      get :index
      assigns(:portfolios).should == [@portfolio]
    end

  end

  describe "GET 'show'" do

    before(:each) do
      @portfolio = Factory(:portfolio)
    end

    it "should be a success" do
      get_show
      repsonse.should be_success
    end

    it "should find the designated portfolio" do
      get_show
      assigns(:portfolio).should == @portfolio
    end

    it "should find the designated portfolio photos" do
      get_show
      assigns(:photos).should == @portfolio.photos
    end

    def get_show
      get :show, :id => @portfolio.id
    end

  end

end
