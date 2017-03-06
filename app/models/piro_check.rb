# frozen_string_literal: true
class PiroCheck
  attr_accessor :products

  def initialize(products, notifier=nil)
    @products = products
    @notifier = notifier
  end

  def check
    to_notify = products.select do |product|
      if in_stock?(product)
        product.notify_count += 1
        product.in_stock = true
        product.save
      end
    end

    notifier.notify(to_notify) if to_notify.count > 0
  end

  def in_stock?(product)
    Rails.logger.debug(product.url)
    case product.url
    when /pirofliprc/
      doc = Nokogiri::HTML(open(product.url))
      name = doc.css('head > title').first.text
      if name != product.name
        product.update_attribute(:name, name)
      end
      doc.css('div#availability').first.text == 'In Stock'
    when /racedayquads/
      shopify_in_stock?(product)
    when /droneeclipse/
      shopify_in_stock?(product)
    else
      false
    end
  end

  def notifier
    @notifier ||= Notify.new
  end

  def browser
    @browser ||= Watir::Browser.new :phantomjs
  end

  def shopify_in_stock?(product)
    browser.goto product.url
    name = browser.execute_script('return SPOParams.product.variants[0].name')
    if name != product.name
      product.update_attribute(:name, name)
    end
    browser.execute_script('return SPOParams.product.variants[0].inventory_quantity > 0')
  end
end
