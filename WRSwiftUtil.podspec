Pod::Spec.new do |s|
    s.name         = 'WRSwiftUtil'
    s.version      = "1.0.16"
    s.summary      = '常用 Swift 工具类定义'
    s.description  = '常用 Swift 工具类定义,便于初始化项目'
    s.homepage     = 'https://github.com/GodFighter/WRSwiftUtil'
    s.license      = 'MIT'
    s.author       = { 'Leo Xiang' => 'xianghui_ios@163.com' }
    s.source       = { :git => 'https://github.com/GodFighter/WRSwiftUtil.git', :tag => s.version, :submodules => true }
    s.ios.deployment_target = '9.0'
    s.frameworks   = 'UIKit','Foundation'
    s.social_media_url = 'http://weibo.com/huigedang/home?wvr=5&lf=reg'
    s.requires_arc = true
    s.ios.deployment_target = '9.0'
    s.swift_version = '5.0'

    s.subspec 'Device' do |ss|
        ss.source_files = 'WRSwiftUtil/Device/*.swift'
    end

    s.subspec 'Image' do |ss|
        ss.source_files = 'WRSwiftUtil/Image/*.swift'
    end

    s.subspec 'Indicator' do |ss|
        ss.source_files = 'WRSwiftUtil/Indicator/*.swift'
        ss.dependency 'MBProgressHUD', '~> 1.1.0'
        ss.dependency 'WRSwiftUtil/Lib/Toast'
    end

    s.subspec 'Controller' do |ss|
        ss.subspec 'ViewController' do |sss|
            sss.source_files = 'WRSwiftUtil/Controller/ViewController/*.swift'
            sss.dependency 'WRSwiftUtil/Image'
            sss.dependency 'WRSwiftUtil/Controller/Protocol'
            sss.dependency 'WRSwiftUtil/Indicator'
        end
        ss.subspec 'NavigationController' do |sss|
            sss.source_files = 'WRSwiftUtil/Controller/NavigationController/*.swift'
            sss.dependency 'WRSwiftUtil/Image'
        end
        ss.subspec 'Protocol' do |sss|
            sss.source_files = 'WRSwiftUtil/Controller/Protocol/*.swift'
            sss.dependency 'WRSwiftUtil/Controller/NavigationController'
        end
    end

    s.subspec 'Lib' do |ss|
        ss.subspec 'Toast' do |sss|
            sss.source_files = 'WRSwiftUtil/Lib/Toast/*.swift'
        end
    end

    s.dependency 'Colours', '~> 5.13.0'
    s.dependency 'MBProgressHUD', '~> 1.1.0'

end
