class ClientsController < ApplicationController
  before_action :logged_in_user, only: [:index, :getclient, :destroy]
  def index
  end

  def getclient
    @clients = Client.all
    render :json => @clients
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = "登録しました！"
      redirect_to clients_index_path
    end
  end

  def destroy
    @client = Client.find(params[:id])
    if @client.destroy
      flash[:success] = "#{client.company} を削除しました!"
      redirect_to clients_index_path
    end
  end

  private

  def client_params
    params.fetch(:client, {}).permit(
      :company, :name, :phone, :email, :user_id
    )
  end
end
