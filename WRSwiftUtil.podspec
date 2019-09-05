Pod::Spec.new do |s|
s.name         = 'WRSwiftUtil'
s.version      = '1.0.0'
s.summary      = '常用 Swift 工具类定义'
s.description  = '常用 Swift 工具类定义,便于初始化项目'
s.homepage     = 'https://github.com/GodFighter/WRSwiftUtil'
s.license      = 'MIT'
s.author       = { 'Leo Xiang' => 'xianghui_ios@163.com' }
s.source       = { :git => 'https://github.com/GodFighter/WRSwiftUtil.git', :tag => "1.0.0" }
s.source_files = 'WRSwiftUtil/Device/*.swift'
s.ios.deployment_target = '9.0'
s.frameworks   = 'UIKit','Foundation'
s.social_media_url = 'http://weibo.com/huigedang/home?wvr=5&lf=reg'
s.requires_arc = true

end
