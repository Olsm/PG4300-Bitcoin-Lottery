# Bitcoin Lottery

### Participants(2)

**Valmir Memeti**
* Github: Valmir95
* Email: Valmirmemeti@gmail.com
* Westerdals: memval14

**Olav Småriset**
* Github: Olsm
* Email: OlavSmaariset@gmail.com
* Westerdals: smaola14

## Description

**Oneliner: Jackpots on blockchain**

Bitcoin lottery is a project which addresses and battles a lot of the issues people have with the current lottery systems that have been used for so long. We aim to lower the fees of the lottery which will give people more incentive to play. A small fee can go to charity. Anonymity come first.

## Attachments:

* [LeanCanvas](documentation/LeanCanvas.pdf)
* [External API usage](documentation/API.JPG)
* [Project information](documentation/ProjectInformation.pdf)
* [Wireframes] (documentation/wireframes/)
* [Gherkin-based user stories (cucumber-features)](documentation/features/)

## Installation
Bitcoin lottery requires NodeJS 4.4.5 to work

Bitcoin lottery is a rails based application which is simple to maintain and build upon. 
Simply clone the repo and/or download the project.

Before starting to develop in any of the environments, remember to rake the database
    
```sh
#For the testing environment
rails db:migrate RAILS_ENV = test
#For the development environment
rails db:migrate RAILS_ENV = development
#For the production environment
rails db:migrate RAILS_ENV = production
```
and install all gems by doing the following:

```sh
bundle install
```
### Deploying

By the use of the Capistrano gem you can easily deploy the application to your web-server.

First, you need to specify the deploy options in deploy.rb:
```sh
lock '3.5.0'

set :application, 'application_name'
set :repo_url, 'git_repo'
#Default options. Change if you wish
set :scm, :git
set :branch, "master"
#Default option. Change if you wish to use a Super user.
set :use_sudo, false
#Change to what environment you wish to work on
set :rails_env, "your_ENV"
set :deploy_via, :copy
set :keep_releases, 5
set :pty, true
set :tmp_dir, "#{fetch(:home)}/tmp"
set :normalize_asset_timestamps, false
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
#Here you specify server address and user
server 'server_address', user: 'deployer', roles: %w{web app db}
```
Be sure to also setup the *database.yml* file correctly based on what environment you wish to deploy.

Finally run deploy
```sh
cap production deploy
```

## Limitations
Although we feel the project fullfills our original main goals, it is still not accurate to say that the application is in itself complete. Sure, the users are able to play the lottery and the main functions of the site work, but we still wish to improve on the users experience. If we had more time on the project we would improve on the following:
##### Design
Our design is very basic and uses Bootstrap 3 to add responsiveness to it. Because we did not have any dedicated designers in our team, we opted for a basic, functional design. We wish to expand on this and make the design more modern-looking and use more vibrant colors to attract users.
##### User benefits
As of now, by the help of the Devise gem, we have managed to develop a good registration/sign in system. We also used Omniauth to add social media logins for Google, Facebook and Twitter. We feel this makes it easier for new users to take part in the activities we have to offer. At this very moment, a user can't really do very much in the site. Apart from basic user actions, there aren't really that many benefits to reap from. If we had more time in our hand we would add some benefits for the user, for example choosing what wallet address they want to get paid to.

##### More cryptocurrencies
As of now users can only use Bitcoin to join the lottery, and although they can use services like ShapeShift, we want to add support for other cryptocurrencies, such as Litecoin, Dogecoin, and Ethereum.


## Tests

To run all unit tests

```sh
rake test
```

To run all features

```sh
bundle install
```

Note that most feature tests are not implemented yet

Tu run one feature

```sh
cucumber --require features features/contact.feature
```

## Contributors

The contributors of this project are: Valmir95 and Olsm

## License

TODO: A short snippet describing the license (MIT, Apache, etc.)