//
//  tcImage.swift
//  textcast
//
//  Created by John Garrett on 5/29/19.
//  Copyright © 2019 John Garrett. All rights reserved.
//

import Foundation
import UIKit
public var imageName:String = "renderedImage.png"
func textToImage(drawText text: String, onImage image: UIImage) {
    imageName = "renderedImage\(arc4random()).png"
    guard let textFont = UIFont(name: "Commodore-64-Rounded", size: 40.0) else {
        fatalError("Could not load font")
    }
    
    let scale:CGFloat = 2.0
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
    
    let textFontAttributes = [
        NSAttributedString.Key.font: textFont,
        NSAttributedString.Key.foregroundColor: UIColor.black,
        ] as [NSAttributedString.Key : Any]
    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    
    
    let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
    text.draw(in: rect, withAttributes: textFontAttributes)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    print("Image did save successfully: \(saveImage(withName: imageName, data: newImage?.pngData()))")
}


fileprivate func saveImage(withName name:String, data: Data?) -> Bool {
    clearFileManager()
    
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

fileprivate func clearFileManager(){
    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    
    let directoryContents = try? FileManager.default.contentsOfDirectory(atPath: dirPath)
    
    if let contents = directoryContents {
        for path in contents {
            let fullPath = dirPath.appending("/\(path)")
            do{
                try FileManager.default.removeItem(atPath: fullPath)
            }
            catch{
                print("Could not delete a file in the directory")
            }
        }
    }
}
