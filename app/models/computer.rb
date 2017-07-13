class Computer < ApplicationRecord
  belongs_to :computer, optional: true
  alias_attribute :parent, :computer

  belongs_to :user
  alias_attribute :owner, :user

  validates :serial, presence: true, allow_blank: false
  validates :ram, :processor, :space, numericality: true
  validates :wired_mac, :wireless_mac, mac_address: true, allow_blank: true

  enum status: [ :in_use, :available, :junk ]
  enum manufacturer: [ :"Apple", :"Dell", :"HP", :"Lenovo", :"Microsoft", :"Other" ]

  def title
    "#{name} | S/N: #{serial} #{" | P/N: #{product}" if !product.nil?}"
  end

  def date
    "#{updated_at.month}/#{updated_at.day}/#{updated_at.year}"
  end

  def possessive_name
    "#{owner.name}'s #{"#{manufacturer} " unless model.include? manufacturer}#{model} (#{status.humanize})"
  end

  def specs
    "RAM: #{ram} GB | Storage: #{space} GB | Processor: #{processor} GHz"
  end

  def macs
    "Wired MAC: #{wired_mac} | Wireless MAC: #{wireless_mac}"
  end

end
