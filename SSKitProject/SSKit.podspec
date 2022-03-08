
//注:自己创建的时候不要把备注写进去，我这边是为了方便了解：

Pod::Spec.new do |s|
s.name = "SSKit"    // 你的框架名称
s.version = "1.1.4"   // 你的框架tag版本，打标签下文将解释
s.license = "MIT"     //创建git仓库的时候可选择，默认MIT
s.summary = "A ChannelListView with CollectionView by swift, it is like NetEaseNews Channel style."  //一些介绍
s.homepage = "https://github.com/SwiftHsw/SWKit.git"  //首页地址，建议写git仓库地址
s.author = { "SwiftHsw" => "392287145@qq.com" } //作者，邮箱
s.source = { :git => "https://github.com/SwiftHsw/SWKit.git", :tag => s.version } //仓库地址 后面的tag可以不用改
s.ios.deployment_target = "9.0" //最低支持版本
s.frameworks = "Foundation", "UIKit","AVFoundation"  //依赖框架
s.dependency 'KakaJSON'
s.dependency 'MJRefresh'
s.dependency 'SnapKit'
s.dependency 'Kingfisher'
s.dependency 'lottie-ios'
s.source_files  = 'Classes/*.{h,m}' //你的仓库地址的文件路径，不是项目路径切记！作者因为这个搞了2天，还有是单引号''，不是双引号 
"" 
end