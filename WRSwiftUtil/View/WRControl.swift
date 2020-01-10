//
//  WRControl.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/9.
//  Copyright © 2020 xianghui. All rights reserved.
//

import ObjectiveC
import UIKit

public typealias wr_control_handler = (Any, UIControl.Event) -> ()

@objc extension UIControl : WRControlProtocol {
    public override var wr: WRControlExtension {
        return WRControlExtension(self)
    }
}

@objc public protocol WRControlProtocol{
    var wr: WRControlExtension { get }
}

//MARK: -
@objc public class WRControlExtension : WRViewExtension {

    fileprivate init(_ value: UIControl){
        super.init(value)
        self.value = value
    }
    
    private struct wr_control_associated{
       static var handlerKey = "wr_handler_associated_key"
    }

    @discardableResult
    public func event(_ event: UIControl.Event, handler: @escaping wr_control_handler) -> UIControl? {
        var events = objc_getAssociatedObject(self.value, &wr_control_associated.handlerKey) as? Dictionary<UInt, Set<WRControlWrapper>>
        if events == nil {
            events = Dictionary<UInt, Set<WRControlWrapper>>.init()
        }
        let key = event.rawValue
        var value = events![key]
        if value == nil {
            value = Set<WRControlWrapper>()
        }
        
        let wrapper = WRControlWrapper.init(event, handler: handler)
        value!.insert(wrapper)
        events![key] = value
        objc_setAssociatedObject(self.value, &wr_control_associated.handlerKey, events, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        if let control = self.value as? UIControl {
            control.addTarget(wrapper, action: #selector(wrapper.invoke(_:)), for: event);
            return control
        }
        
        return nil
    }
}

//MARK: -
@objc fileprivate class WRControlWrapper : NSObject {
    var controlEvents : UIControl.Event
    var handler : wr_control_handler
    
    init(_ controlEvents: UIControl.Event, handler: @escaping wr_control_handler) {
        self.controlEvents = controlEvents
        self.handler = handler
    }
    
    @objc func invoke(_ sender : UIControl) {
        self.handler(sender, self.controlEvents)
    }
}

