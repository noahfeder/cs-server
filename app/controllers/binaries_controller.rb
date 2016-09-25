class BinariesController < ApplicationController
  protect_from_forgery except: [:index, :show, :update]
  def index
    @binaries = Binary.where("expiration >= :timenow", timenow: Time.now.to_i)
    render json: @binaries
  end

  def show
    @binary = Binary.find(params[:id])
    render json: @binary
  end

  def update
    @binary = Binary.find(params[:id])
    if (@binary.expiration > Time.now.to_i)
      @choice = params[:choice]
      @binary.votesA += 1 if @choice == 'A'
      @binary.votesB += 1 if @choice == 'B'
      @binary.save
      render json: @binary
    else
      render json: {error: true, message: "Sorry, voting for this decision has expired"}
    end
  end

  def create
    @params = JSON.load request.body
    @user = User.find(@params["id"].to_i)
    @binary = @user.binaries.new
    @binary.expiration = calculateTime(@params["type"], @params["number"])
    @binary.votesA = 1
    @binary.votesB = 1
    @binary.choiceA = @params["choiceA"]
    @binary.choiceB = @params["choiceB"]
    @binary.name = @params["name"]
    @binary.content = @params["content"]
    @binary.active = true
    @binary.username = @user.username
    @binary.save
    render json: @binary
  end

  def calculateTime(type,number)
    case type
      when "hours"
        return number.hours.to_i + Time.now.to_i
      when "days"
        return number.days.to_i + Time.now.to_i
      when "minutes"
        return number.minutes.to_i + Time.now.to_i
    end
  end
end
