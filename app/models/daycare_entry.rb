class DaycareEntry < ApplicationRecord
  belongs_to :family, optional: true
  belongs_to :student
  belongs_to :teacher, class_name: 'User', optional: true

  before_save :_before_save

  default_scope{ where( archive: nil ) }

  def self.by_student_last_name
    order( 'students.last_name, students.first_name, students.middle_name' )
  end

  def self.checked_in( date = nil, grade = nil )
    ci = joins( :student ).where( checkin_date: date, checkout_time: nil ).where( 'checkin_time is not null' )
    ci = ci.where( students: { grade: grade } ) unless grade.nil?

    ci
  end

  def checkin_time_display
    return '' if checkin_time.nil?

    ( checkin_time + 8.hours ).strftime( '%l:%M %p' )
  end

  def checkin_time_input
    return '' if checkin_time.nil?

    ( checkin_time + 8.hours ).strftime( '%H:%M' )
  end

  def checkout_time_display
    return '' if checkout_time.nil?

    ( checkout_time + 8.hours ).strftime( '%l:%M %p' )
  end

  def checkout_time_input
    return '' if checkout_time.nil?

    ( checkout_time + 8.hours ).strftime( '%H:%M' )
  end

  private

    def _before_save
      self.total_time = ( ( ( checkout_time.utc - checkin_time.utc ) / 3_600.0 * 60.0 ).ceil / 60.0 ).round( 2 ) if checkout_time.present? && checkin_time.present?
    end
end
