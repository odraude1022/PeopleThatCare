# README

This is a boilerplate Rails project that uses:

* `ruby ~> 2.5`
* `postgresql` as the database
* `webpacker` with `react`
* the `react_on_rails` gem

## Instructor Setup

* `git clone git@github.com:wyncode/final_project_template.git`
* `cd final_project_template`
* `git remote remove origin`
* Create a repo on GitHub that matches the project name
* `git remote add origin that-repo-name` && `git push origin -u master`
* Make `master` a [protected branch](https://help.github.com/articles/configuring-protected-branches/)
* Pull Requests should only be mergeable after 2 reviews
* At least 1 review needs to be from a [CODEOWNER](https://help.github.com/articles/about-codeowners/)
* Invite team members as collaborators with write access

## Student Setup

* `rails db:create` (with your Postgres server up and running)
* `rails s`

## Collaboration

* Talk to an instructor about the next feature / enhancement / bugfix you would like to address
* Create an issue with a User Story and Acceptance Criteria
* Create a branch that corresponds with your issue
* Submit a pull request into master
* Request a code review from one of your teammates
* Once it's approved, request a code review from one or more of the project's [CODEOWNERS](CODEOWNERS)

## Deployment

* `heroku create your-app-name`
* `heroku buildpacks:set heroku/ruby`
* `heroku buildpacks:add --index 1 heroku/nodejs`
* `git push heroku master`
* `heroku run rails db:migrate`

------------------------------------------------------------------------------------------------------------

People That Care - Non-Profit app

### Create Database models
* `rails g model NAME [field[:type][:index] field[:type][:index]] [options]`

### Create Database Controllers
* `rails g controller NAME [action action] [options]`

### Authentication users/charities
* session_controller
* `  def create
    var = Var.find_by(email: params[:session][:email].downcase)
    if var && var.authenticate(params[:session][:password])
      log_in user
      redirect_to var
    else
      render 'new', alert: 'Invalid email/password'
    end
  end
`

* var_controller

* Function to show the var from the database
* `def show
  @var = Var.find(params[:id])
end`

* Function to a new var at the database
* `def new
  @var = Var.new
end`

* Function to create a var at the database
* `def create
  @var = Var.new(user_params)
  if @var.save
    log_in @var
    redirect_to @var
  else
    render 'new'
  end
end`

### Database initialization

* `rails db:drop db:create db:migrate db:seed`
