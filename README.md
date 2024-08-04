

## scenarios

- io bound localhost:8080/cpu_intensive
- cpu bound localhost:8080/io_intensive

| unicorn workers | rails db pool | db connections | with pgbouncer pool size | transaction mode
| --- | --- | --- | --- | --- |
| 4 | 5 | 4*5 | 2 | session |
| 4 | 5 | 4*5 | 10 | session |
| 4 | 5 | 4*5 | 20 | session |



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