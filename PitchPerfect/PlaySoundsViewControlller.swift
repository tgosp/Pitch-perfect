//
//  PlaySoundsViewControlller.swift
//  PitchPerfect
//
//  Created by Todor Gospodinov on 12/13/15.
//  Copyright © 2015 Todor Gospodinov. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewControlller: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: create audio player
        audioPlayer = try! AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl)
        audioPlayer.enableRate = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        // MARK: play audio slow
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    
    @IBAction func playFastAUdio(sender: AnyObject) {
        // MARK: play audio fast
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.rate = 2
        audioPlayer.play()
    }
    
    @IBAction func stopPlayAudio(sender: UIButton) {
        // MARK: stop play audio
        audioPlayer.currentTime = 0
        audioPlayer.stop()
    }
    
}

