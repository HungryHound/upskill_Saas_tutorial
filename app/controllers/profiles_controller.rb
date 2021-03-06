class ProfilesController < ApplicationController
  before_action :authenticate_user! # Can limit to specific actions by using ,only: [:new, :edit]
  before_action :only_current_user
  
  # GET to /users/:users/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end
  
  # POST request to /user/:user_id/profile
  def create
    # Ensure that we have user who is filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:sucess] = "Profile updated!"
      redirect_to user_path( id: params[:user_id] )
    else
      render action: :new
    end
  end
  
  # GET to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  #PUT to /users/:user_id/profile
  def update
    #Retrieve the user from db
    @user = User.find ( params[:user_id] )
    #Retreve taht user's profile
    @profile = @user.profile
    #Mass assign edited profile attributes and save (update)
    if @profile.update_attributes(profile_params)
      flash[:sucess] = "Profile updated!"
      #Redirect user to their profile page
      redirect_to user_path( id: params[:user_id] )
    else
      render action: :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title,
        :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find ( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
end
