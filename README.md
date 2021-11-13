# BLOG

Building a blog using Ruby on Rails 6 in MVC pattern.

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      3.0.2
    </td>
  </tr>
  <tr>
    <td>Rails version</td>
    <td>
      6.1.4.1
    </td>
  </tr>
  <tr>
    <td>Database</td>
    <td>
      PostgreSQLs
    </td>
  </tr>
</table>

## Getting Started

```bash
# clone the project
git clone https://github.com/Joao-MCF/blog.git

# enter the cloned directory
cd blog

# install Ruby on Rails dependencies
bundle install

# install Node dependencies
yarn install

# create the development and test databases and the tables
rails db:create && rails db:migrate
rails db:migrate RAILS_ENV=test

# run the project
rails s
```

## Running specs

```bash
# Default: Run all spec files (i.e., those matching spec/**/*_spec.rb)
$ bundle exec rspec

# See all options for running specs
$ bundle exec rspec --help
```

## Author

João Marcos C. Ferreira - Code and Documentation [Linkedin](https://www.linkedin.com/in/joao-mcf/)
