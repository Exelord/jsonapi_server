# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { FFaker::Company.name }
  end
end
