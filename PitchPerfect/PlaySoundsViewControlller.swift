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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            let fileURL = NSURL.fileURLWithPath(filePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
                audioPlayer.enableRate = true
            } catch{
                print("unable to create audio player instance, check audio file name")
            }

        } else {
            print("autio file not found")
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
}

