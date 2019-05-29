//
//  TextCastAPI.swift
//  textcast
//
//  Created by John Garrett on 5/27/19.
//  Copyright © 2019 John Garrett. All rights reserved.
//

import Foundation
import Swifter
import GoogleCast


class TextCastAPI{
    private let port:UInt16 = 8080
    private let server = customServer(Bundle.main.resourcePath!, withText: "testing")
    
    static var shared = {
        return TextCastAPI()
    }
    
    func getAddress() -> String?{
        if let ipAddr = getIPAddress(){
            return "http://\(ipAddr):\(port)/text"
        }
        return nil
    }
    
    init(){
        do{
            print(getAddress() ?? "no ip address avaliable")
            try server.start(port)
        }
        catch{
            fatalError()
        }
    }
    
    func generatePage(withText text: String){

        server["/text"] = scopes {
            html {
                body {
                    h1 { inner = text }
                }
            }
        }
    }
    
    private func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET){
                    if let str = interface?.ifa_name, String(cString: str) == "en0" { //en0 is the idevice interface for wifi
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
}
