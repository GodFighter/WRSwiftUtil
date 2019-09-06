Pod::Spec.new do |s|
    s.name         = 'WRSwiftUtil'
    s.version      = "1.0.3"
    s.summary      = '常用 Swift 工具类定义'
    s.description  = '常用 Swift 工具类定义,便于初始化项目'
    s.homepage     = 'https://github.com/GodFighter/WRSwiftUtil'
    s.license      = 'MIT'
    s.author       = { 'Leo Xiang' => 'xianghui_ios@163.com' }
    s.source       = { :git => 'https://github.com/GodFighter/WRSwiftUtil.git', :tag => s.version }
    s.ios.deployment_target = '9.0'
    s.frameworks   = 'UIKit','Foundation'
    s.dependency 'Colours', '~> 5.13.0'
    s.social_media_url = 'http://weibo.com/huigedang/home?wvr=5&lf=reg'
    s.requires_arc = true
    s.swift_version = '5.0'

    s.subspec 'Device' do |ss|
        ss.source_files = 'WRSwiftUtil/Device/*.swift'
    end

    s.subspec 'Config' do |ss|
        ss.source_files = 'WRSwiftUtil/Config/*.swift'
    end

    s.subspec 'Controller' do |ss|
        ss.subspec 'NavigationController' do |sss|
            sss.source_files = 'WRSwiftUtil/Controller/NavigationController/*.swift'
        end
    end

    s.subspec 'Image' do |ss|
        ss.source_files = 'WRSwiftUtil/Image/*.swift'
    end

end
