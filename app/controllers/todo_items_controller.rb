class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]
  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      redirect_to @todo_list, notice: 'Successfully content created'
    end
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.destroy
    redirect_to @todo_list, notice: 'Successfully content destroyed'
  end

  def complete
    @todo_item.completed_at=  Time.now
    @todo_item.save
    redirect_to @todo_list, notice: "Todo item completed"
  end

  private
  def todo_item_params
    params.require(:todo_item).permit(:content)
  end

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end
end
