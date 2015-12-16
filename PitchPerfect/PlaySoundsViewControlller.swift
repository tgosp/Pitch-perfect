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
    @IBOutlet weak var reverbDryMixSlider: UISlider!
    @IBOutlet weak var reverbRoomTypeSlider: UISlider!
    
    var recievedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.playAudio // wasnt able to do this with storyboard, why?
        // MARK: create audio player
        
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
        // TODO
        playAudioWithEffect(0, rate: 0.5)
    }
    
    @IBAction func playFastAUdio(sender: AnyObject) {
        // MARK: play audio fast
        // TODO
        playAudioWithEffect(0, rate: 2)
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithEffect(1000, rate: 1)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithEffect(-1000, rate: 1)
    }
    
    @IBAction func stopPlayAudio(sender: UIButton) {
        // MARK: stop play audio
        stopAudioPlaying()
    }
    
    
    @IBAction func playWithReverbAudioEffect(sender: UIButton) {
        playReverbAudio(reverbRoomTypeSlider.value, wetDryMix: reverbDryMixSlider.value)
    }
    
    
    func playAudioWithEffect(pitch: Float, rate: Float){
        stopAudioPlaying()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changeEffect = AVAudioUnitTimePitch()
        changeEffect.pitch = pitch
        changeEffect.rate = rate
        
        audioEngine.attachNode(changeEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeEffect, format: nil)
        audioEngine.connect(changeEffect, to: audioEngine.outputNode, format: nil)
        
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        

        audioPlayerNode.play()

    }
    
    func stopAudioPlaying(){
        

        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    
//   SUGGESTION from instructor notes
//   What about more effects? :)
    
    func playReverbAudio(reverbType: Float, wetDryMix: Float) {
        
        stopAudioPlaying();

        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        let reverbEffect = AVAudioUnitReverb()
        
        let preset = AVAudioUnitReverbPreset(rawValue: Int(reverbType))
        
        reverbEffect.loadFactoryPreset(preset!)
        
        reverbEffect.wetDryMix = wetDryMix
        
        audioEngine.attachNode(reverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        

        
        try! audioEngine.start()
        audioPlayerNode.play()
        
        
    }
    

}

