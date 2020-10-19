require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#this is where I will mount other controller 'use'


#in order to send PATCH and DELETE requests I need this code 'use Rack::MethodOverride'
use Rack::MethodOverride

use UsersController
use EventsController
use DishesController
run ApplicationController
