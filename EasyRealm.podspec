#
# Be sure to run `pod lib lint EasyRealm.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EasyRealm'
  s.version          = '3.4.0'
  s.summary          = 'EasyRealm is a micro-framework that helps you use Realm.'

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
EasyRealm is a micro-framework (less than 200 LOC) that helps you use Realm.
                       DESC

  s.homepage         = 'https://github.com/PoissonBallon/EasyRealm.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Allan Vialatte' => 'allan.vialatte@icloud.com' }
  s.source           = { git: 'https://github.com/PoissonBallon/EasyRealm.git', tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/poissonballon'


  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'EasyRealm/Classes/**/*.swift'
  s.swift_version = '4.2'
  s.dependency 'RealmSwift', '~> 3.10'
end
