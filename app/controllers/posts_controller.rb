class PostsController < ApplicationController
	# GET /posts
	# GET /posts.xml
	def index
		@posts = Post.find(:all)
		@user = current_user

		respond_to do |format|
			format.html # index.html.erb
			format.xml { render :xml => @posts }
		end
	end

	# GET /posts/1
	# GET /posts/1.xml
	def show
		@post = Post.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml { render :xml => @post }
		end
	end

	# GET /posts/new
	# GET /posts/new.xml
	def new
		raise params.to_yaml
		@post = Post.new
		

		respond_to do |format|
			format.html # new.html.erb
			format.xml { render :xml => @post }
		end
	end

	# GET /posts/1/edit
	def edit
		@post = Post.find(params[:id])
	end

end
