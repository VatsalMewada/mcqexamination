class Semester < ApplicationRecord

    has_many :users
    has_many :subjects 

end
