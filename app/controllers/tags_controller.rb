class TagsController < ApplicationController
  before_action :set_user
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /users/1/tags
  def index
    @tags = @user.tags

    render json: @tags
  end

  # GET /users/1/tags/1
  def show
    render json: @tag
  end

  # POST /users/1/tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: [@user, @tag]
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1/tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1/tags/1
  def destroy
    @tag.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tag_params
    params.require(:tag).permit(:user_id, :name)
  end
end
