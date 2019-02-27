#
# Be sure to run `pod lib lint BadooGallery.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BadooGallery'
  s.version          = '0.2'
  s.summary          = 'A UI catalog framework'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Framework which allows building UI catalog of view components covered with snapshots
                       DESC

  s.homepage         = 'https://github.com/badoo/Gallery'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Victor Shamanov' => 'https://github.com/wiruzx' }
  s.source           = { :git => 'https://github.com/badoo/Gallery.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.swift_version = '4.2'
  s.source_files = 'Gallery/**/*.{swift}'
  
  s.resource_bundles = {
    'BadooGallery' => ['Gallery/Internal/Assets.xcassets']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
