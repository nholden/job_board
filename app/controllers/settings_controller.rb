class SettingsController < ApplicationController
  def edit
    flash[:error] = "You must be logged in as an administrator to edit settings." unless is_admin?
    redirect_to '/login' and return unless logged_in?
    redirect_to root_url and return unless is_admin?
  end

  def update_experiences
    flash[:error] = "You must be logged in as an administrator to edit settings." unless is_admin?
    redirect_to '/login' and return unless logged_in?
    redirect_to root_url and return unless is_admin?
    params[:new_experiences].each do |experience|
      Experience.create(label: experience) unless experience.blank?
    end
    redirect_to '/settings'
  end
end
