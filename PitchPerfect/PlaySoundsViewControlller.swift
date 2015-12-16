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

    @IBOutlet weak var stopButton: UIButton!
    
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.playAudio // wasnt able to do this with storyboard, why?
        // MARK: create audio player
        audioPlayer = try! AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: recievedAudio.filePathUrl)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        stopAudioPlaying()
    }
    
   
    
    @IBAction func playSlowAudio(sender: UIButton) {
        // MARK: play audio slow
        playAudioWithRate(0.5)
    }
    
    @IBAction func playFastAUdio(sender: AnyObject) {
        // MARK: play audio fast
        playAudioWithRate(2)
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAudioPlaying()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()

    }
    
    @IBAction func stopPlayAudio(sender: UIButton) {
        // MARK: stop play audio
        stopAudioPlaying()
    }
    
    
    func playAudioWithRate(rate: Float){
        stopAudioPlaying()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func stopAudioPlaying(){
        
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    
    

}

