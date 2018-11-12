class MatyakaDataRecordsController < ApplicationController
  
  def index
    @matyaka_data_records = MatyakaDataRecord.where("
                                                      account_name LIKE ?
                                                      OR 
                                                      site_url_address LIKE ?
                                                      OR
                                                      advertising_group LIKE ?
                                                      OR
                                                      remaining_funds LIKE ?
                                                    ",
                                                      "%#{params[:search]}%",
                                                      "%#{params[:search]}%",
                                                      "%#{params[:search]}%",
                                                      "%#{params[:search]}%"
                                                    )
  end
  
  def show
  end
  
  def new
    @matyaka_data_record = MatyakaDataRecord.new
  end
  
  def edit
  end
  
  def create
    @matyaka_data_record = MatyakaDataRecord.new(data_params)
    if @matyaka_data_record.save
      flash[:success] = "Data Saved"
      redirect_to matyaka_data_entry_path
    else
      flash[:danger] = @matyaka_data_record.errors.full_messages.join(", ")
      redirect_to matyaka_data_entry_path
    end
  end
  
  def destroy
    @matyaka_data_record.destroy
  end
  
  def update
    @matyaka_data_record.update(data_params)
  end
    
  private
    def data_params
      params.require(:matyaka_data_record).permit(
                                                  :account_name,
                                                  :site_url_address,
                                                  :advertising_group,
                                                  :remaining_funds
                                                  )
    end
end
