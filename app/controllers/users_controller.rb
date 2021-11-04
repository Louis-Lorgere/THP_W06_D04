class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    puts params[:user]
    # @user = User.new(name: params[:user][:name], password: params[:user][:password], city_id: params[:user][:city_id]) # avec xxx qui sont les données obtenues à partir du formulaire
    @user = User.new(post_params)
    if @user.save # essaie de sauvegarder en base @gossip
      redirect_to '/'
      # si ça marche, il redirige vers la page d'index du site
    else
      render "new"
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    post_params = params.require(:user).permit(:name, :password, :city_id)
  end
end
