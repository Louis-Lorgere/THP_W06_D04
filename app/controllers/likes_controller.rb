class LikesController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :destroy]

  def create
    # @like = Like.new(title: params[:Like][:title], content: params[:Like][:content], user_id: params[:Like][:user_id]) # avec xxx qui sont les données obtenues à partir du formulaire
    @like = Like.new(likeable_id: params[:likeable_id], user_id: session[:user_id], likeable_type: params[:likeable_type])
    if @like.save # essaie de sauvegarder en base @like
      flash[:success] = "Like bien créé !"
      redirect_to request.referrer
      # si ça marche, il redirige vers la page d'index du site
    else
      render "new"
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end

  def destroy
    # @like = Like.find_by(id: params[:id].id)
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to request.referrer
    flash[:success] = "Like bien supprimé"
  end

  private

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
