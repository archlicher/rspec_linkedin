class SubjectsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_subject, :only => [:show, :edit, :update, :delete, :destroy]
  before_action :set_subject_count, :only => [:new, :create, :edit, :update]

  def index
    logger.debug("################# Testing logger.")
    @subjects = Subject.sorted
  end

  def show
  end

  def new
    @subject = Subject.new({:name => 'Default'})
  end

  def create
    # init new object wil vals
    @subject = Subject.new(subject_params)
    # save ?
    if @subject.save
      # succ
      flash[:notice] = "Subject #{@subject.name} created successfully!"
      redirect_to(subjects_path)
    else
      # fail
      flash[:error] = "Something went wrong"
      render('new')
    end
  end

  def edit
  end

  def update
    # save ?
    if @subject.update_attributes(subject_params)
      # succ
      flash[:notice] = "Subject #{@subject.name} updated!"
      redirect_to(subject_path(@subject))
    else
      # fail
      flash[:error] = "Something went wrong"
      render('edit')
    end
  end

  def delete
  end

  def destroy
    @subject.destroy
    flash[:notice] = "Subject #{@subject.name} deleted!"
    redirect_to(subjects_path)
  end

  private

  def find_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  def set_subject_count
    @subject_count = Subject.count
    if params[:action] == 'new' || params[:action] == 'create'
      @subject_count += 1
    end
  end
end
