class TeamsController < ApplicationController
  def index
    @teams = current_user.all_teams
  end

  def change_current_team
    if params[:id].to_i.in?(current_user.all_team_ids)
      current_user.update(current_team_id: params[:id])
    end

    redirect_to root_path
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.owner = current_user
    if @team.save
      redirect_to teams_path
    else
      render :new
    end
  end

  def edit
    @team = current_user.owned_teams.find(params[:id])
  end

  def update
    @team = current_user.owned_teams.find(params[:id])
    if @team.update(team_params)
      redirect_to teams_path
    else
      render :edit
    end
  end

  def destroy
    @team = current_user.owned_teams.find(params[:id])
    @team.destroy
    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
