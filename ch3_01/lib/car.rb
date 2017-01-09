class Car

  attr_accessor :make, :year, :color, :doors
  attr_reader :wheels

  def initialize(options={})
    self.make = options[:make] || 'Volvo'
    self.year = (options[:year] || 2007).to_i
    self.color = options[:color] || 'unknown'
    self.doors = ([2, 4].include?(options[:doors]) ? options[:doors] : 4).to_i
    @wheels = 4
  end

  def self.colors
    ['blue', 'black', 'red', 'green']
  end

  def full_name
    "#{self.year.to_s} #{self.make} (#{self.color})"
  end

  def coupe?
    doors == 2
  end

  def sedan?
    doors == 4
  end

end
