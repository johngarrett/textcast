//
//  MainViewController.swift
//  textcast
//
//  Created by John Garrett on 5/27/19.
//  Copyright © 2019 John Garrett. All rights reserved.
//

import UIKit
import GoogleCast
class MainViewController: UIViewController {

    private var castButton: GCKUICastButton!
    private var mediaInformation: GCKMediaInformation?
    private var sessionManager: GCKSessionManager!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        castButton = GCKUICastButton(frame: CGRect(x: UIScreen.main.bounds.width - 80, y: 30, width: 50, height: 50))
        castButton.tintColor = .black
        self.view.addSubview(castButton)
        
        TextCastAPI()
    }
}
