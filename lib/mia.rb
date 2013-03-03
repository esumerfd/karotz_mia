class Mia
  @@interactive_id = ""

  def self.interactive_id=(value)
    @@interactive_id = value
  end

  def self.interactive_id
    @@interactive_id
  end

  def interactive_id=(value)
    Mia.interactive_id = value
  end

  def interactive_id
    Mia.interactive_id
  end
end
