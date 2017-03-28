class TopicsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  before_action :topic_find, only: [:show, :edit, :update, :destroy, :comments]

  def index
    category = Category.find(params[:category]) if params[:category]
    if (params[:last] == "latest")
      @topics = Topic.all.order("comment_last DESC").page(params[:page]).per(5)
    elsif (params[:order] == "comments_count" )
      @topics = Topic.all.order("comments_count DESC").page(params[:page]).per(5)
    elsif category
      @topics = category.topics.order("created_at DESC").page(params[:page]).per(5)
    else
      @topics = Topic.all.order("id ASC").page(params[:page]).per(5)
    end
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
    @comments = Topic.find(params[:id]).comments
    @comment = Comment.new
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

  def comments
    @comments = @topic.comments.new(comment_params)
    @comments.save
    @topic.comment_last = @comments.created_at
    @topic.save
    @topic.comments_count
    @topic.save

      redirect_to topic_path(@topic)
  end

  def about
    @users = User.count
    @topics = Topic.count
    @comments = Comment.count
  end

  private

  def topic_find
    @topic = Topic.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def topic_params
    params.require(:topic).permit(:name,
                                  :date,
                                  :description,
                                  :content,
                                  :category_ids => [])
  end

end
