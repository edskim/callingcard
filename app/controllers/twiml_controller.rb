require 'twilio-ruby'

class TwimlController < ApplicationController
  respond_to :xml

  def initiate
    @response = Twilio::TwiML::Response.new do |r|
      r.Gather action: "/pin", method: "GET" do |g|
        g.Say 'Please enter your pin'
      end
    end
    render xml: @response.text
  end

  def pin
    puts params[:Digits]
  end

  def number

  end
end
