# Banken::DSL

[![Build Status](https://travis-ci.org/yhirano55/banken-dsl.svg?branch=master)](https://travis-ci.org/yhirano55/banken-dsl)
[![Gem Version](https://badge.fury.io/rb/banken-dsl.svg)](https://badge.fury.io/rb/banken-dsl)

This plugin gives directly define query methods to the controller for a Banken loyalty class by DSL

## Installation

``` ruby
gem "banken-dsl"
```

Include Banken in your application controller:

``` ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Banken
  protect_from_forgery
end
```

Optionally, you can run the generator, which will set up an application loyalty
with some useful defaults for you:

``` sh
rails g banken:install
```

After generating your application loyalty, restart the Rails server so that Rails
can pick up any classes in the new `app/loyalties/` directory.

## Usage

This plugin provides DSL to define query methods to the Controller without creating a loyalty class:

``` ruby
# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  authorization_policy do
    index   { true }
    show    { true }
    create  { user.admin? }
    update  { user.admin? && record.unpublished? }
    destroy { user.admin? && record.unpublished? }
  end

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end
end
```

You can define the loyalty class by `authorization_policy` method as same as this code:

```ruby
# app/loyalties/posts_loyalty.rb
class PostsLoyalty < ApplicationLoyalty
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? && record.unpublished?
  end

  def destroy?
    user.admin? && record.unpublished?
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
