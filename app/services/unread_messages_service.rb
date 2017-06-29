class UnreadMessagesService
  def initialize(user)
    @user = user
  end

  def count_messages
    user_conersation = Conversation.participating(@user)
    unread_messages = user_conersation.joins(:personal_messages).where('personal_messages.read=false')

    messages_count = unread_messages.size
    receiver_ids = unread_messages.uniq.pluck(:author_id, :receiver_id).flatten - [@user.id]

    params = { count: messages_count,
                receiver_ids: receiver_ids }
  end
end
