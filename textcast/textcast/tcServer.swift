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
    
    server.notFoundHandler = { r in
        return .movedPermanently("https://github.com/404")
    }
    
    server.middleware.append { r in
        print("IPV6 Address: \(r.address ?? "unknown address") -> \(r.method) -> \(r.path)")
        return nil
    }
    
    return server
}
