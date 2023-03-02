class UserSetting < RailsSettings::SettingObject
  COLOR_SCHEMES = { dark: "dark", light: "light" }

  def self.default_settings_proc
    Proc.new { |s|
      s.key :user_settings, defaults: { :color_scheme => COLOR_SCHEMES[:dark] }
    }
  end

  validates :color_scheme, :inclusion=> { :in => COLOR_SCHEMES.values }
end
