# frozen_string_literal: true

# name: discourse-event-description-limit
# about: TODO
# meta_topic_id: TODO
# version: 0.0.1
# authors: Discourse
# url: TODO
# required_version: 2.7.0

enabled_site_setting :discourse_event_description_limit_enabled

module ::DiscourseEventDescriptionLimit
  PLUGIN_NAME = "discourse-event-description-limit"
end

require_relative "lib/discourse_event_description_limit/engine"

after_initialize do
  # Code which should run after Rails has finished booting
end
