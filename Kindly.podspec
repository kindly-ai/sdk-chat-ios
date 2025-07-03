Pod::Spec.new do |spec|

  spec.name         = "Kindly"
  spec.version      = "2.1.75-beta"
  spec.summary      = "Kindly SDK"
  spec.description  = <<-DESC
  AI-powered chatbots built to automate support and drive sales
                   DESC
  spec.homepage     = "https://www.kindly.ai"
  spec.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  spec.author             = { "Alexy" => "alexy.ib@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/kindly-ai/sdk-chat-ios.git", :tag => "#{spec.version}" }
  # spec.source_files  = 'Sources/**/*'
  spec.vendored_frameworks = 'artifacts/Kindly.xcframework'
  spec.swift_version = '5.0'

  spec.frameworks = 'UIKit', 'MapKit'

  # Core dependencies
  spec.dependency 'Starscream', '4.0.6'
  spec.dependency 'SwiftyGif', '5.4.4'
  spec.dependency 'SwiftyJSON', '5.0.1'

end
