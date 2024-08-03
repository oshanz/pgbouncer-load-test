class ApplicationController < ActionController::Base

    def index
        # sleep 10
        sql = "SELECT pg_sleep(3)"
        ActiveRecord::Base.connection.execute(sql)
        render plain: "Hello, world"
    end
end
