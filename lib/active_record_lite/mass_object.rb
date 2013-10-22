class MassObject
  def self.my_attr_accessible(*attributes)
    # first need to standardize as strings
    @attributes = attributes.map { |attr_name| attr_name.to_sym }

    attributes.each do |attribute|
      # creates setter/getter methods for attributes
      attr_accessor attribute
    end
  end

  def self.attributes
    @attributes
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end


  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      if self.class.attributes.include?(attr_name)
        self.send("#{attr_name}=", value)
      else
        raise "mass assignment to unregistered attribute #{attr_name}"
      end
    end
  end
end
