# bctogh(Basecamp to Github migrator)
 
Github is a great place to manage a software based project. With the new 
version of issues, existing wikis, version control, permissions, etc. it's a great
tool for the job.
 
Currently just supports a simple migration of todos from Basecamp to issues on
Github.

## Running

* Ensure you have Ruby 2.1.1 installed via rbenv or RVM
* Copy .env.example to .env and fill in your credentials
* Run `bundle install` to install all gems
* Run `ruby migrate.rb`
