Pod::Spec.new do |s|
s.name = "SSKit"     
s.version = "1.0"    
s.license = "MIT"    
s.summary = "swift app Basic tools."   
s.homepage = "https://github.com/SwiftHsw/SSKit.git"   
s.author = { "SwiftHsw" => "392287145@qq.com" }  
s.source = { :git => "https://github.com/SwiftHsw/SSKit.git", :tag => s.version } //仓库地址 后面的tag可以不用改
s.ios.deployment_target = "10.0" 
s.frameworks = "Foundation", "UIKit","AVFoundation"   
s.dependency 'KakaJSON'
s.dependency 'MJRefresh'
s.dependency 'SnapKit'
s.dependency 'Kingfisher'
s.dependency 'lottie-ios'
s.source_files  = 'SSKitProject/SSKit/**/*'  
 
end