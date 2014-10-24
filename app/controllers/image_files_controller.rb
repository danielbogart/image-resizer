class ImageFilesController < ApplicationController
  before_action :set_image_file, only: [:show, :edit, :update, :destroy]

  # GET /image_files
  # GET /image_files.json
  def index
    @image_files = ImageFile.all
  end

  # GET /image_files/1
  # GET /image_files/1.json
  def show
  end

  # GET /image_files/new
  def new
    @image_file = ImageFile.new
  end

  # GET /image_files/1/edit
  def edit

  end

  # POST /image_files
  # POST /image_files.json
  def create
    @image_file = ImageFile.new(image_file_params)

    image = MiniMagick::Image.open(image_file_params[:png_file].tempfile.path)  

    @image_file.height = image["height"]
    @image_file.width = image["width"]
    @image_file.name = @image_file.name+'.png'
    image.write "public/images/#{@image_file.name}"

    respond_to do |format|
      if @image_file.save
        format.html { redirect_to @image_file, notice: 'Image file was successfully created.' }
        format.json { render :show, status: :created, location: @image_file }
      else
        format.html { render :new }
        format.json { render json: @image_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_files/1
  # PATCH/PUT /image_files/1.json
  def update

    respond_to do |format|
      if @image_file.update(image_file_params)
        image = MiniMagick::Image.open('public/images/'+@image_file.name) 
        image.crop "#{@image_file.width}x#{@image_file.height}+#{@image_file.width_offset}+#{@image_file.height_offset}!"
        image.write "public/images/#{@image_file.name}"
        format.html { redirect_to @image_file, notice: 'Image file was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_file }
      else
        format.html { render :edit }
        format.json { render json: @image_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_files/1
  # DELETE /image_files/1.json
  def destroy
    File.unlink('public/images/'+@image_file.name)
    @image_file.destroy
    respond_to do |format|
      format.html { redirect_to image_files_url, notice: 'Image file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_file
      @image_file = ImageFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_file_params
      params.require(:image_file).permit(:name, :height, :width, :png_file, :height_offset, :width_offset)
    end
end
