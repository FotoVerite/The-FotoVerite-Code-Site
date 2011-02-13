class Staff::ProjectsController < ApplicationController

  layout 'staff'

  before_filter :confirm_logged_in

  def index
    @projects = Project.paginate(:page => params[:page])
  end

  def new
    @count = Project.count + 1
    @project = Project.new(:position => @count)
    @technologies = Project.tag_counts_on(:technologies)
    @features = Project.tag_counts_on(:features)
  end

  def create
    new_position = params[:project].delete(:position).to_i
    @project = Project.new(params[:project])
    if @project.save
      @project.insert_at(new_position)
      flash[:notice] = 'Property type was successfully created.'
      redirect_to staff_project_path(@project)
    else
      @technologies = Project.tag_counts_on(:technologies)
      @features = Project.tag_counts_on(:features)
      @count = Project.count + 1
      render("new")
    end
  end

  def edit
    @project = Project.find(params[:id])
    @count = Project.count
    @technologies = Project.tag_counts_on(:technologies)
    @features = Project.tag_counts_on(:features)
  end

  def update
    new_position = params[:project].delete(:position).to_i
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      if new_position != @project.position
        @project.remove_from_list
        @project.insert_at(new_position)
      end
      flash[:notice] = 'Property type was successfully updated.'
      redirect_to staff_project_path(@project)
    else
      @technologies = Project.tag_counts_on(:technologies)
      @features = Project.tag_counts_on(:features)
      @count = Project.count
      render("edit")
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def delete
    # delete allows user to reconfirm the deletion before destroying it
    @project = Project.find(params[:id])
  end

  def destroy
    project = Project.find(params[:id])
    if project && project.destroy
      flash[:notice] = "The project was deleted."
    else
      flash[:notice] = "The project was not deleted."
    end
    redirect_to staff_projects_path
  end

end
