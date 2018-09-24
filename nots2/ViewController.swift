//
//  ViewController.swift
//  nots2
//
//  Created by apple on 9/23/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import AVKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func s(_ sender: Any) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
             try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
           
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    var player: AVAudioPlayer?
    @IBAction func headphone(_ sender: Any) {
   
        let session: AVAudioSession = AVAudioSession.sharedInstance()
        do {
            print(session.isHeadphonesConnected)
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.none)
            try session.setActive(true)
             print(session.outputDataSource?.dataSourceName)
        } catch {
            print("Couldn't override output audio port")
        }
    }
    func playvideo() {
        if let videoURL = URL(string: "http://techslides.com/demos/samples/sample.avi"){
            let player = AVPlayer(url: videoURL)
            
            let playerViewController = AVPlayerViewController()
             playerViewController.player = player
            
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    @IBAction func play(_ sender: Any) {
//        playvideo()
         playSound()
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "song", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
 

}
extension AVAudioSession {
    
    static var isHeadphonesConnected: Bool {
        return sharedInstance().isHeadphonesConnected
    }
    
    var isHeadphonesConnected: Bool {
        return !currentRoute.outputs.filter { $0.isHeadphones }.isEmpty
    }
    
}

extension AVAudioSessionPortDescription {
    var isHeadphones: Bool {
        return portType == AVAudioSessionPortHeadphones
    }
}
