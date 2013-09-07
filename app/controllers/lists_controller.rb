class ListsController < ApplicationController
  respond_to :html, :xml, :js

  def index
    respond_with(@list = List.all)
  end

  def new
    @list = List.new
  end
end

def create
  @list = List.new(params[:list])
  if @list.save
    flash[:notice] = "List Created"
    respond_with(@list, :location => list_url(@list))
  else
    flash[:error] = "Could not create list"
    redirect_to new_list_url
  end

  def show
    @list = List.find(params[:id])
    @task = @list.tasks.new
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
  @list = List.find(params[:list])
  if @list.update_attributes(params[:list])
    flash[:notice] = "List updated"
    redirect_to list_path(@list)
  else
    flash[:error] = "Could not update list"
    redirect_to edit_list_path(@list)
  end

  def destroy
    @list = List.find(params[:id])
    if @list.destroy(params[:list])
    flash[:notice] = "List deleted"
    redirect_to lists_url
  else
    flash[:error] = "Could not delete list. Have you done everything?"
    redirect_to lists_url
  end
end

def complete
  @list = List.find(params[:list_id])
  @task = @list.tasks.find(params[:id])
  @task.completed = true
  @task.save
  redirect_to list_url(@list)
end
end
end
