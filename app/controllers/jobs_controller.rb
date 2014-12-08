class JobsController < ApplicationController
  def index
  end

  def new
    @job = Job.new
  end
end
