class CitiesController < ApplicationController
  before_action :authenticate_user, only: [:update, :new, :create, :edit, :destroy]

  def index
    @cities = City.all
  end

  def show
    @city = City.find(params[:id])
  end

  def new
    @city = City.new
  end


  def create
    @city = City.new(post_params)
    if @city.save # essaie de sauvegarder en base @city
      flash[:success] = "Ville bien créé !"
      redirect_to '/'
      # si ça marche, il redirige vers la page d'index du site
    else
      render "new"
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end

  def edit
    @city = City.find(params[:id])
    
  end

  def update
    @city = City.find(params[:id])
    @city.update(post_params)
    redirect_to cities_path
    flash[:success] = "Ville bien modifié"
  end

  def destroy
    @city = City.find(params[:id])
    @city.destroy
    redirect_to cities_path
    flash[:success] = "Ville bien supprimé"
  end

  private

  def post_params
    post_params = params.require(:city).permit(:name)
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
