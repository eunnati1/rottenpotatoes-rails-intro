class MoviesController < ApplicationController
helper_method :select_rating?

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index 
   @all_ratings = Movie.all_ratings
   
    session[:order] = params[:order] unless params[:order].nil?
    session[:ratings] = params[:ratings] unless params[:ratings].nil?
    

    if (params[:ratings].nil?) || (params[:order].nil?)
      redirect_to movies_path("ratings" => session[:ratings], "order" => session[:order])
      
    elsif !params[:ratings].nil? || !params[:order].nil?
      if !params[:ratings].nil?
        return @movies = Movie.where(rating: params[:ratings].keys).order(session[:order])
      else
        return @movies = Movie.order(params[:order])
      end
      
    elsif !session[:ratings].nil? || !session[:order].nil?
      flash.keep
      redirect_to movies_path("ratings" => session[:ratings], "order" => session[:order])
      
    else
      return @movies = Movie.all
    end
    
  end

  def new
    # default: render 'new' template
  end

  def select_rating?(rating)
    select_rating = params[:ratings]
     if select_rating.nil?
       return true
     end
    select_rating.include? rating
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

end