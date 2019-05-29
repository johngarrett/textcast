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

    @IBOutlet var textView: UITextView!

    private var castButton: GCKUICastButton!
    private var mediaInformation: GCKMediaInformation?
    private var sessionManager: GCKSessionManager!
    private var api:tcAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castButton = GCKUICastButton(frame: CGRect(x: UIScreen.main.bounds.width - 80, y: 30, width: 50, height: 50))
        castButton.tintColor = .black
        self.view.addSubview(castButton)
        api = tcAPI()
    }
    @IBAction func postButtonTapped(_ sender: Any) {
        if let text = textView.text{
            api?.generateImage(withText: text)
        }
        load()
    }
}

extension MainViewController: GCKSessionManagerListener, GCKRemoteMediaClientListener, GCKRequestDelegate {
    func load(){
        guard let mediaURL = URL.init(string: api?.getImageURL() ?? "bad URL") else {
            print("invalid mediaURL")
            return
        }
        
        let mediaInfoBuilder = GCKMediaInformationBuilder.init(contentURL: mediaURL)
        mediaInfoBuilder.contentType = "image/png"
        mediaInformation = mediaInfoBuilder.build()
        
        guard let mediaInfo = mediaInformation else {
            print("invalid mediaInformation")
            return
        }
        
        sessionManager = GCKCastContext.sharedInstance().sessionManager

        if let request = self.sessionManager.currentSession?.remoteMediaClient?.loadMedia(mediaInfo) {
            request.delegate = self
        }
    }
}
