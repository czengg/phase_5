class DojosController < ApplicationController

  skip_before_filter :check_login, :only => [:index, :show]

  def index
    @dojos = Dojo.active.alphabetical.paginate(:page => params[:page]).per_page(8)
  end

  def show
    @dojo = Dojo.find(params[:id])
  end
  
  def new
    @dojo = Dojo.new
    authorize! :new, @dojo
  end

  def edit
    @dojo = Dojo.find(params[:id])
    authorize! :update, @dojo
  end

  def create
    @dojo = Dojo.new(params[:dojo])
    if @dojo.save!
      # if saved to database
      flash[:notice] = "Successfully created #{@dojo.name} dojo"
      redirect_to @dojo # go to show dojo page
    else
      # return to the 'new' form
      render :action => 'new'
    end
    authorize! :new, @dojo
  end

  def update
    @dojo = Dojo.find(params[:id])
    if @dojo.update_attributes(params[:dojo])
      flash[:notice] = "Successfully updated #{@dojo.name} dojo"
      redirect_to @dojo
    else
      render :action => 'edit'
    end
    authorize! :update, @dojo
  end

  def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy
    flash[:notice] = "Successfully removed dojo from karate dojo system"
    # redirect_to dojos_url
    redirect_to @dojo # go to show dojo page
    authorize! :destroy, @dojo
  end
end