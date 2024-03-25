Pod::Spec.new do |spec|

  spec.name         = "Kindly"
  spec.version      = "2.0.76"
  spec.summary      = "Kindly SDK"
  spec.description  = <<-DESC
  AI-powered chatbots built to automate support and drive sales
                   DESC
  spec.homepage     = "https://www.kindly.ai"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { "Alexy" => "alexy.ib@gmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/kindly-ai/sdk-chat-ios.git", :tag => "#{spec.version}" }
  # spec.source_files  = 'Sources/**/*'
  spec.vendored_frameworks = 'artifacts/Kindly.xcframework'
  spec.swift_version = '5.0'

  spec.dependency 'Starscream', '4.0.6'
  spec.dependency 'SwiftyGif', '5.4.4'
  spec.dependency 'SnapKit', '5.6.0'
  spec.dependency 'SwiftyJSON', '5.0.1'

  # spec.frameworks = 'UIKit', 'MapKit'
end
