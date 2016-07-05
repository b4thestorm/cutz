# This file contains descriptions of all your stripe plans

Stripe.plan :prime do |plan|
  plan.name = 'Cutz Barber Service'
  plan.amount = 1000
  plan.currency = 'usd'
  plan.interval = 'month'
  plan.interval_count = 1
  plan.trial_period_days = 30
end
#   # number of days before charging customer's card (default 0)
#   plan.trial_period_days = 30
# end

# Once you have your plans defined, you can run
#
#   rake stripe:prepare
#
# This will export any new plans to stripe.com so that you can
# begin using them in your API calls.
