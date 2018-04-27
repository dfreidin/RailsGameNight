class GroupsController < ApplicationController
  before_action :set_group, except: [:create]
  before_action :auth_group_owner, only: [:add_member, :remove_member, :update_name, :destroy]

  def create
    @group = Group.new
    @group.owner = @user
    @group.members = [@user]
    @group.name = "New Group"
    if @group.save
      redirect_to groups_show_path(@group.id)
    else
      redirect_to root_path
    end
  end

  def add_member
    params[:new_members].each {|u| @group.members += [User.find_by(username: u)]}
    redirect_to groups_show_path(@group.id)
  end

  def remove_member
    @group.members.delete(User.find_by(username: params[:username]))
    redirect_to groups_show_path(@group.id)
  end

  def leave
    @group.members.delete(@user) unless @group.owner == @user
    redirect_to root_path
  end

  def destroy
    @group.destroy
    redirect_to root_path
  end

  def update_name
    @group.update(name: params[:group][:name])
    redirect_to groups_show_path(@group.id)
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end
  def auth_group_owner
    redirect_to groups_show_path(@group.id) unless @group.owner == @user
  end
end
