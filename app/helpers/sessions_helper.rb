module SessionsHelper

  def log_in(employer)
    session[:employer_id] = employer.id
  end
end
