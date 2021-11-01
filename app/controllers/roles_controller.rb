class RolesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /roles or /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1 or /roles/1.json
  def show
    if @role.users.empty?
      @assosciated_user = 'None'
    else
      @assosciated_users = @role.users.map(&:name).join(', ')
    end
  end

  # GET /roles/new
  def new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles or /roles.json
  def create
    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: "Role was successfully created." }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: "Role was successfully updated." }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: "Role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def role_params
      params.require(:role).permit(:name, :description)
    end
end
