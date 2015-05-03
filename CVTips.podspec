Pod::Spec.new do |spec|
  spec.name             = 'CVTips'
  spec.version          = '0.11'
  spec.license          = { :type => 'MIT', :file => 'LICENSE.txt' }
  spec.homepage         = 'https://github.com/coultonvento/CVTips'
  spec.author           = { 'Coulton Vento' => 'me@coultonvento.com' }
  spec.social_media_url = "http://twitter.com/coultonvento"
  spec.summary          = 'An interface for displaying interactive tips.'
  spec.source           = { :git => 'https://github.com/coultonvento/CVTips.git', :tag => 'v0.11' }
  spec.source_files     = 'CVTips/*.{h,m}'
  spec.framework        = 'UIKit', 'Foundation'
  spec.platform         = :ios, "8.0"
  spec.requires_arc     = true
end