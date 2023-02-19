stock_app
==============
### Technologies:

* ruby:2.7.2
* rails:5.2.8.1

Development
-----------

##### Environment setup

1. Run `bundle`
2. rails db:create
3. rails db:migrate
4. RAILS_ENV=test rails db:create
5. RAILS_ENV=test rails db:migrate

##### Run tests

`bundle exec rspec`

###### Usage
/login -> Sign Up page
/users -> All users
/portfolios -> All user portfolios
/portfolios/new -> Create a new Portfolio
/portfolios/:portfolio_id -> Portfolio page with a certain id
/portfolios/:portfolio_id/investments/new -> Create a new Investment
/portfolios/:portfolio_id/investments/:investment_id -> Investment in a portfolio by a certain id