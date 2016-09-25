class BinariesController < ApplicationController
  protect_from_forgery except: [:index, :show, :update]
  def index
    @binaries = Binary.all.order("RANDOM()")
    render json: @binaries
  end

  def show
    @binary = Binary.find(params[:id])
    render json: @binary
  end

  def update
    @binary = Binary.find(params[:id])
    @choice = params[:choice]
    @binary.votesA += 1 if @choice == 'A'
    @binary.votesB += 1 if @choice == 'B'
    @binary.save
    render json: @binary
  end

  def create
    @params = JSON.load request.body
    @user = User.find(@params["id"].to_i)
    @binary = @user.binaries.new
    @binary.expiration = calculateTime(@params["type"], @params["number"], @params["timeNow"])
    @binary.votesA = 1
    @binary.votesB = 1
    @binary.choiceA = @params["choiceA"]
    @binary.choiceB = @params["choiceB"]
    @binary.name = @params["name"]
    @binary.content = @params["content"]
    @binary.save
    render json: @binary
  end

  def calculateTime(type,number,start)
    case type
      when "hours"
        return number * 1.hours.to_i + start
      when "days"
        return number * 1.days.to_i + start
      when minutes
        return number * 1.minutes.to_i + start
    end
  end
end
