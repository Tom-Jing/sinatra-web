This website is written in Ruby and Sinatra by Yuguang Jing

Address: https://sintra-gambapp.herokuapp.com/
Test: Yjing097/test


If you want to try on ur own machine, please use macOS(windows will cause error)

step 1: make sure you have installed bundler, "gem install bundler"

Optional: if you got the error because of: "pg" and "do_postgresql" please enter this line in your terminal: "brew install postgresql"
ref: "https://stackoverflow.com/questions/6040583/cant-find-the-libpq-fe-h-header-when-trying-to-install-pg-gem"


(.db file already created for u to test, use "Yjing097/qweasdsc" to login or sign up to create a new account to test, if want a new db please delete player.db and read step 2)
step 2: run: "ruby player.rb" to create a database file in current directory


step 3: run: "ruby main.rb", go to your browser enter "localhost:4567" and sign up