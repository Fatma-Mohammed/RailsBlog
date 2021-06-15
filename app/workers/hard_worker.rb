class HardWorker
  include Sidekiq::Worker

  def perform(post_id)

    post = Post.find_by_id(post_id)
    puts post
    if post
      post.destroy
    end

  end
end
