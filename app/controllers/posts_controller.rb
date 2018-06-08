class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_id, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all.order('created_at desc')
    @posts_count = current_user.posts.length
  end
  
  def new
  end
  
  def create
    new_post = Post.new(user_id: current_user.id, content: params[:content], image: params[:image])
    if new_post.save
      redirect_to root_path
    else
      redirect_to new_post_path
    end
  end
  
  def edit
    #@post = Post.find_by(id: params[:id])
  end
  
  def update
    #@post = Post.find_by(id: params[:id])
    #redirect_to root_path if @post.user_id != current_user.id
    
    @post.content = params[:content]
    
    if @post.save
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def destroy 
    #@post = Post.find_by(id: params[:id])
    #redirect_to root_path if @post.user_id != current_user.id
    
    @post.destroy
    redirect_to root_path
  end
  
  def show
    @myposts = Post.where(user_id: [current_user.id, Follow.find_by(followed_id: params[:followed_id], follower_id: current_user.id)])
    @posts_count = current_user.posts.length
  end
  
  private
    def check_id
      @post = Post.find_by(id: params[:id])
      redirect_to root_path if @post.user_id != current_user.id
    end
  
  
end
