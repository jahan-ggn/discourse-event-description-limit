# frozen_string_literal: true

DiscourseEventDescriptionLimit::Engine.routes.draw do
  get "/examples" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw { mount ::DiscourseEventDescriptionLimit::Engine, at: "discourse-event-description-limit" }
