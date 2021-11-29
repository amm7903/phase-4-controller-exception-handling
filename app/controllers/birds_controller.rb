class BirdsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = find_bird
    render json: bird
    # if bird
    #   render json: bird
    # else
    #   render json: { error: "Bird not found" }, status: :not_found
    # end
  end

  # PATCH /birds/:id
  def update
      bird = find_bird
      bird.update(bird_params)
      render json: bird
    # else
    #   render json: { error: "Bird not found" }, status: :not_found
    # end
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = Bird.find_by(id: params[:id])
    bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    # else
    #   render json: { error: "Bird not found" }, status: :not_found
    # end
  end

  # DELETE /birds/:id
  def destroy
    bird = find_bird
      bird.destroy
      head :no_content
      render json: bird
    # else
    #   render json: { error: "Bird not found" }, status: :not_found
    # end
  end

  private

  def find_bird
    # Bird.find_by(id: params[:id])
    Bird.find(params[:id])
  end

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def error_not-found_response
    render json : {error: "Bird not found"}, status: :not_found
  end
end
