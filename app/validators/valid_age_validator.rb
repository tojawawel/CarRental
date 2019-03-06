class ValidAgeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || " You must be over 18 years old!") if
      record.date_of_birth > 18.years.ago.to_date
  end
end
