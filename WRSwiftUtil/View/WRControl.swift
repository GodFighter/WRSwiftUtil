//
//  WRControl.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/9.
//  Copyright © 2020 xianghui. All rights reserved.
//

import UIKit

@objc extension UIControl : WRControlProtocol {
    public override var wr: WRControlExtension {
        return WRControlExtension(self)
    }
}

@objc public protocol WRControlProtocol{
    var wr: WRControlExtension { get }
}

public typealias wr_control_action = (UIControl) -> ()

public class WRControlWrapper : NSObject, NSCopying {
    
    deinit{
        debugPrint("55555555")
    }

    var controlEvents : UIControl.Event
    var handler : wr_control_action
    
    init(_ events : UIControl.Event, handler : @escaping wr_control_action) {
        self.controlEvents = events
        self.handler = handler
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return WRControlWrapper.init(self.controlEvents, handler: self.handler)
    }
    
    @objc func invoke(_ sender : UIControl) {
        self.handler(sender)
    }

}

extension UIControl {
    @objc public func wr_action(_ controlEvents: UIControl.Event, action:@escaping wr_control_action) -> UIControl?{
        action(self)
        return self
    }
}

@objc public class WRControlExtension : WRViewExtension {

    deinit{
        debugPrint("2345544")
    }

    private struct wr_associatedKeys{
       static var actionKey = "wr_associatedKey"
    }
    
//    private dynamic var actionInfos: Dictionary<UInt, Set<WRControlWrapper>>? {
//        set{
//            objc_setAssociatedObject(self,&wr_associatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
//        }
//        get{
//            if let infos = objc_getAssociatedObject(self, &wr_associatedKeys.actionKey) as? Dictionary<UInt, Set<WRControlWrapper>> {
//                return infos
//            }
//            return nil
//        }
//    }


    fileprivate init(_ value: UIControl){
        super.init(value)
        self.value = value
    }
    
    @discardableResult
    @objc public func add(_ controlEvents: UIControl.Event, action:@escaping wr_control_action) -> UIControl? {
        
//        var events = objc_getAssociatedObject(self.value, &wr_associatedKeys.actionKey) as? Dictionary<UInt, Set<WRControlWrapper>>
//
//        if events == nil {
//            events = Dictionary<UInt, Set<WRControlWrapper>>()
//            objc_setAssociatedObject(self.value, &wr_associatedKeys.actionKey, events, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//
//        }
//
//        let key = controlEvents.rawValue
//        var handlers = events?[key]
//        if handlers == nil {
//            handlers = Set<WRControlWrapper>()
//            events![key] = handlers
//        }

        if let control = self.value as? UIControl {
            control.addTarget(control, action: #selector(control.wr_action(_:action:)), for: controlEvents)
//            let target = WRControlWrapper.init(controlEvents, handler: action)
//            handlers?.insert(target)
//            control.addTarget(target, action: #selector(target.invoke(_:)), for: controlEvents)
        }
        
        return self.value as? UIControl
    }
    
    @objc public func action_aaa(_ target : WRControlWrapper) {
        print("1123")
    }
}

