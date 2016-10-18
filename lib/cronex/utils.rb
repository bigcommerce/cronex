module Cronex
  module Utils
    extend self

    def present?(str)
      !str.to_s.strip.empty?
    end

    def include_any?(str, chars)
      chars.any? { |char| str.include?(char) }
    end

    def number?(str)
      !!number(str)
    end

    def number(str)
      Integer(str.sub(/^0*(\d+)/,'\1')) rescue nil
    end

    def day_of_week_name(number)
      Date::DAYNAMES[number.to_i % 7]
    end

    def format_minutes(minute_expression)
      if minute_expression.include?(',')
        minute_expression.split(',').map { |m| format('%02d', m) }.join(',')
      else
        format('%02d', minute_expression)
      end
    end

    def format_time(hour_expression, minute_expression, second_expression = '')
      hour = hour_expression.to_i
      period = hour >= 12 ? 'PM' : 'AM'
      hour -= 12 if hour > 12
      minute = minute_expression.to_i
      minute = format('%02d', minute)
      second = ''
      if Cronex::Utils.present?(second_expression)
        second = second_expression.to_i
        second = ':' + format('%02d', second)
      end
      format('%s:%s%s %s', hour, minute, second, period)
    end
  end
end
