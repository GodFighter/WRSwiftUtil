//
//  WRImage.swift
//  WRSwiftUtilDemo
//
//  Created by xianghui on 2019/9/6.
//  Copyright © 2019 xianghui. All rights reserved.
//

import UIKit

public struct WRImage{
    
    private init(){}

    //图片旋转
    public struct Rotate{
        
        private init(){}
        
        public static func angle(_ image : UIImage, _ angle : CGFloat) -> UIImage?{
            guard let cgImage = image.cgImage, angle.truncatingRemainder(dividingBy: 360) != 0 else{
                return image
            }
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
            
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            
            let radian = CGFloat(angle / 180.0 * CGFloat.pi)
            
            var transform = CGAffineTransform.identity
            
            transform = transform.translatedBy(x: 0, y: 0)
            transform = transform.translatedBy(x: image.size.width / 2.0, y: image.size.height / 2.0)
            transform = transform.rotated(by: radian)
            transform = transform.translatedBy(x: -image.size.width / 2.0, y: -image.size.height / 2.0)
            
            context.concatenate(transform)
            
            context.translateBy(x: 0, y: image.size.height);
            context.scaleBy(x: 1.0, y: -1.0);
            
            context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: image.size))
            
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage
        }
        
        public static func vertical(_ image : UIImage ) -> UIImage?{
            
            guard let cgImage = image.cgImage else{
                return image
            }
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
            
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            
            context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: image.size))
            
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage
        }
        
        public static func horizontal(_ image : UIImage ) -> UIImage?{
            
            guard let cgImage = image.cgImage else{
                return image
            }
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
            
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            
            context.translateBy(x: image.size.width, y: image.size.height)
            context.rotate(by: CGFloat(Double.pi))
            
            context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: image.size))
            
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage
        }
    }
    
    //图片大小编辑
    public static func size(_ image : UIImage, size : CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        
        guard let _ = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let updateImage : UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return updateImage
    }
    
    //纯颜色图片
    public static func color(_ size : CGSize, _ color : UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        color.setFill()
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    //渐变颜色图片
    public static func color(size : CGSize, colors : [UIColor], locations: [CGFloat] = [0.0, 1.0], start: CGPoint, end: CGPoint) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //颜色数组（这里使用三组颜色作为渐变）fc6820
        var compoents:[CGFloat] = []
        
        for color in colors{
            
            var red : CGFloat = 0
            var blue : CGFloat = 0
            var green : CGFloat = 0
            var alpha : CGFloat = 0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            compoents.append(red)
            compoents.append(green)
            compoents.append(blue)
            compoents.append(alpha)
        }
        
        //没组颜色所在位置（范围0~1)
        let locations:[CGFloat] = locations
        //生成渐变色（count参数表示渐变个数）
        let gradient = CGGradient(colorSpace: colorSpace,
                                  colorComponents: compoents,
                                  locations: locations,
                                  count: locations.count)!
        
        
        let start = CGPoint(x: start.x * size.width, y: start.y * size.height)
        
        let end = CGPoint(x: end.x * size.width, y: end.y * size.height)
        
        
        //绘制渐变
        context.drawLinearGradient(gradient,
                                   start: start,
                                   end: end,
                                   options: .drawsBeforeStartLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    //图片切割
    public static func cutting(image : UIImage, _ rect : CGRect) -> UIImage?{
        
        let scale = image.scale
        let imageSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let cuttingRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.width * scale, height: rect.height * scale)
        
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = image.cgImage?.cropping(to: cuttingRect) else{
            return nil
        }
        
        J0Context.draw(context, image: cgImage, rect: cuttingRect)
        
        let cuttingImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext()
        
        return cuttingImage
    }
    
    //快照
    public static func snapshot(_ view : UIView, size : CGSize, scale : CGFloat, opaque: Bool) -> UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        context.saveGState()
        
        context.scaleBy(x: size.width / view.bounds.size.width, y: size.height / view.bounds.size.height)
        view.layer.render(in: context)
        
        context.restoreGState()
        
        let snapshotImage : UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return snapshotImage
    }
    
    //图片合并
    public static func combination(_ image : CGImage?, bgImage : CGImage?, size : CGSize, scale : CGFloat) -> UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale);
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        J0Context.draw(context, image: bgImage, rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        J0Context.draw(context, image: image, rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return resultingImage
    }
    
    public static func fixOrientation(_ fixImage : UIImage) -> UIImage{
        
        guard let fixImageCG = fixImage.cgImage , fixImage.imageOrientation != UIImage.Orientation.up else{
            return fixImage
        }
        
        var transform = CGAffineTransform.identity
        
        switch fixImage.imageOrientation{
        case .down, .downMirrored:
            
            transform = transform.translatedBy(x: fixImage.size.width, y: fixImage.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left,.leftMirrored:
            transform = transform.translatedBy(x: fixImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .right,.rightMirrored:
            transform = transform.translatedBy(x: 0, y: fixImage.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2))
        default: break;
        }
        
        switch fixImage.imageOrientation{
        case .upMirrored,.downMirrored:
            transform = transform.translatedBy(x: fixImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored,.rightMirrored:
            transform = transform.translatedBy(x: fixImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default: break;
        }
        
        let context : CGContext = CGContext(data: nil, width: Int(fixImage.size.width), height: Int(fixImage.size.height),
                                            bitsPerComponent: fixImageCG.bitsPerComponent, bytesPerRow: 0, space: fixImageCG.colorSpace!, bitmapInfo: 1)!
        
        context.concatenate(transform)
        switch fixImage.imageOrientation{
        case .left, .leftMirrored, .right, .rightMirrored:
            context.draw(fixImageCG, in: CGRect(x: 0, y: 0, width: fixImage.size.height, height: fixImage.size.width))
        default:
            context.draw(fixImageCG, in: CGRect(x: 0, y: 0, width: fixImage.size.width, height: fixImage.size.height))
        }
        
        guard let imageCG : CGImage = context.makeImage() else{
            return fixImage
        }
        
        return  UIImage(cgImage: imageCG)
    }
}



fileprivate struct J0Context{
    
    fileprivate static func clear(_ context : CGContext, rect : CGRect){
        
        context.saveGState();
        
        context.addRect(rect)
        context.setBlendMode(.clear)
        context.drawPath(using: .fill)
        
        context.restoreGState();
    }
    
    fileprivate static func draw(_ context : CGContext, image : CGImage?, rect : CGRect){
        
        guard let image = image else{
            return
        }
        
        context.saveGState();
        
        context.translateBy(x: rect.origin.x, y: rect.origin.y);
        context.translateBy(x: 0, y: rect.size.height);
        context.scaleBy(x: 1.0, y: -1.0);
        context.translateBy(x: -rect.origin.x, y: -rect.origin.y);
        
        context.draw(image, in: rect)
        
        context.restoreGState();
    }

}
