//
//  tcServer.swift
//  textcast
//
//  Created by John Garrett on 5/28/19.
//  Copyright © 2019 John Garrett. All rights reserved.
//

import UIKit
import Foundation
import Swifter

public func tcServer(_ publicDir: String, withText text: String) -> HttpServer {
    let server = HttpServer()
    
    server["/public/:path"] = shareFilesFromDirectory(publicDir)
    
    
    server["/files/:path"] = directoryBrowser(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])

    //http://192.168.1.136:8080/files//fileName.png
    server["/"] = scopes {
        html {
            body {
                ul(server.routes) { service in
                    li {
                        a { href = service; inner = service }
                    }
                }
            }
        }
    }
    
    server["/text"] = scopes {
        html {
            body {
                h1 { inner = text }
            }
        }
    }
    
    server.notFoundHandler = { r in
        return .movedPermanently("https://github.com/404")
    }
    
    server.middleware.append { r in
        print("IPV6 Address: \(r.address ?? "unknown address") -> \(r.method) -> \(r.path)")
        return nil
    }
    
    return server
}

fileprivate func retrieveImage(){
    let fileManager = FileManager.default
    
//    let documentsPath =
//    let documentsURL = URL(fileURLWithPath: documentsPath, isDirectory: true)
//    let path = String(fileURL.absoluteString.dropFirst(7)) //remove file://
    
    //return the file if we have it in storage
//    if fileManager.fileExists(atPath: path), let data = fileManager.contents(atPath: path), data.count > 3708{
//        let result = Result.success(data)
//        completion(result)
//        return
//    }
    
}
