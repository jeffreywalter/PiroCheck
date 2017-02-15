# frozen_string_literal: true
class Notify
  attr_accessor :gmail
  def initialize
    @gmail = Gmail.connect(username, password)
  end

  def notify(products)
    email = gmail.compose
    email['to'] = recipient
    email['subject'] = 'Items in stock'
    email['body'] = message(products)

    email.deliver!
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
