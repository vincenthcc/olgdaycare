class Family < ApplicationRecord
  has_and_belongs_to_many :students
  has_many :daycare_entries

  def self.active
    includes( :students ).joins( :students ).where( Arel.sql( 'students.grade is not null' ) )
  end
end
