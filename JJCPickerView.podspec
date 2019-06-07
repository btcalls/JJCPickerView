#
# Be sure to run `pod lib lint JJCPickerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JJCPickerView'
  s.version          = '0.1.2'
  s.summary          = 'A picker with UIActionSheet-like behavior.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This pod is made to cater the needs of using pickers without the need to integrate it to the actual screen interface.
  It mimics the presentation behaviour of an UIActionSheet instance.
                       DESC

  s.homepage         = 'https://github.com/jason-ingenuity/JJCPickerView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jason Jon E. Carreos' => 'jason@ingenuity.ph' }
  s.source           = { :git => 'https://github.com/jason-ingenuity/JJCPickerView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/BTcalls'

  s.ios.deployment_target = '10.0'
  s.swift_versions = '4.2'

  s.source_files = 'JJCPickerView/Classes/**/*'
  s.resources = "JJCPickerView/Assets/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  
  # s.resource_bundles = {
  #   'JJCPickerView' => ['JJCPickerView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
