class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_user, only: [:have_user]
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all.order("created_at DESC")
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new

    @team = current_user.creating_teams.new

  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create

    @team = current_user.creating_teams.new(team_params)
    @team.users << current_user

    respond_to do |format|

      if @team.save
        format.html {redirect_to root_path, notice: '项目组已创建。'}
        format.json {render :show, status: :created, location: @team}
      else
        format.html {render :new}
        format.json {render json: @team.errors, status: :unprocessable_entity}

      end
    end


    #手动存储
    # @team = current_user.creating_teams.new(create_team_params)
    # create_user_params.each do |user_param|
    #   if(!user_param[:_destroy])
    #     user_param.delete("_destroy")
    #     user = User.new(user_param)
    #     @team.users << user
    #   end
    #
    # end
    # @team.users << current_user
    # respond_to do |format|
    #   if @team.save
    #     format.html { redirect_to root_path, notice: '项目组已创建。' }
    #     format.json { render :show, status: :created, location: @team }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @team.errors, status: :unprocessable_entity }
    #
    #   end
    #
    #
    # end

  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html {redirect_to root_path, notice: '项目组信息已修改'}
        format.json {render :show, status: :ok, location: @team}
      else
        format.html {render :edit}
        format.json {render json: @team.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html {redirect_to teams_url, notice: 'Team was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def have_user
    @teams = @user.teams
    render :index
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :created_by, users_attributes: [:id, :name, :email, :_destroy])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def create_team_params
    params.require(:team).permit(:name, :created_by)
  end

  def create_user_params
    params.require(:team).require(:users).map! {|user| user.permit(:name, :email, :_destroy)}
  end

end
