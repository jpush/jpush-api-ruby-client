module JPush
  module Schedule
    class Trigger

      WEEK = ['MON','TUE','WED','THU','FRI','SAT','SUN']
      MDAY = ('01'..'31').to_a

      def set_single(time)
        @periodical = nil
        @single = { time: time.strftime('%F %T') }
        self
      end

      def set_periodical(start_time, end_time, time, time_unit, frequency, point)
        @single = nil
        require 'time'
        frequency = 100 if frequency > 100
        @periodical = {
          start: start_time.strftime('%F %T'),
          end: end_time.strftime('%F %T'),
          time: Time.parse(time).strftime('%T'),
          time_unit: time_unit,
          frequency: frequency,
          point: build_point(time_unit, point)
        }
        self
      end

      def to_hash
        @trigger = {}
        @trigger[:single] = @single unless @single.nil?
        @trigger[:periodical] = @periodical unless @periodical.nil?
        @trigger
      end

      private

        def build_point(time_unit, point)
          array = [point].flatten
          point =
            case time_unit.upcase
            when 'DAY'
              nil
            when 'WEEK'
              WEEK & array.map{ |e| e.upcase }
            when 'MONTH'
              MDAY & array
            end
        end

    end
  end
end
