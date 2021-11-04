class GossipsController < ApplicationController
  
  before_action :authenticate_user, only: [:update, :new, :create, :edit, :destroy]

  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end


  def create
    # @gossip = Gossip.new(title: params[:gossip][:title], content: params[:gossip][:content], user_id: params[:gossip][:user_id]) # avec xxx qui sont les données obtenues à partir du formulaire
    @gossip = Gossip.new(post_params)
    if @gossip.save # essaie de sauvegarder en base @gossip
      flash[:success] = "Potin bien créé !"
      redirect_to '/'
      # si ça marche, il redirige vers la page d'index du site
    else
      render "new"
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    @gossip.update(post_params)
    redirect_to gossip_path
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path
    flash[:success] = "Potin bien supprimé"
  end

  private

  def post_params
    post_params = params.require(:gossip).permit(:title, :content, :user_id)
  end

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end
end
