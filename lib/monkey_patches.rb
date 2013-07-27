class String
  def underscore
    gsub(/([a-z])([A-Z])/,'\1_\2').downcase
  end

  def titleize
    gsub(/[-_]([a-z])/, ' \1')
  end
end

