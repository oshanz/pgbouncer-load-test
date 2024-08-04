class ApplicationController < ActionController::Base
  def index
    render plain: 'Hello, world'
  end

  def cpu_intensive
    slow_code
    render plain: 'CPU Intensive'
  end

  def io_intensive
    if ActiveRecord::Base.connection_pool.stat[:connections] > 0
      puts "ActiveRecord::Base.connection_pool.stat[:connections]: #{ActiveRecord::Base.connection_pool.stat[:connections]}"
    end
    slow_query(1)

    render plain: 'IO Intensive'
  end

  def db_stats
    stats = ActiveRecord::Base.connection_pool.stat
    render json: stats
  end

  private

  def slow_query(seconds)
    sql = "SELECT pg_sleep(#{seconds})"
    ActiveRecord::Base.connection.execute(sql)
  end

  def slow_code
    # 1M -> 8s in m1 mac pro
    2_000_000.times do |i|
      Math.sqrt(i)
    end
  end

  def block_unicorn(seconds)
    sleep(seconds)
  end
end
