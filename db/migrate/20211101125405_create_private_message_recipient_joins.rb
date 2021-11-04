class CreatePrivateMessageRecipientJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :private_message_recipient_joins do |t|
      t.references :private_message, foreign_key: true
      t.references :recipient, index: true

      t.timestamps
    end
  end
end
