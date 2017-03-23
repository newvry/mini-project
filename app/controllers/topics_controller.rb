class TopicsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  before_action :topic_find, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    # @topic = Topic.new(topic_params)
    # @topic.user_id = current_user.id
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topic_path
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy

    redirect_to topics_path
  end

  private

  def topic_find
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name, :date, :description)
  end

end
