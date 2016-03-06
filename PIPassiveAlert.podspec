Pod::Spec.new do |s|
  s.name             = "PIPassiveAlert"
  s.version          = "0.0.4"
  s.summary          = "A passive alert"
  s.description      = "A passive alert."
  s.homepage         = "https://github.com/prolificinteractive/PIPassiveAlert"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.authors          = { "Prolifc Interactive" => "info@prolificinteractive.com", "Harlan Kellaway" => "harlan@prolificinteractive.com" }
  s.social_media_url = "http://twitter.com/weareprolific"
  s.source           = { :git => "https://github.com/prolificinteractive/PIPassiveAlert.git", :tag => s.version.to_s }
  
  s.platforms        = { :ios => "8.0" }
  s.requires_arc     = true

  s.source_files     = 'Sources/*.{h,m}'

  s.resource_bundles = {
    'PIPassiveAlert' => ['Sources/*.{xib}']
  }

end
