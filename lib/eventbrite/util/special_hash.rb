class SpecialHash < Hash
  include Hashie::Extensions::StringifyKeys
  include Hashie::Extensions::Coercion
  include Hashie::Extensions::MethodAccess
  include Hashie::Extensions::DeepMerge

  def initialize(hash = {})
    super
    hash.each_pair do |k,v|
      self[k] = v
    end
  end

  # Hack to make sure that subclasses coerce Hash to SpecialHash
  def self.strict_value_coercions
    (@strict_value_coercions ||= {})[Hash] = SpecialHash
    @strict_value_coercions
  end
end
