class DojosController < ApplicationController

  def index
    @dojos = Dojo.active.alphabetical.paginate(:page => params[:page]).per_page(8)
  end

  def show
    @dojo = Dojo.find(params[:id])
  end
  
  def new
    @dojo = Dojo.new
  end

  def edit
    @dojo = Dojo.find(params[:id])
  end

  def create
    @dojo = Dojo.new(params[:dojo])
    if @dojo.save!
      # if saved to database
      flash[:notice] = "Successfully created #{@dojo.name}"
      redirect_to @dojo # go to show dojo page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @dojo = Dojo.find(params[:id])
    if @dojo.update_attributes(params[:dojo])
      flash[:notice] = "Successfully updated #{@dojo.name}"
      redirect_to @dojo
    else
      render :action => 'edit'
    end
  end

  def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy
    flash[:notice] = "Successfully removed dojo from karate dojo system"
    # redirect_to dojos_url
    redirect_to @dojo # go to show dojo page
  end
end