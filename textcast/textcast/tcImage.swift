//
//  tcImage.swift
//  textcast
//
//  Created by John Garrett on 5/29/19.
//  Copyright © 2019 John Garrett. All rights reserved.
//

import Foundation
import UIKit
    public var imageName = "renderedImage.png"
    func textToImage(drawText text: String, inImage image: UIImage) {
        let textColor = UIColor.black
        guard let textFont = UIFont(name: "Commodore-64-Rounded", size: 40.0) else {
            fatalError("Could not load font")
        }
        
        let scale = UIScreen.main.scale
//        let point = CGPoint(x: image.size.width / 2, y: image.size.height / 2)
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        print(saveImage(withName: imageName, data: newImage?.pngData()))
    }
    
    
    fileprivate func saveImage(withName name:String, data: Data?) -> Bool {
        guard let data = data else {
            return false
        }
        
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(name)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

