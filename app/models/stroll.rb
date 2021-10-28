class Stroll < ApplicationRecord
  belongs_to :dog_sitter
  belongs_to :dog
end
