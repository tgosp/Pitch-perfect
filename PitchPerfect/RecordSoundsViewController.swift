//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Todor Gospodinov on 12/13/15.
//  Copyright © 2015 Todor Gospodinov. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // TODO reset screen state
    }


    @IBAction func recordAudio(sender: UIButton) {
        // MARK: UI changes
        recordButton.enabled = false
        recordingLabel.hidden = false
        stopButton.hidden = false
        
        // MARK: record user's voice
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String

        
        let recordingName = "recorded_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)

        // setup audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // initialize and prepare the recorder
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        // MARK: UI changes
        sender.hidden = true
        recordButton.enabled = true
        recordingLabel.hidden = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)

        
    }
    
}

