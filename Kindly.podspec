Pod::Spec.new do |spec|

  spec.name         = "Kindly"
  spec.version      = "2.1.86"
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

  spec.default_subspecs = "Core"

  spec.subspec "Core" do |core|
    core.dependency 'Starscream', '~> 4.0.8'
    core.dependency 'SwiftyGif', '~> 5.4.4'
    core.dependency 'SwiftyJSON', '~> 5.0.2'
  end

  spec.subspec "Sentry" do |sentry|
    sentry.dependency 'Kindly/Core'
    sentry.dependency 'Sentry', '>= 8.30.0'
  end

end
