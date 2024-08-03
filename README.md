


- setup

```bash

docker-compose up

cd app
bundle install

 bundle exec unicorn -c config/unicorn.conf.rb
```


- Known issues

1. objc[69020]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called.
https://github.com/rails/rails/issues/38560

`export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES`