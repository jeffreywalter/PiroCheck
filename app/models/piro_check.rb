# frozen_string_literal: true
class PiroCheck
  attr_accessor :urls

  def initialize(urls)
    @urls = urls
  end

  def check
    availability = urls.map do |url|
      doc = Nokogiri::HTML(open(url.last))
      stock = doc.css('div#availability').first.text == 'In Stock'
      name = doc.css('head > title').first.text
      [name, stock]
    end

    availability.each do |row|
      if row.last
        puts "#{row.first} : #{row.last}"
        # TODO check to see if we sent 3 texts
        # if not, send text, increment txt count
        # else mark product as notified
      end
    end
  end
end

