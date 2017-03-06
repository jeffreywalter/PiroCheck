# frozen_string_literal: true
task check: :environment do
  desc 'Check for in stock items'
  products = Product.where('notify_count < 3')
  checker = PiroCheck.new(products)
  checker.check
end
