require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Staff::PortfoliosController do

  describe "GET 'index'" do

    before(:each) do
      admin_login
      @portfolio = Factory(:portfolio)
    end

    it "should assign and paginate found portfolios to portfolios" do
      get_index
      assigns(:portfolios).should == [@portfolio]
    end

    it "should be a success" do
      get_index
      response.should be_success
    end

    it "should render the listing index" do
      get_index
      response.should render_template("index")
    end

    def get_index
      get :index

    end
  end

  describe "GET 'show'" do

    before(:each) do
      admin_login
      @portfolio = Factory(:portfolio)
    end

    it "should find the designated portfolio and assign it to portfolio" do
      get_show
      assigns[:portfolio].should == @portfolio
    end

    it "should be a success" do
      get_show
      response.should be_success
    end

    it "should render the template new" do
      get_show
      response.should render_template(:show)
    end

    def get_show
      get :show, :id => @portfolio.id
    end

  end

  describe "GET 'new'" do

    before(:each) do
      admin_login
    end

    it "should create a new administrator and assign it to @administrator" do
      get_new
      assigns[:portfolio].should.class == Portfolio
      assigns[:portfolio].new_record?.should be_true
    end

    it "should find the amount of portfolios + 1 and assign it to count" do
      get_new
      assigns[:count].should == Portfolio.count + 1
    end


    it "should be a success" do
      get_new
      response.should be_success
    end

    it "should render the template new" do
      get_new
      response.should render_template(:new)
    end

    def get_new
      get :new
    end

  end

  describe "POST 'create'" do

    before(:each) do
      admin_login
    end

    context "successful" do

      it "should create a new portfolio" do
        lambda do
          post_create
        end.should change(Portfolio, :count).by(1)
      end

      it "should flash a notice" do
        post_create
        flash[:notice].should_not be_nil
      end

      it "should redirect_to staff portfolio show page" do
        post_create
        portfolio = Portfolio.last
        response.should redirect_to(staff_portfolio_path(portfolio))
      end

    end

    context "unsuccessful" do

      it "should render template new" do
        post_create( :name => nil)
        response.should render_template(:new)
      end

      it "should find the amount of portfolios + 1 and assign it to count" do
        post_create( :name => nil)
        assigns[:count].should == Portfolio.count + 1
      end

    end

    def post_create(options = {})
      post :create, :portfolio => Factory.build(:portfolio).attributes.merge(options)
    end

  end

  describe "GET 'edit'" do

    before(:each) do
      admin_login
      @portfolio = Factory(:portfolio)
    end

    it "should find the designated portfolio and assign it to portfolio" do
      get_edit
      assigns[:portfolio].should == @portfolio
    end

    it "should be a success" do
      get_edit
      response.should be_success
    end

    it "should render the edit template" do
      get_edit
      response.should render_template(:edit)
    end

    it "should find the amount of portfolios and assign it to count" do
      get_edit
      assigns[:count].should == Portfolio.count
    end


    def get_edit
      get :edit, :id => @portfolio.id
    end

  end

  describe "Put 'update'" do

    before(:each) do
      admin_login
      @portfolio = Factory(:portfolio, :name => "John")
    end

    it "should find the designated portfolio and assign it to portfolio" do
      put_update
      assigns[:portfolio].should == @portfolio
    end

    it "should update the portfolio " do
      lambda do
        put_update
        @portfolio.reload
      end.should change(@portfolio, :name).from('John').to('Bart')
    end

    it "should redirect to the portfolio show page" do
      put_update
      portfolio = Portfolio.last
      response.should redirect_to(staff_portfolio_path(portfolio))
    end

    context "unsuccessful" do

      it "should render template edit" do
        put_update( :name => nil)
        response.should render_template(:edit)
      end

      it "should find the amount of portfolios and assign it to count" do
        put_update( :name => nil)
        assigns[:count].should == Portfolio.count
      end

    end


    def put_update(options ={})
      put :update, :id => @portfolio.id, :portfolio => {:name => "Bart"}.merge(options)
    end

  end


  describe "GET 'delete'" do

    before(:each) do
      admin_login
      @portfolio = Factory(:portfolio)
    end

    it "should assign found portfolio to @portfolio" do
      get_delete
      assigns[:portfolio].should == @portfolio
    end

    it "should be a success" do
      get_delete
      response.should be_success
    end

    it "should render the delete template" do
      get_delete
      response.should render_template("delete")
    end

    def get_delete
      get :delete, :id => @portfolio.id
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      admin_login
      @portfolio = Factory(:portfolio)
    end

    it "should delete the portfolio" do
      lambda do
        delete_destroy
      end.should change(Portfolio, :count).by(-1)
    end

    it "should flash a notice" do
      delete_destroy
      flash[:notice].should_not be_nil
    end


    it "should redirect to staff_portfolios_path" do
      delete_destroy
      response.should redirect_to(staff_portfolios_path)
    end

    def delete_destroy
      #still need to test for layout false. Seems very complicated and not mission critical
      delete :destroy, :id => @portfolio.id
    end

  end

end
