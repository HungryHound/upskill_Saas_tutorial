class CryptocurrenciesController < ApplicationController
  def new
    @cryptocurrency = Cryptocurrency.new
  end

  def create
    @cryptocurrency = Cryptocurrency.new(cryptocurrency_params)
    @cryptocurrency.save
    @coin = params[:cryptocurrency][:coin]
    @holding = params[:cryptocurrency][:holding]
    @purchase_price = params[:cryptocurrency][:purchase_price]
    
    
    params[:cryptocurrency].each do |value|
      puts value # should print the values for each input
    end
    
    redirect_to new_cryptocurrency_path
  end
  
  private
    def cryptocurrency_params
      params.require(:cryptocurrency).permit(:coin, :holding, :purchase_price)
    end  

end