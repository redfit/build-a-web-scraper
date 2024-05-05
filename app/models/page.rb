class Page < ApplicationRecord
  has_many :results
  belongs_to :last_result, class_name: "Result"

  validates :name, presence: true
  validates :url, presence: true
  validates :check_type, presence: true
  validates :selector, presence: true
  validates :match_text, presence: { if: -> { check_type == 'text' } }

  def run_check!
    scraper = Scraper.new(url)
    result = case check_type
             when "text"
               scraper.text(selector: selector).downcase == match_text.downcase
             when "exists"
               scraper.present?(selector: selector)
             when "not_exists"
               !scraper.present?(selector: selector)
             end

    results.create(success: result)
    update(last_result: result)
  end
end
