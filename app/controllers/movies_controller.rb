class MoviesController < ApplicationController
helper_method :checked_ratings?

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index 
   
   #FOR SORTING OF MOVIE TITLE AND RELEASE DATE
   if (params[:order].nil?)
      redirect_to movies_path("order" => params[:order])
    elsif !params[:order].nil?
        return@movies = Movie.order(params[:order])
    else
      return @movies = Movie.all
    end
  
   
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

def checked_ratings?(rating)
    checked_ratings = params[:ratings]
    return true if checked_ratings.nil?
    checked_ratings.include? rating
  end

end