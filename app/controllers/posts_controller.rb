class PostsController < ApplicationController
  def new
    @post = post.new
  end

  def create
    post = post.new(post_params)
end
