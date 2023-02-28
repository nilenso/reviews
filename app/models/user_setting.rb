class UserSetting < RailsSettings::SettingObject
  COLOR_SCHEMES = { dark: "dark", light: "light" }

  def self.default_settings_proc
    Proc.new { |s|
      s.key :user_settings, defaults: { :color_scheme => COLOR_SCHEMES[:dark] }
    }
  end

  validate do
    unless COLOR_SCHEMES.values.include?(self.color_scheme)
      errors.add(:color_scheme, "should be one of #{COLOR_SCHEMES.values.to_sentence}")
    end
  end
end
