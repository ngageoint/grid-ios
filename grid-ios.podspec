Pod::Spec.new do |s|
  s.name             = 'grid-ios'
  s.version          = '1.0.3'
  s.license          =  {:type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'iOS SDK for Grids'
  s.homepage         = 'https://github.com/ngageoint/grid-ios'
  s.authors          = { 'NGA' => '', 'BIT Systems' => '', 'Brian Osborn' => 'bosborn@caci.com' }
  s.social_media_url = 'https://twitter.com/NGA_GEOINT'
  s.source           = { :git => 'https://github.com/ngageoint/grid-ios.git', :tag => s.version }
  s.requires_arc     = true

  s.platform         = :ios, '12.0'
  s.ios.deployment_target = '12.0'

  s.source_files = 'grid-ios/**/*.swift'

  s.frameworks = 'Foundation'

  s.dependency 'color-ios', '~> 1.0.0'
  s.dependency 'sf-ios', '~> 4.1.0'
end
