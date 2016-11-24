# Redmine Warehouse plugin

## Install

- Copy redmine_warehouse plugin to {RAILS_APP}/plugins on your redmine path
- Run bundle install --without development test RAILS_ENV=production
- Run rake redmine:plugins NAME=redmine_warehouse RAILS_ENV=production

## Uninstall

```
rake redmine:plugins NAME=redmine_warehouse VERSION=0 RAILS_ENV=production
rm -r plugins/redmine_warehouse
```

### Tables created by plugin

- goods

## Requirements

- Redmine 2.3+

## Test

```
bundle exec rake db:drop db:create db:migrate redmine:plugins RAILS_ENV=test
bundle exec rake test TEST="plugins/redmine_warehouse/test/**/*_test.rb" RAILS_ENV=test
```
