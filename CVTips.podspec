Pod::Spec.new do |spec|
  spec.name             = 'CVTips'
  spec.version          = '0.12'
  spec.license          = { :type => 'MIT', :file => 'LICENSE.txt' }
  spec.homepage         = 'https://github.com/coulton/CVTips'
  spec.author           = { 'Coulton Vento' => 'me@coultonvento.com' }
  spec.social_media_url = "http://twitter.com/coultonvento"
  spec.summary          = 'An interface for displaying interactive tips.'
  spec.source           = { :git => 'https://github.com/coulton/CVTips.git', :tag => 'v0.12' }
  spec.source_files     = 'CVTips/*.{h,m}'
  spec.framework        = 'UIKit', 'Foundation'
  spec.platform         = :ios, "8.0"
  spec.requires_arc     = true
end
