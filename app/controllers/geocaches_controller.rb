class GeocachesController < ApplicationController
  # GET /geocaches
  # GET /geocaches.json
  def index
    @geocaches = Geocache.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @geocaches }
    end
  end

  # GET /geocaches/1
  # GET /geocaches/1.json
  def show
    @geocach = Geocache.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @geocach }
    end
  end

  # GET /geocaches/new
  # GET /geocaches/new.json
  def new
    @geocach = Geocache.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @geocach }
    end
  end

  # GET /geocaches/1/edit
  def edit
    @geocach = Geocache.find(params[:id])
  end

  # POST /geocaches
  # POST /geocaches.json
  def create
    @geocach = Geocache.new(params[:geocach])

    respond_to do |format|
      if @geocach.save
        format.html { redirect_to @geocach, notice: 'Geocache was successfully created.' }
        format.json { render json: @geocach, status: :created, location: @geocach }
      else
        format.html { render action: "new" }
        format.json { render json: @geocach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /geocaches/1
  # PUT /geocaches/1.json
  def update
    @geocach = Geocache.find(params[:id])

    respond_to do |format|
      if @geocach.update_attributes(params[:geocach])
        format.html { redirect_to @geocach, notice: 'Geocache was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @geocach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geocaches/1
  # DELETE /geocaches/1.json
  def destroy
    @geocach = Geocache.find(params[:id])
    @geocach.destroy

    respond_to do |format|
      format.html { redirect_to geocaches_url }
      format.json { head :no_content }
    end
  end
end
