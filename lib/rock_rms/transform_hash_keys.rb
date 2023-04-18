module TransformHashKeys
  def self.camelize_keys(hash)
    hash
      .filter { |_, v| v }
      .transform_keys { |k| camelize(k) }
  end

  def self.camelize(term)
    term.to_s.gsub(/(?:^|_+)([^_])/) { $1.upcase }.tap { |s| s[0] = s[0].downcase }
  end
end
