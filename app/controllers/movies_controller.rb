class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort=params[:sort]
    @ratings = params[:ratings]
    @all_ratings = Movie.all_ratings
   
    if @sort==nil
      @check = ""
      @check1 = ""
    elsif @sort=="title"
      @check="hlite"
      @check1=""
    elsif @sort=="release_date"
        @check1="hlite"
        @check=""
    end
    
    if params[:ratings].nil?
      @ratings={}
      @all_ratings.each { |variable| @ratings[variable]=1}
      # @movies=Movie.all
    # else
      # @check = @ratings.include?(:all_rating)
      
    end
    @movies =Movie.order(@sort).all.where(rating:@ratings.keys)
  
    
    # @movies = Movie.where(:all, order: @sort)
    # condition: {raitings:@all_ratings},
    
    # @movies =Movie.order(@sort).all.where(condition: {raitings:@all_ratings})
    # @movies = Movie.all
    
    
    
    # @sort=params[:sort]
    # @movies =Movie.order(@sort).all
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
  
  def movie_update
    # @movie= Movie.find (params:[:title])
  end

  def movie_update2
    
      @movie= Movie.find_by_title(movie_params[:title])
      if @movie==nil
          flash[:notice] = "Movie Not Found"
      else
        if (movie_params[:rating]!="")
          @movie.update_attribute(:rating, movie_params[:rating])
        end
        flash[:notice] = " #{@movie.title} was successfully updated."
      end
      redirect_to movies_path
  end
  def delete
    @movies=Movie.all
  end
  def namedelete
    flash[:notice] = "Movie '#{@movie.title}' deleted."
  end
  def deleteRating
    
    @sort=params[:sort]
    @ratings = params[:ratings]
    @all_ratings = Movie.all_ratings
   
    
    if params[:ratings].nil?
      @ratings={}
      @all_ratings.each { |variable| @ratings[variable]=1}
    end
    @movies =Movie.where(rating:@ratings.keys)
    # redirect_to movies_path
  
    
    # @movies = Movie.where(:all, order: @sort)
    # condition: {raitings:@all_ratings},
    
    # @movies =Movie.order(@sort).all.where(condition: {raitings:@all_ratings})
    # @movies = Movie.all
    
    
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end