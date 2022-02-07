class MoviesController < ApplicationController

  def index
    @movies = Movie.released
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
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:notice] = "Movie successfully updated!"
      redirect_to @movie
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie successfully deleted!"
    redirect_to movies_url
    
  end

private

  def movie_params
    params.required(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name)
  end
end
