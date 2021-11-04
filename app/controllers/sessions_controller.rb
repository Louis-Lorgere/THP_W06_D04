class SessionsController < ApplicationController
  def new
    # @session = User.new
  end

  def create
    user = User.find_by(name: params[:name])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Vous êtes bien connecté'
      redirect_to gossips_path
      # redirige où tu veux, avec un flash ou pas

    else
      flash.now[:danger] = 'Invalid name/password combination'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to gossips_path
    flash[:success] = 'Vous êtes bien déconnecté'
  end

  private
  
  def post_params

  end
end
