class ProfilesController < ApplicationController
  
  # GET to /users/:users/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end
end
