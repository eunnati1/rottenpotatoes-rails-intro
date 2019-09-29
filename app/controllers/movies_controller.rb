class MoviesController < ApplicationController
  helper_method :hilight
  

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    session[:order] = params[:order] unless params[:order].nil?
    if (params[:order].nil? && !session[:order].nil?)
      redirect_to movies_path("order" => session[:order])
    elsif !params[:order].nil?
        return @movies = Movie.all.order(session[:order])
    elsif  !session[:order].nil?
      redirect_to movies_path("order" => session[:order])
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

end

def hilight(column)
    if(session[:order].to_s == column)
      return 'hilite'
    else
      return nil
    end
  end
