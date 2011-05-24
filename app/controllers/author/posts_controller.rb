class Author::PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  before_filter :require_author, :except => [:show]
  
  def index
    @posts = Post.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(params[:post])
    @post.published_at = Time.now if @post.published
    respond_to do |format|
      if @post.save
        format.html { redirect_to [:author, @post], notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = current_user.posts.find(params[:id])
    @post.published_at = Time.now if (params[:post][:published] && @post.published_at.nil?)
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to [:author, @post], notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    if (@post.user_id == current_user.id)
      @post.destroy
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { head :ok }
      end
    else 
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'You do not have permission to delete this post' }
        format.json { head :ok }
      end
    end
  end
end
