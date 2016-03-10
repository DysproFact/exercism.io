class ConversationSubscription < ActiveRecord::Base
  def self.join(user, iteration)
    create(user_id: user.id, solution_id: iteration.user_exercise_id)
  rescue ActiveRecord::RecordNotUnique
    # Do nothing. If they've already explicitly subscribed or unsubscribed, we
    # don't want to override their decision when they participate in a conversation.
  end

  # Explicitly toggle subscription to 'on'.
  def self.subscribe(user, iteration)
    create(user_id: user.id, solution_id: iteration.user_exercise_id)
  rescue ActiveRecord::RecordNotUnique
    where(user_id: user.id, solution_id: iteration.user_exercise_id).update_all(subscribed: true)
  end

  # Explicitly toggle subscription to 'off'.
  def self.unsubscribe(user, iteration)
    where(user_id: user.id, solution_id: iteration.user_exercise_id).update_all(subscribed: false)
  end
end
