class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, except: [:index]
  before_action :check_participating!, except: [:index]

  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
  end

  def show
    @conversation = Conversation.find_by(id: params[:id])
    update_message_to_read(@conversation)
    @personal_message = PersonalMessage.new
  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
  end

  def update_message_to_read(conversation)
    messages = conversation.personal_messages

    if !messages.empty? && (messages.last.user != current_user)
      messages.update_all(read: true)
    end
  end

  def check_participating!
    redirect_to root_path unless @conversation && @conversation.participates?(current_user)
  end
end
