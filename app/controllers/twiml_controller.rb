require 'twilio-ruby'

class TwimlController < ApplicationController
  respond_to :xml

  def initiate
    @response = Twilio::TwiML::Response.new do |r|
      r.Gather action: "/pin", method: "GET" do |g|
        g.Say 'Please enter your pin followed by a pound'
      end
    end
    render xml: @response.text
  end

  def pin
    @response = Twilio::TwiML::Response.new do |r|
      if params[:Digits] && params[:Digits].gsub(/[*#]/,'') == '24208'
        r.Gather action: "/number", method: "GET" do |g|
          g.Say 'Please enter the number to call followed by a pound'
        end
      else
        r.Gather action: "/pin", method: "GET" do |g|
          g.Say 'Wrong pin. Please reenter your pin followed by a pound'
        end
      end
    end
    render xml: @response.text
  end

  def number

  end
end
