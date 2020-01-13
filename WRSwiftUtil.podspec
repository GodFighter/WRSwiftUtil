Pod::Spec.new do |s|
    s.name         = 'WRSwiftUtil'
    s.version      = "1.3.3"
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

    s.subspec 'Common' do |ss|
        ss.source_files = 'WRSwiftUtil/Common/*.swift'
    end

    s.subspec 'Device' do |ss|
        ss.source_files = 'WRSwiftUtil/Device/*.swift'
    end

    s.subspec 'Image' do |ss|
        ss.source_files = 'WRSwiftUtil/Image/*.swift'
        ss.dependency 'WRSwiftUtil/Common'
    end

    s.subspec 'Controller' do |ss|
        ss.subspec 'ViewController' do |sss|
            sss.source_files = 'WRSwiftUtil/Controller/ViewController/*.swift'
            sss.dependency 'WRSwiftUtil/Image'
            sss.dependency 'WRSwiftUtil/Controller/Protocol'
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

    s.subspec 'View' do |ss|
        ss.source_files = 'WRSwiftUtil/View/*.swift'
        ss.dependency 'WRSwiftUtil/Common'
    end
    
    s.subspec 'Color' do |ss|
        ss.source_files = 'WRSwiftUtil/Color/*.swift'
        ss.dependency 'WRSwiftUtil/Common'
    end

    s.subspec 'Notification' do |ss|
        ss.source_files = 'WRSwiftUtil/Notification/*.swift'
    end

    s.subspec 'Activity' do |ss|
        ss.source_files = 'WRSwiftUtil/Activity/*.swift'
        ss.dependency 'WRSwiftUtil/Common'
        ss.subspec 'Animations' do |sss|
            sss.source_files = 'WRSwiftUtil/Activity/Animations/*.swift'
        end
    end

    s.dependency 'Colours', '~> 5.13.0'

end
