# frozen_string_literal: true
class Notify
  attr_accessor :gmail
  def initialize(test_mode=false)
    @gmail = Gmail.connect(username, password)
    @test_mode = test_mode
  end

  def notify(products)
    email = gmail.compose
    email['to'] = recipient
    email['subject'] = 'Items in stock'
    email['body'] = message(products)

    Rails.logger.debug(email.body)
    email.deliver! unless test_mode?
  end

  def test_mode?
    @test_mode
  end

  private

  def message(products)
    products.reduce("") do |memo, product|
      memo + "\n#{product.url}"
    end
  end

  def recipient
    ENV['NOTIFYEE']
  end

  def username
    ENV['USERNAME'] || 'pironotifier@gmail.com'
  end

  def password
    ENV['PASSWORD']
  end
end
