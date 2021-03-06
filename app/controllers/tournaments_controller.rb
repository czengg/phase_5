class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.active.alphabetical.paginate(:page => params[:page]).per_page(8)
  end

  def show
    @tournament = Tournament.find(params[:id])
  end
  
  def new
    @tournament = Tournament.new
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    @tournament.date = Date.today
    if @tournament.save!
      # if saved to database
      flash[:notice] = "Successfully created #{@tournament.name}"
      redirect_to @tournament # go to show tournament page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      flash[:notice] = "Successfully updated #{@tournament.name}"
      redirect_to @tournament
    else
      render :action => 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    flash[:notice] = "Successfully removed tournament from karate tournament system"
    # redirect_to tournaments_url
    redirect_to @tournament # go to show tournament page
  end
end