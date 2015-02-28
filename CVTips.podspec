Pod::Spec.new do |spec|
  spec.name         = 'CVTips'
  spec.version      = '0.1'
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/coultonvento/CVTips'
  spec.authors      = { 'Coulton Vento' => 'me@coultonvento.com' }
  spec.summary      = 'An interface for displaying interactive tips.'
  spec.source       = { :git => 'https://github.com/coultonvento/CVTips.git', :tag => 'v0.1' }
  spec.source_files = 'CVTips/*.{h,m}'
  spec.framework    = 'UIKit', 'Foundation'
end