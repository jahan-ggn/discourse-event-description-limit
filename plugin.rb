# frozen_string_literal: true

# name: discourse-event-description-limit
# about: Adds a site setting to control event description length.
# version: 0.0.1
# authors: Jahan Gagan
# url: https://github.com/jahan-ggn/discourse-event-description-limit

enabled_site_setting :discourse_event_description_limit_enabled

module ::DiscourseEventDescriptionLimit
  PLUGIN_NAME = "discourse-event-description-limit"
end

require_relative "lib/discourse_event_description_limit/engine"

after_initialize do
  next unless SiteSetting.discourse_event_description_limit_enabled
  next unless defined?(DiscoursePostEvent::Event)

  event_class = DiscoursePostEvent::Event

  if event_class.const_defined?(:MAX_DESCRIPTION_LENGTH)
    event_class.send(:remove_const, :MAX_DESCRIPTION_LENGTH)
  end
  event_class.const_set(:MAX_DESCRIPTION_LENGTH, SiteSetting.event_description_max_length)

  event_class.validators_on(:description).dup.each do |validator|
    event_class._validators[:description].delete(validator)
  end

  event_class._validate_callbacks.dup.each do |callback|
    filter = callback.filter
    if filter.respond_to?(:attributes) &&
       filter.attributes.include?(:description)
      event_class._validate_callbacks.delete(callback)
    end
  end

  event_class.validate do
    max = SiteSetting.event_description_max_length.to_i
    if description.present? && description.length > max
      errors.add(:description, "is too long (maximum is #{max} characters)")
    end
  end
end





