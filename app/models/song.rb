class Song < ActiveRecord::Base
  include SongPresenter
  extend FriendlyId

  friendly_id :title, :use => :scoped, :scope => :user

  belongs_to :user

  validates_presence_of :artist, :title, :lyrics

  after_create :send_notifications

  scope :recent, order("created_at DESC")
  scope :count_grouped_by_day, select("count(*), date(created_at)").group("date(created_at)").order(:date)

  def should_generate_new_friendly_id?
    new_record?
  end

  def incr
    update_attribute(:views, views + 1)
  end

  private
  def send_notifications
    SongMailer.new_song(self).deliver
  end
end
