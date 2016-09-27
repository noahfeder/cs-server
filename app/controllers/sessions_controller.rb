class SessionsController < ApplicationController
  protect_from_forgery except: [:create, :destroy, :newuser]

  def create
    @params = JSON.load request.body
    username = @params["username"].downcase
    password = @params["password"]
    @user = User.find_by_username(username).try(:authenticate, password)
    if !@user
      render json: {error: true, message: "Invalid username/password"}
    else
      render json: {error: false, message: "Success", data: @user}
    end
  end

  def newuser
    @params = JSON.load request.body
    @user = User.create({
      username: @params["username"].strip.downcase,
      password: @params["password"]
    })
    if @user.id.nil?
      render json: {error: true, message: "Invalid username/password"}
    else
      render json: {error: false, message: "Success", data: @user}
    end
  end

  def destroy
  end
end
