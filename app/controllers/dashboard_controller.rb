class DashboardController < ApplicationController
  def show
    @daily_counts = Post
      .where(created_at: 30.days.ago.beginning_of_day..Time.current)
      .group("DATE(created_at)")
      .count

    @monthly_counts = Post
      .where(created_at: 12.months.ago.beginning_of_month..Time.current)
      .group("DATE_FORMAT(created_at, '%Y-%m')")
      .count

    @total_posts = Post.count
    @posts_today = Post.where(created_at: Time.current.all_day).count
    @posts_this_week = Post.where(created_at: Time.current.all_week).count
    @posts_this_month = Post.where(created_at: Time.current.all_month).count
  end
end
