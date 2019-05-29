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
    private var tcAPI:TextCastAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castButton = GCKUICastButton(frame: CGRect(x: UIScreen.main.bounds.width - 80, y: 30, width: 50, height: 50))
        castButton.tintColor = .black
        self.view.addSubview(castButton)
        tcAPI = TextCastAPI()
    }
    @IBAction func postButtonTapped(_ sender: Any) {
        if let text = textView.text{
            tcAPI?.generatePage(withText: text)
        }
        load()
    }
}

extension MainViewController: GCKSessionManagerListener, GCKRemoteMediaClientListener, GCKRequestDelegate {
    func load(){
        let metadata = GCKMediaMetadata()
        metadata.setString("Big Buck Bunny (2008)", forKey: kGCKMetadataKeyTitle)
        metadata.setString("Big Buck Bunny tells the story of a giant rabbit with a heart bigger than " +
            "himself. When one sunny day three rodents rudely harass him, something " +
            "snaps... and the rabbit ain't no bunny anymore! In the typical cartoon " +
            "tradition he prepares the nasty rodents a comical revenge.",
                           forKey: kGCKMetadataKeySubtitle)
        metadata.addImage(GCKImage(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg")!,
                                   width: 480,
                                   height: 360))
        
        let url = URL.init(string: tcAPI?.getAddress() ?? "uhhh")
        guard let mediaURL = url else {
            print("invalid mediaURL")
            return
        }
        
        let mediaInfoBuilder = GCKMediaInformationBuilder.init(contentURL: mediaURL)
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
