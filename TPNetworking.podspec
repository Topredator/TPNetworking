#
# Be sure to run `pod lib lint TPNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TPNetworking'
  s.version          = '0.0.2'
  s.summary          = 'TPNetworking iOS系统网络库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Topredator/TPNetworking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Topredator' => 'luyanggold@163.com' }
  s.source           = { :git => 'https://github.com/Topredator/TPNetworking.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TPNetworking/Classes/TPNetworking.h'
  s.subspec 'Base' do |ss|
      ss.source_files = 'TPNetworking/Classes/Base/**/*'
      ss.dependency 'AFNetworking',  '~> 4.0.0'
      ss.dependency 'CocoaLumberjack'
      ss.private_header_files = 'TPNetworking/Classes/Base/TPNetworkPrivate.h'
  end
  s.subspec 'Core' do |ss|
    ss.source_files = 'TPNetworking/Classes/Core/**/*'
    ss.dependency 'TPNetworking/Base'
    ss.dependency 'TPNetworking/TPModel'
    ss.dependency 'ReactiveObjC'
  end
  s.subspec 'TPModel' do |ss|
      ss.source_files = 'TPNetworking/Classes/TPModel/**/*'
  end
  # s.resource_bundles = {
  #   'TPNetworking' => ['TPNetworking/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
