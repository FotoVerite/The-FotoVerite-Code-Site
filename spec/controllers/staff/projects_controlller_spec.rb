require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Staff::ProjectsController do

  describe "GET 'index'" do

    before(:each) do
      admin_login
      @project = Factory(:project)
    end

    it "should assign and paginate found projects to projects" do
      get_index
      assigns(:projects).should == [@project]
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
      @project = Factory(:project)
    end

    it "should find the designated project and assign it to project" do
      get_show
      assigns[:project].should == @project
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
      get :show, :id => @project.id
    end

  end

  describe "GET 'new'" do

    before(:each) do
      admin_login
    end

    it "should create a new administrator and assign it to @administrator" do
      get_new
      assigns[:project].should.class == Project
      assigns[:project].new_record?.should be_true
    end

    it "should find the amount of projects + 1 and assign it to count" do
      get_new
      assigns[:count].should == Project.count + 1
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

      it "should create a new project" do
        lambda do
          post_create
        end.should change(Project, :count).by(1)
      end

      it "should flash a notice" do
        post_create
        flash[:notice].should_not be_nil
      end

      it "should redirect_to staff project show page" do
        post_create
        project = Project.last
        response.should redirect_to(staff_project_path(project))
      end

    end

    context "unsuccessful" do

      it "should render template new" do
        post_create( :name => nil)
        response.should render_template(:new)
      end

      it "should find the amount of projects + 1 and assign it to count" do
        post_create( :name => nil)
        assigns[:count].should == Project.count + 1
      end

      it "should find all technology tags" do
        post_create( :name => nil)
        assigns[:technologies].should == Project.tag_counts_on(:technologies)
      end

      it "should find all feature tags" do
        post_create( :name => nil)
        assigns[:features].should == Project.tag_counts_on(:features)
      end

    end

    def post_create(options = {})
      post :create, :project => Factory.build(:project).attributes.merge(options)
    end

  end

  describe "GET 'edit'" do

    before(:each) do
      admin_login
      @project = Factory(:project)
    end

    it "should find the designated project and assign it to project" do
      get_edit
      assigns[:project].should == @project
    end

    it "should be a success" do
      get_edit
      response.should be_success
    end

    it "should render the edit template" do
      get_edit
      response.should render_template(:edit)
    end

    it "should find the amount of projects and assign it to count" do
      get_edit
      assigns[:count].should == Project.count
    end

    it "should find all technology tags" do
      get_edit
      assigns[:technologies].should == Project.tag_counts_on(:technologies)
    end

    it "should find all feature tags" do
      get_edit
      assigns[:features].should == Project.tag_counts_on(:features)
    end

    def get_edit
      get :edit, :id => @project.id
    end

  end

  describe "Put 'update'" do

    before(:each) do
      admin_login
      @project = Factory(:project, :name => "John")
    end

    it "should find the designated project and assign it to project" do
      put_update
      assigns[:project].should == @project
    end

    it "should update the project " do
      lambda do
        put_update
        @project.reload
      end.should change(@project, :name).from('John').to('Bart')
    end

    it "should redirect to the project show page" do
      put_update
      project = Project.last
      response.should redirect_to(staff_project_path(project))
    end

    context "unsuccessful" do

      it "should render template edit" do
        put_update( :name => nil)
        response.should render_template(:edit)
      end

      it "should find the amount of projects and assign it to count" do
        put_update( :name => nil)
        assigns[:count].should == Project.count
      end

      it "should find all technology tags" do
        put_update( :name => nil)
        assigns[:technologies].should == Project.tag_counts_on(:technologies)
      end

      it "should find all feature tags" do
        put_update( :name => nil)
        assigns[:features].should == Project.tag_counts_on(:features)
      end

    end


    def put_update(options ={})
      put :update, :id => @project.id, :project => {:name => "Bart"}.merge(options)
    end

  end


  describe "GET 'delete'" do

    before(:each) do
      admin_login
      @project = Factory(:project)
    end

    it "should assign found project to @project" do
      get_delete
      assigns[:project].should == @project
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
      get :delete, :id => @project.id
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      admin_login
      @project = Factory(:project)
    end

    it "should delete the project" do
      lambda do
        delete_destroy
      end.should change(Project, :count).by(-1)
    end

    it "should flash a notice" do
      delete_destroy
      flash[:notice].should_not be_nil
    end


    it "should redirect to staff_projects_path" do
      delete_destroy
      response.should redirect_to(staff_projects_path)
    end

    def delete_destroy
      #still need to test for layout false. Seems very complicated and not mission critical
      delete :destroy, :id => @project.id
    end

  end

end
