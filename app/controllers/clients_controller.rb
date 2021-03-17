class ClientsController < ApplicationController
  before_action :logged_in_user, only: [:index, :getclient]
  def index
  end

  def getclient
    @clients = Client.all
    render :json => @clients
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_index_path
    else
      redirect_to clients_index_path
    end
  end

  private

  def client_params
    params.fetch(:client, {}).permit(
        :company,:name,:phone,:email
      )
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
