class PageController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
  end

  def dashboard
    unread_messages_info = UnreadMessagesService.new(current_user).count_messages
    @messages_count = unread_messages_info[:count]
    @users = User.find(unread_messages_info[:receiver_ids])
  end
end
