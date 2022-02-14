class MoviesController < ApplicationController

  before_action :require_signin, except:[:index, :show]
  before_action :require_admin, except:[:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
   case params[:filter]
   when "upcoming"
    @movies = Movie.upcoming
   when "recent"
    @movies = Movie.recent
   else
    @movies = Movie.released
   end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "Movie successfully created!"
      redirect_to @movie
    else
      render :new
    end
  end

  def show
    @fans = @movie.fans
    @genres = @movie.genres.order(:name)
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      flash[:notice] = "Movie successfully updated!"
      redirect_to @movie
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    flash[:notice] = "Movie successfully deleted!"
    redirect_to movies_url
    
  end

private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end

  def movie_params
    params.required(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids:[])
  end
end
