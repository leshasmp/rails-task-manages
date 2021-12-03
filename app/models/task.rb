class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }

  state_machine initial: :new_task do
    event :developming do
      transition new_task: :in_development, in_qa: :in_development, in_code_review: :in_development
    end
    event :archived do
      transition new_task: :archived, released: :archived
    end
    event :tested do
      transition in_development: :in_qa
    end
    event :considered do
      transition in_qa: :in_code_review
    end
    event :preparation_for_release do
      transition in_code_review: :ready_for_release
    end
    event :issued do
      transition ready_for_release: :released
    end
  end
end
