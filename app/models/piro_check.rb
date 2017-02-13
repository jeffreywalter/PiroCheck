# frozen_string_literal: true
class PiroCheck
  attr_accessor :products

  def initialize
    @products = Product.where('notify_count < 3')
  end

  def check
    products.each do |product|
      if in_stock?(product)
        # send text
        product.notify_count += 1
        product.in_stock = true
        product.save
      else
        # no op?
      end
    end
  end

  def in_stock?(product)
    doc = Nokogiri::HTML(open(product.url))
    name = doc.css('head > title').first.text
    if name != product.name
      product.update_attribute(:name, name)
    end
    return doc.css('div#availability').first.text == 'In Stock'
  end
end

