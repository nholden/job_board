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
    positions = {}
    if !params[:new_experiences].nil?
      params[:new_experiences].each_with_index do |label, index|
        unless label.blank?
          experience = Experience.create(label: label)
          positions[experience.id] = params[:new_experience_positions][index].to_i
        end
      end
    end
    params.each do |key, value|
      if key.to_s.match(/\Aexperience_\d*\Z/)
        existing_experience_id = key.to_s.match(/\Aexperience_(.*)/)[1].to_i
        existing_experience = Experience.find(existing_experience_id)
        if value.blank?
          unless existing_experience.destroy_and_reassign_jobs
            flash[:error] = existing_experience.errors.full_messages[0]
          end
        elsif existing_experience.label != value
          existing_experience.label = value
          existing_experience.save
        end
      elsif key.to_s.match(/\Aexperience_\d*_position\Z/)
        existing_experience_id = key.to_s.match(/\Aexperience_(.*)_position\Z/)[1].to_i
        positions[existing_experience_id] = value.to_i
      end
    end
    unless Experience.reposition(positions)
      flash[:error] = "Multiple experiences can't have the same position."
    end
    flash[:notice] = "Experiences saved." if flash[:error].blank?
    redirect_to '/settings'
  end

  def destroy_experience
    experience = Experience.find(params[:id])
    flash[:error] = "You must be logged in as an administrator to edit settings." unless is_admin?
    redirect_to '/login' and return unless logged_in?
    redirect_to root_url and return unless is_admin?
    if experience.destroy_and_reassign_jobs
      flash[:notice] = "Experience deleted."
    else
      flash[:error] = experience.errors.full_messages[0]
    end
    Experience.refresh_positions
    redirect_to '/settings'
  end

  def update_terms
    flash[:error] = "You must be logged in as an administrator to edit settings." unless is_admin?
    redirect_to '/login' and return unless logged_in?
    redirect_to root_url and return unless is_admin?
    positions = {}
    if !params[:new_terms].nil?
      params[:new_terms].each_with_index do |label, index|
        unless label.blank?
          term = Term.create(label: label)
          positions[term.id] = params[:new_term_positions][index].to_i
        end
      end
    end
    params.each do |key, value|
      if key.to_s.match(/\Aterm_\d*\Z/)
        existing_term_id = key.to_s.match(/\Aterm_(.*)/)[1].to_i
        existing_term = Term.find(existing_term_id)
        if value.blank?
          unless existing_term.destroy_and_reassign_jobs
            flash[:error] = existing_term.errors.full_messages[0]
          end
        elsif existing_term.label != value
          existing_term.label = value
          existing_term.save
        end
      elsif key.to_s.match(/\Aterm_\d*_position\Z/)
        existing_term_id = key.to_s.match(/\Aterm_(.*)_position\Z/)[1].to_i
        positions[existing_term_id] = value.to_i
      end
    end
    unless Term.reposition(positions)
      flash[:error] = "Multiple terms can't have the same position."
    end
    flash[:notice] = "Terms saved." if flash[:error].blank?
    redirect_to '/settings'
  end

  def destroy_term
    term = Term.find(params[:id])
    flash[:error] = "You must be logged in as an administrator to edit settings." unless is_admin?
    redirect_to '/login' and return unless logged_in?
    redirect_to root_url and return unless is_admin?
    if term.destroy_and_reassign_jobs
      flash[:notice] = "Term deleted."
    else
      flash[:error] = term.errors.full_messages[0]
    end
    Term.refresh_positions
    redirect_to '/settings'
  end
end
