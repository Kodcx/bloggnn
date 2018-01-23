class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
  def index
  	@posts = Post.all.order("created_at DESC") # THis allows us to grab all of the posts from the model, and ordering by the created_at field (which is created by deafult) in descending order (so newest post appears at the top. Then we are setting that to the @posts instance variable)
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	if @post.save
  		redirect_to @post
  	else
  		render(new)
  	end
  end

  def show
  	# @post = Post.find(params[:id]) #for the show action, find the post by id. The id for each post is created by default, and each id is unique. This is how we are pulling data  from our model. Saving it as an instance variable. called @post
  end

  def edit
  	# @post = Post.find(params[:id])
  end

  def update
  	# @post = Post.find(params[:id]) These were removed to stay within DRY Principles. Created a find_post method below.
  	if @post.update(post_params)
  		redirect_to @post
  	else
  		render 'edit'
  	end
  end
  def destroy
  	@post.destroy
  	render_to root_path
  end
  private

  def find_post
  	@post = Post.find(params[:id])
  end

  def post_params
  	params.require(:post).permit(:title, :body) #rails 4 strong paramaters
  end

end
