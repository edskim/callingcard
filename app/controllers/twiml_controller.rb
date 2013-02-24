require 'twilio-ruby'

class TwimlController < ApplicationController
  respond_to :xml

  def initiate
    @response = Twilio::TwiML::Response.new do |r|
      r.Gather action: "/pin", method: "GET" do |g|
        g.Say 'Please enter your pin followed by a pound sign'
      end
    end
    render xml: @response.text
  end

  def pin
    @response = Twilio::TwiML::Response.new do |r|
      if params[:Digits] && params[:Digits].gsub(/[*#]/,'') == '24208'
        r.Gather action: "/number", method: "GET" do |g|
          g.Say 'Please enter the number to call followed by a pound sign'
        end
      else
        r.Gather action: "/pin", method: "GET" do |g|
          g.Say 'That pin is incorrect. Please reenter your pin followed by a pound sign'
        end
      end
    end
    render xml: @response.text
  end

  def number
    @number = params[:Digits].gsub(/[*#]/,'') if params[:Digits]
    @number = @number || ''
    @response = Twilio::TwiML::Response.new do |r|
      if @number.length >= 10
        r.Dial do |d|
          d.Number @number
        end
      else
        r.Gather action: "/number", method: "GET" do |g|
          g.Say 'Invalid number entered. Please enter a valid number including the country or area code'
        end
      end
    end
    render xml: @response.text
  end
end
