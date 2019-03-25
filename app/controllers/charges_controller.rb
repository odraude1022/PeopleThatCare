class ChargesController < ApplicationController
  def new
    @charity = Charity.find(params[:charity_id].to_i)
  end

  def create
    charge_params
    @amount = params[:amount]
    @token = params[:stripeToken]

    @amount = @amount.gsub('$', '').gsub(',', '')

    begin
      @amount = Float(@amount).round(2)
    rescue
      flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
      redirect_to new_charge_path
      return
    end

    @amount = (@amount * 100).to_i # Must be an integer!

    if @amount < 500
      flash[:error] = 'Charge not completed. Donation amount must be at least $5.'
      redirect_to new_charge_path
      return
    end

    Stripe::Charge.create({
      amount: @amount,
      currency: 'usd',
      source: @token,
      description: 'Custom donation',
    })

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  private

  def charge_params
    params.permit(:amount, :stripeToken, :charity_id)
  end
end
