class GoodsController < ApplicationController
  unloadable

  before_filter :find_optional_project, :authorize
  before_filter :find_good, :only => [:show, :edit, :update, :destroy]
  before_filter :build_new_good_from_params, :only => [:new, :create]

  helper :sort
  include SortHelper

  def index
    sort_init 'name'
    sort_update %w(name)
    @goods = Good.all.order(sort_clause)
    @goods = @goods.search(params[:name]) if params[:name].present?
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def show
  end

  def new
  end

  def create
    raise ::Unauthorized unless Good.addable?(@project)
    if @good.save
      respond_to do |format|
        format.html {
          flash[:notice] = l(:notice_good_successful_create)
          if params[:continue]
            redirect_to new_project_good_path(@project, @good)
          else
            redirect_to project_good_path(@project, @good)
          end
        }
      end
      return
    else
      respond_to do |format|
        format.html {
          render :action => 'new'
        }
      end
    end
  end

  def edit
  end

  def update
    raise ::Unauthorized unless Good.editable?(@project)
    @good.safe_attributes = params[:good]
    if @good.save
      flash[:notice] = l(:notice_successful_update)
      respond_to do |format|
        format.html { redirect_to :action => "show", :project_id => @project, :id => @good }
      end
    else
      respond_to do |format|
        format.html { render "edit", :project_id => @project, :id => @good }
      end
    end
  end

  def destroy
    raise Unauthorized unless Good.deletable?(@project)
    begin
      @good.reload.destroy
    rescue ::ActiveRecord::RecordNotFound # raised by #reload if good no longer exists
      # nothing to do, good was already deleted (eg. by a parent)
    end
    respond_to do |format|
      format.html { redirect_to project_goods_path(@project) }
    end
  end

  private

  def build_new_good_from_params
    @good = Good.new
    attrs = (params[:good] || {}).deep_dup
    @good.safe_attributes = attrs
  end

  def find_good
    raise Unauthorized unless Good.visible?(@project)
    @good = Good.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
