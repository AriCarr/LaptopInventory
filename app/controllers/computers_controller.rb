class ComputersController < ApplicationController
  before_action :set_computer, only: [:show, :edit, :update, :overwrite, :inplace, :destroy]
  before_action :gather_active
  before_action :require_admin, only: [:search, :search_results, :edit, :update, :overwrite, :inplace]

  # GET /computers
  # GET /computers.json
  def index
    computers = current_user.is_admin ? Computer.all : Computer.where(user: current_user)
    @computers = computers.where(history: false).sort_by(&:possessive_name)
  end

  def search
    gather_active
    index
  end

  def search_results
    @computers = !params[:user][:id].empty? ? User.find(params[:user][:id]).computers : Computer.all

    @computers = @computers.where(history: false)

    @computers = @computers.to_a

    @computers = @computers.select { |c| c.manufacturer == params[:manufacturer][:manufacturer]} if !params[:manufacturer][:manufacturer].empty?

    @computers = @computers.select { |c| c.status == params[:status][:status] } if !params[:status][:status].empty?

    @computers = @computers.select { |c| c.serial == params[:serial].upcase } unless params[:serial].empty?

    @computers = @computers.select { |c| c.model.downcase.include? params[:model].downcase } unless params[:model].empty?

    @computers = @computers.select { |c| margin_of_error(c.ram, params[:ram].to_f, 1) } unless params[:ram].empty?

    @computers = @computers.select { |c| margin_of_error(c.space, params[:space].to_f, 50) } unless params[:space].empty?

    respond_to do |format|
      format.js
    end
  end

  def margin_of_error(a, b, margin)
    (a-b).abs <= margin
  end

  # GET /computers/1
  # GET /computers/1.json
  def show
    if (@computer.history ||
        @computer.user != current_user) && !current_user.is_admin
      flash[:warning] = "Sorry, you can't see that computer!"
      redirect_to computers_path
    end
    gather_parents
  end

  def gather_parents
    @parents = []
    parent = @computer.parent
    while !parent.nil? do
      @parents << parent
      parent = parent.parent
    end
  end

  # GET /computers/new
  def new
    @computer = Computer.new(user: current_user)
    gather_active
  end

  # GET /computers/1/edit
  def edit
    gather_active
  end

  def gather_active
    @active_users = User.where(active: true).order(:name)
  end

  # POST /computers
  # POST /computers.json
  def create
    @computer = Computer.where(serial: params['computer']['serial'],
                               manufacturer: params['computer']['manufacturer'])
                               .sort_by(&:updated_at).last
    if @computer.nil?
      @computer = Computer.new(fixed_params)

      respond_to do |format|
        if @computer.save
          format.html { redirect_to @computer }
          format.json { render :show, status: :created, location: @computer }
        else
          format.html { render :new }
          format.json { render json: @computer.errors, status: :unprocessable_entity }
        end
      end
    else
      @computer.history = false
      @computer.save!
      update
    end
  end

  # PATCH/PUT /computers/1
  # PATCH/PUT /computers/1.json
  def update
    puts caller[0]
    set_parent if @computer.history != true
    respond_to do |format|
      if @computer.update(fixed_params)
        format.html { redirect_to @computer }
        format.json { render :show, status: :ok, location: @computer }
      else
        format.html { render :edit }
        format.json { render json: @computer.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_parent
    parent = @computer.dup
    parent.history = true
    # parent.save!
    @computer.parent = parent
  end

  # GET /computers/overwrite/1
  # GET /computers/overwrite/1.json
  def overwrite
    gather_active
  end

  def inplace
    respond_to do |format|
      if @computer.update(fixed_params)
        format.html { redirect_to find_child(@computer) }
        format.json { render :show, status: :ok, location: @computer }
      else
        format.html { render :edit }
        format.json { render json: @computer.errors, status: :unprocessable_entity }
      end
    end
  end

  def find_child(current)
    child = Computer.where(computer: current).first
    child.nil? ? current : find_child(child)
  end

  def fixed_params
    my_params = computer_params
    my_params[:serial].upcase!
    my_params[:wired_mac] = format_mac(computer_params[:wired_mac])
    my_params[:wireless_mac] = format_mac(computer_params[:wireless_mac])
    my_params[:comment_author] = @current_user.name
    my_params[:comments] = nil if (!@computer.nil? && @computer.comments == computer_params[:comments]) || computer_params[:comments] == ""
    my_params
  end

  def format_mac(mac)
    mac.upcase.delete('-:').scan(/\w{2}/).join(':')
  end

  # DELETE /computers/1
  # DELETE /computers/1.json
  def destroy
    @computer.destroy
    respond_to do |format|
      format.html { redirect_to computers_url, notice: 'Computer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_computer
      @computer = Computer.all.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def computer_params
      params.require(:computer).permit(:name, :status, :history, :user_id, :manufacturer, :model, :serial, :wired_mac, :wireless_mac, :product, :space, :processor, :ram, :comments, :comment_author)
    end
end
