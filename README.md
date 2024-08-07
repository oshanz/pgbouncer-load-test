

## scenarios

- io bound localhost:8080/cpu_intensive
- cpu bound localhost:8080/io_intensive


100 vus, 10s

| unicorn workers | rails db pool | db connections | with pgbouncer pool size | transaction mode | throughput | 95th percentile |  
| --- | --- | --- | --- | --- | --- | --- |
| 4 | 5 | 4*5 | 2 | session | 6 | 30798.33 |
| 4 | 5 | 4*5 | 10 | session | 13 | 30823.54 |
| 4 | 5 | 4*5 | 30 | session | 12 | 30832.44 |
| 4 | 1 | 4*1 | 30 | session | 12 | 30221.89 |



### setup
```bash

docker-compose up
cd app
bundle install
bundle exec unicorn -c config/unicorn.conf.rb
```

### run k6
```bash
brew install k6
k6 run script.js
# docker-compose run k6 run /app/script.js
```


### Known issues

1. objc[69020]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called.
https://github.com/rails/rails/issues/38560

`export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES`


### Notes

-  https://eoinkelly.info/2023/01/06/rails-and-pgbouncer-notes#rails-and-pgbouncer
- https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing


 - select count(*) from pg_stat_activity where pid <> pg_backend_pid() and usename = current_user;

 SELECT
  pid,
  user,
  pg_stat_activity.query_start,
  now() - pg_stat_activity.query_start AS query_time,
  query,
  state,
  wait_event_type,
  wait_event
FROM pg_stat_activity

- psql -U postgres -h localhost -p 6432 pgbouncer
show pools;