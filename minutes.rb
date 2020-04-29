# I think this is a good first run at the problem. Were I to revisit/refactor this in the future, I'd look for where
# the modulus operator could be implemented to DRY it up some.

# Adds minutes to a given time string and returns a new one.
#
# @example
#   add_minutes("9:13 AM", 200)
#   => "12:33 PM"
#
# @param [String] string
# @param [Integer] minutes
# @return [String, nil]
def add_minutes(string, minutes)
  return string if !minutes&.positive? || !minutes.is_a?(Integer)

  hours, min, am_pm = string.scan(/(\d{1,2}):(\d{2}) (AM|PM)/i).first
  return nil if hours.nil? || min.nil? || am_pm.nil?

  # Converting to 24-hour time to do the addition
  mil_hours = if am_pm.match?(/p/i)
                hours.to_i + 12
              else
                # For when time is midnight e.g. 12:01 AM
                hours.to_i == 12 ? 0 : hours.to_i
              end

  total_min = min.to_i + minutes

  hours_to_add = 0
  if total_min >= 60
    while total_min >= 60 do
      hours_to_add += 1
      total_min -= 60
    end
  end

  mil_hours += hours_to_add

  # Accounting for going beyond one day
  if mil_hours > 23
    while mil_hours >= 23 do
      mil_hours -= 24
    end
  end

  # Converting back to 12-hour time
  new_hour = if mil_hours > 12
               mil_hours - 12
             else
               mil_hours.zero? ? 12 : mil_hours
             end
  new_am_pm = mil_hours >= 12 ? 'PM' : 'AM'

  "#{new_hour}:#{'%.2d' % total_min} #{new_am_pm}"
end
