class Movie < ActiveRecord::Base
    def self.all_ratings
        ['R','PG-13','G','PG']
    end
end
