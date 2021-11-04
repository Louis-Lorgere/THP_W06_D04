class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:update, :new, :create, :edit, :destroy]
  before_action :is_connected, only: [:show]

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    puts "#" * 30
    puts params
    puts "#" * 30
    @comment = Comment.new
    @commentable_id = params[:commentable_id]
    @commentable_type = params[:commentable_type]
    puts "#" * 30
    puts @commentable_id
    puts @commentable_type
    puts "#" * 30
  end


  def create
    # @comment = Comment.new(title: params[:Comment][:title], content: params[:Comment][:content], user_id: params[:Comment][:user_id]) # avec xxx qui sont les données obtenues à partir du formulaire
    @comment = Comment.new(post_params)
    if @comment.save # essaie de sauvegarder en base @comment
      flash[:success] = "Commentaire bien créé !"
      redirect_to '/'
      # si ça marche, il redirige vers la page d'index du site
    else
      render "new"
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(post_params)
    redirect_to comments_path
    flash[:success] = "Commentaire bien modifié"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path
    flash[:success] = "Commentaire bien supprimé"
  end

  private

  def post_params
    post_params = params.require(:comment).permit(:title, :content, :user_id, :commentable_id, :commentable_type)
  end

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

  def is_connected
    unless session[:user_id]
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end
end
