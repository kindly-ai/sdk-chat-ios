Pod::Spec.new do |spec|
  
  spec.name         = "KindlySDK"
  spec.version      = "0.0.1"
  spec.summary      = ""
  spec.description  = <<-DESC
                   DESC
  spec.homepage     = "https://www.kindly.ai"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { "Alexy" => "alexy.ib@gmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/kindly-ai/sdk-chat-ios", :tag => "#{spec.version}" }
  spec.source_files  = 'Sources/**/*'
  spec.vendored_frameworks = 'artifacts/KindlySDK.xcframework'
  spec.swift_version = '5.0'

  spec.dependency 'Starscream', '4.0.6'
  spec.dependency 'SwiftyGif', '5.4.3'
  spec.dependency 'SnapKit', '5.6.0'
  spec.dependency 'SwiftyJSON', '5.0.1'

end
