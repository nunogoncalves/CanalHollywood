require 'rubygems'
require 'nokogiri'
require 'open-uri'

module Html
  class GetHtmlDocumentForUrl < UseCase::Base

    def perform
      url = context.url
      context.document = Nokogiri::HTML(open(url))
    end

  end
end