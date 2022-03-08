Pod::Spec.new do |s|
s.name = "SSKit"     
s.version = "1.1"    
s.license = "MIT"    
s.summary = "swift app Basic tools."   
s.homepage = "https://github.com/SwiftHsw/SSKit.git"   
s.author = { "SwiftHsw" => "392287145@qq.com" }  
s.source = { :git => "https://github.com/SwiftHsw/SSKit.git", :tag => s.version }  
s.ios.deployment_target = "10.0" 
s.frameworks = "Foundation", "UIKit","AVFoundation" 
  
s.dependency 'KakaJSON'
s.dependency 'MJRefresh'
s.dependency 'SnapKit'
s.dependency 'lottie-ios'
 
s.source_files  = 'SSKit/*.{swift}'
end