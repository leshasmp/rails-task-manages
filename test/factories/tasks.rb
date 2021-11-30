FactoryBot.define do
  factory :task do
    name { "MyString" }
    description { "MyText" }
    author factory: :manager
    assignee factory: :manager
    expired_at { "2021-11-22" }
  end
end
