class TopicsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  before_action :topic_find, only: [:show, :edit, :update, :destroy, :comments, :del_topic_comment]

  before_action :find_topic_and_check_permission, only: [:edit, :update, :destroy]

  def index
    category = Category.find(params[:category]) if params[:category]
    if (params[:last] == "latest")
      @topics = Topic.all.order("comment_last DESC").page(params[:page]).per(5)
    elsif (params[:order] == "comments_count" )
      @topics = Topic.all.order("comments_count DESC").page(params[:page]).per(5)
    elsif (params[:views] == "views_count" )
      @topics = Topic.all.order("views_count DESC").page(params[:page]).per(5)
    elsif category
      @topics = category.topics.order("created_at DESC").page(params[:page]).per(5)
    else
      @topics = Topic.all.order("id ASC").page(params[:page]).per(5)
    end
  end

  def new
    @topic = Topic.new
    @photo = @topic.build_photo
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
    @photo = @comment.build_photo

    @views_count = @topic.views_count
    @views_count =  @views_count + 1
    @topic.update( :views_count => @views_count ) #:views_count是只要更新此欄位
  end

  def edit
    @photo = @topic.build_photo
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
    @comment = @topic.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @topic.comment_last = @comment.created_at
    @topic.save
      redirect_to topic_path(@topic)
  end

  def about
    @users = User.count
    @topics = Topic.count
    @comments = Comment.count
  end

  def del_topic_comment
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to topic_path(@topic)
  end



  private

  def find_topic_and_check_permission
    if @topic.user_id != current_user.id
      redirect_to topics_path, alert: "You have no permission."
    end
  end

  def topic_find
    @topic = Topic.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, photo_attributes: [:id, :image])
  end

  def topic_params
    params.require(:topic).permit(:name,
                                  :date,
                                  :description,
                                  :content,
                                  photo_attributes: [:id, :image],
                                  :category_ids => [])
  end

end
