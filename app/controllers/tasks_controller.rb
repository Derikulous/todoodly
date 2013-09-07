class TasksController < ApplicationController
  respond_to :html, :xml, :js

  def create
  @list = List.find(params[:list_id])
  @task = @list.tasks.new(params[:list_id])
  if @task.save
    flash[:notice] = "Task Created"
    redirect_to list_url(@list)
  else
    flash[:error] = "Could not add task at this time"
    redirect_to list_url(@list)
  end
end
end
