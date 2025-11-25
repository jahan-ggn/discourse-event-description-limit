# frozen_string_literal: true

class IncreaseDescriptionLengthForEvents < ActiveRecord::Migration[8.0]
  def change
    change_column :discourse_post_event_events, :description, :text
  end
end