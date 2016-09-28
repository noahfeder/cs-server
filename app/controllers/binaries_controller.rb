class BinariesController < ApplicationController
  protect_from_forgery except: [:index, :show, :update, :user]
  def index
    @binaries = Binary.where("expiration >= :timenow", timenow: Time.now.to_i)
    render json: @binaries
  end

  def user
    @binaries = Binary.where(user_id: params[:id])
    if @binaries[0].nil?
      render json: {error: true, message: "You haven't asked for any help yet!"}
    else
      render json: @binaries
    end
  end

  def show
    @binary = Binary.find(params[:id])
    render json: @binary
  end

  def update
    @params = JSON.load request.body
    @binary = Binary.find(params[:id])
    if (@binary.expiration > Time.now.to_i)
      @vote = @binary.votes.find_by_user_id(@params["user_id"])
      if @vote.nil?
        @choice = @params["choice"]
        @binary.votes.create({
          user_id: @params["user_id"],
          value: @choice
        })
        @binary.votesA += 1 if @choice == 1
        @binary.votesB += 1 if @choice == 2
        @binary.save
        render json: @binary
      else
        render json: {error: true, message: "Can't vote twice!"}
      end
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
