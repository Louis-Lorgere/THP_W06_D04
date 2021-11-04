class PagesController < ApplicationController
  def home
    @gossips = Gossip.all
  end

  def welcome
    if params[:name] == "" || params[:name] == nil
      @name = "Je ne connais pas ton blaze, je n'ai pas pu personnaliser ce message..."
      @path = "=> http://localhost:3000/home/TonBlaze"
    else
      @name = params[:name]
    end
  end

  def team
    @team = ["Tim","Got","Louis","Xav"]
  end

  def contact

  end

  def gossip
    @gossip = Gossip.find(params[:id])
  end

  def user
    @user = User.find(params[:id])
  end
end
