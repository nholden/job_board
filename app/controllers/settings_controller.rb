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
    if !params[:new_experiences].nil?
      params[:new_experiences].each do |experience|
        Experience.create(label: experience) unless experience.blank?
      end
    end
    params.each do |key, value|
      if key.to_s.match(/experience_(.*)/)
        existing_experience_id = key.to_s.match(/experience_(.*)/)[1].to_i
        existing_experience = Experience.find(existing_experience_id)
        if value.blank?
          existing_experience.destroy_and_reassign_jobs
        elsif existing_experience.label != value
          existing_experience.label = value
          existing_experience.save
        end
      end    
    end
    flash[:notice] = "Experiences saved."
    redirect_to '/settings'
  end

  def destroy_experience
    experience = Experience.find(params[:id])
    flash[:error] = "You must be logged in as an administrator to edit settings." unless is_admin?
    redirect_to '/login' and return unless logged_in?
    redirect_to root_url and return unless is_admin?
    if experience.destroy_and_reassign_jobs
      flash[:notice] = "Experience deleted."
      redirect_to '/settings'
    end
  end

  def update_terms
    flash[:error] = "You must be logged in as an administrator to edit settings." unless is_admin?
    redirect_to '/login' and return unless logged_in?
    redirect_to root_url and return unless is_admin?
    if !params[:new_terms].nil?
      params[:new_terms].each do |term|
        Term.create(label: term) unless term.blank?
      end
    end
    params.each do |key, value|
      if key.to_s.match(/term_(.*)/)
        existing_term_id = key.to_s.match(/term_(.*)/)[1].to_i
        existing_term = Term.find(existing_term_id)
        if value.blank?
          existing_term.destroy
        elsif existing_term.label != value
          existing_term.label = value
          existing_term.save
        end
      end    
    end
    flash[:notice] = "Terms saved."
    redirect_to '/settings'
  end

  def destroy_term
    term = Term.find(params[:id])
    flash[:error] = "You must be logged in as an administrator to edit settings." unless is_admin?
    redirect_to '/login' and return unless logged_in?
    redirect_to root_url and return unless is_admin?
    if term.destroy
      flash[:notice] = "Term deleted."
      redirect_to '/settings'
    end
  end
end
