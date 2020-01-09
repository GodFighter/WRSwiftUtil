//
//  WRControl.swift
//  WRSwiftUtilDemo
//
//  Created by 项辉 on 2020/1/9.
//  Copyright © 2020 xianghui. All rights reserved.
//

import ObjectiveC
import UIKit


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
    deinit {
        print("deinit WRControlExtension")
    }
    
    fileprivate init(_ value: UIControl){
        super.init(value)
        self.value = value
    }
    
    fileprivate func add(_ handler :@escaping UIControl.wr_control_handler, events: UIControl.Event) {
        if let control = self.value as? UIControl {
            
            var handlers = control.handlers

            if handlers == nil {
                control.handlers = NSMutableDictionary.init(object: handler, forKey: NSNumber(integerLiteral: Int(events.rawValue)))
            } else {
                control.handlers!.setObject(handler, forKey: NSNumber(integerLiteral: Int(events.rawValue)))
            }
        }
    }
    
    @discardableResult
    @objc public func touchDown(action: @escaping UIControl.wr_control_handler) -> UIControl {
        if let control = self.value as? UIControl {
            control.wr_addEventHandler(action as! (Any) -> Void, for: .touchDown)
//            self.add(action, events: .touchDown)
//            control.addTarget(control, action: #selector(control.wr_touchDown(_:)), for: .touchDown)
        }
        return self.value as! UIControl
    }
/*
    @discardableResult
    @objc public func touchDragInside(action:@escaping UIControl.wr_control_handler) -> UIControl {
        if let control = self.value as? UIControl {
            self.add(action, events: .touchDragInside)
            control.addTarget(control, action: #selector(control.wr_touchDragInside(_:)), for: .touchDragInside)
        }
        return self.value as! UIControl
    }

    @discardableResult
    @objc public func touchDragOutside(action:@escaping UIControl.wr_control_handler) -> UIControl {
        if let control = self.value as? UIControl {
            self.add(action, events: .touchDragOutside)
            control.addTarget(control, action: #selector(control.wr_touchDragOutside(_:)), for: .touchDragOutside)
        }
        return self.value as! UIControl
    }

    @discardableResult
    @objc public func touchDragEnter(action:@escaping UIControl.wr_control_handler) -> UIControl {
        if let control = self.value as? UIControl {
            self.add(action, events: .touchDragEnter)
            control.addTarget(control, action: #selector(control.wr_touchDragEnter(_:)), for: .touchDragEnter)
        }
        return self.value as! UIControl
    }

    @discardableResult
    @objc public func touchDragExit(action:@escaping UIControl.wr_control_handler) -> UIControl {
        if let control = self.value as? UIControl {
            self.add(action, events: .touchDragExit)
            control.addTarget(control, action: #selector(control.wr_touchDragExit(_:)), for: .touchDragExit)
        }
        return self.value as! UIControl
    }

    @discardableResult
    @objc public func touchUpInside(action:@escaping UIControl.wr_control_handler) -> UIControl {
        if let control = self.value as? UIControl {
            self.add(action, events: .touchUpInside)
            control.addTarget(control, action: #selector(control.wr_touchUpInside(_:)), for: .touchUpInside)
        }
        return self.value as! UIControl
    }
    
    @discardableResult
    @objc public func touchUpOutside(action:@escaping UIControl.wr_control_handler) -> UIControl {
        if let control = self.value as? UIControl {
            self.add(action, events: .touchUpOutside)
            control.addTarget(control, action: #selector(control.wr_touchUpOutside(_:)), for: .touchUpOutside)
        }
        return self.value as! UIControl
    }

    @discardableResult
    @objc public func touchCancel(action:@escaping UIControl.wr_control_handler) -> UIControl {
        if let control = self.value as? UIControl {
            self.add(action, events: .touchCancel)
            control.addTarget(control, action: #selector(control.wr_touchCancel(_:)), for: .touchCancel)
        }
        return self.value as! UIControl
    }

    @discardableResult
    @objc public func valueChanged(action:@escaping UIControl.wr_control_handler) -> UIControl {
        if let control = self.value as? UIControl {
            self.add(action, events: .valueChanged)
            control.addTarget(control, action: #selector(control.wr_valueChanged(_:)), for: .valueChanged)
        }
        return self.value as! UIControl
    }
 */
}

//MARK: -
fileprivate typealias UIControl_Handler = UIControl
extension UIControl_Handler{
    public typealias wr_control_handler = (Any) -> ()

    private struct wr_associated{
       static var handlerKey = "wr_h_associatedKey"

        static var touchDownKey = "wr_h_associatedKey_touchdown"
    }
    
    var handlers : NSMutableDictionary? {
        set {
            objc_setAssociatedObject(self, &wr_associated.handlerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let handlers = objc_getAssociatedObject(self, &wr_associated.handlerKey) as? NSDictionary {
                return NSMutableDictionary.init(dictionary: handlers)
            }
            return nil
        }
    }
        
    
    @objc public func wr_touchDown(_ controlAction:@escaping wr_control_handler) -> UIControl?{
//        controlAction(self)
//        print("begin")
        if let handler = self.handlers?[NSNumber(integerLiteral: Int(UIControl.Event.touchDown.rawValue))] as? wr_control_handler {
            handler(self)
        }
//        self.handlers?[NSNumber(integerLiteral: Int(UIControl.Event.touchDown.rawValue))]?(self)
//        print("\(self.allControlEvents)")
        return self
    }
    /*
    @objc public func wr_touchDownRepeat(_ controlAction:@escaping wr_control_handler) -> UIControl?{
//        self.touchDownBlock(self)
//        self.handlers?[UIControl.Event.touchDownRepeat.rawValue]?(self)
        return self
    }

    @objc public func wr_touchDragInside(_ controlAction:@escaping wr_control_handler) -> UIControl?{
        self.handlers?[UIControl.Event.touchDragInside.rawValue]?(self)
        return self
    }

    @objc public func wr_touchDragOutside(_ controlAction:@escaping wr_control_handler) -> UIControl?{
        self.handlers?[UIControl.Event.touchDragOutside.rawValue]?(self)
        return self
    }

    @objc public func wr_touchDragEnter(_ controlAction:@escaping wr_control_handler) -> UIControl?{
        self.handlers?[UIControl.Event.touchDragEnter.rawValue]?(self)
        return self
    }

    @objc public func wr_touchDragExit(_ controlAction:@escaping wr_control_handler) -> UIControl?{
        self.handlers?[UIControl.Event.touchDragExit.rawValue]?(self)
        return self
    }

    @objc public func wr_touchUpInside(_ controlAction:@escaping wr_control_handler) -> UIControl?{
        DispatchQueue.main.async {
            self.handlers?[UIControl.Event.touchUpInside.rawValue]?(self)
            print("\(self.allControlEvents)")
        }
        return self
    }

    @objc public func wr_touchUpOutside(_ controlAction:@escaping wr_control_handler) -> UIControl?{
        self.handlers?[UIControl.Event.touchUpOutside.rawValue]?(self)
        return self
    }

    @objc public func wr_touchCancel(_ controlAction:@escaping wr_control_handler) -> UIControl?{
        self.handlers?[UIControl.Event.touchCancel.rawValue]?(self)
        return self
    }

    @objc public func wr_valueChanged(_ controlAction:@escaping wr_control_handler) -> UIControl?{
        self.handlers?[UIControl.Event.valueChanged.rawValue]?(self)
        return self
    }
*/
}
