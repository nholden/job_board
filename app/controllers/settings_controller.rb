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
      array_position = 0
      params[:new_experiences].each do |label|
        unless label.blank?
          experience = Experience.create(label: label)
          positions[experience.id] = params[:new_experience_positions][array_position].to_i
        end
        array_position += 1
      end
    end
    params.each do |key, value|
      if key.to_s.match(/\Aexperience_\d*\Z/)
        existing_experience_id = key.to_s.match(/\Aexperience_(.*)/)[1].to_i
        existing_experience = Experience.find(existing_experience_id)
        if value.blank?
          if existing_experience.destroy_and_reassign_jobs
            flash[:notice] = "Experiences saved."
            redirect_to '/settings' and return
          else
            flash[:error] = existing_experience.errors.full_messages[0]
            redirect_to '/settings' and return
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
    if Experience.reposition(positions)
      flash[:notice] = "Experiences saved."
    else
      flash[:error] = "Multiple experiences can't have the same position."
    end
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
    else
      flash[:error] = experience.errors.full_messages[0]
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
      if key.to_s.match(/\Aterm_\d*\Z/)
        existing_term_id = key.to_s.match(/\Aterm_(.*)/)[1].to_i
        existing_term = Term.find(existing_term_id)
        if value.blank?
          if existing_term.destroy_and_reassign_jobs
            flash[:notice] = "Terms saved."
            redirect_to '/settings' and return
          else
            flash[:error] = existing_term.errors.full_messages[0]
            redirect_to '/settings' and return
          end
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
    if term.destroy_and_reassign_jobs
      flash[:notice] = "Term deleted."
      redirect_to '/settings'
    else
      flash[:error] = term.errors.full_messages[0]
      redirect_to '/settings'
    end
  end
end
