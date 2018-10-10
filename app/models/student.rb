class Student < ApplicationRecord
  self.primary_key = 'student_id'

  has_and_belongs_to_many :families

  def self.active
    where( Arel.sql( 'grade is not null' ) )
  end

  def self.by_last_name
    order( :last_name, :first_name, :middle_name )
  end

  def full_name
    @full_name ||= "#{ first_name } #{ middle_name } #{ last_name }"
  end

  def list_name
    @list_name ||= "#{ last_name }, #{ first_name } #{ middle_name }"
  end

  def self.grade_letter_list( grade )
    select( 'substr( last_name, 1, 1 ) as letter' ).distinct.where( grade: grade ).sort
  end

  def self.grade_student_by_letter_list( grade, letter )
    where( grade: grade ).where( 'lower( substr( last_name, 1, 1 ) ) = ?', letter.downcase ).order( :first_name, :middle_name, :last_name )
  end

  def self.grade_student_list( grade )
    where( grade: grade ).order( :first_name, :middle_name, :last_name )
  end
end
