class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }

  state_machine initial: :new_task do
    event :to_dev do
      transition new_task: :in_development
    end
    event :archive do
      transition new_task: :archived
    end
    event :to_qa do
      transition in_development: :in_qa
    end
    event :qa_to_dev do
      transition in_qa: :in_development
    end
    event :qa_to_dev do
      transition in_qa: :in_code_review
    end
    event :code_review_to_ready_for_release do
      transition in_code_review: :ready_for_release
    end
    event :code_review_to_in_dev do
      transition in_code_review: :in_development
    end
    event :to_release do
      transition ready_for_release: :released
    end
    event :release_to_archive do
      transition released: :archived
    end
  end
end
