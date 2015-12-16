//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Todor Gospodinov on 12/13/15.
//  Copyright © 2015 Todor Gospodinov. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        recordingLabel.text = Constants.tapToRecord
    }


    @IBAction func recordAudio(sender: UIButton) {
        // MARK: UI changes
        recordButton.enabled = false
        recordingLabel.text = Constants.recordingInProgress
        stopButton.hidden = false
        
        // MARK: record user's voice
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String

        
        let recordingName = Constants.fileName
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)

        // setup audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryRecord)

        // initialize and prepare the recorder
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        
        audioRecorder.delegate = self
        
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            // MARK: save recorded audio file
            recordedAudio = RecordedAudio(filePath: recorder.url, audioFileTitle: recorder.url.lastPathComponent!)
            // MARK: call segue
            performSegueWithIdentifier(Constants.stopRecordingSegue, sender: recordedAudio)
        } else {
            print(Constants.recordingWasNotSuccessful)
            recordButton.enabled = true
            stopButton.hidden = true
            recordingLabel.text = Constants.tapToRecord
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == Constants.stopRecordingSegue){
            let playSoundsVC:PlaySoundsViewControlller = segue.destinationViewController as! PlaySoundsViewControlller
            let data = sender as! RecordedAudio
            playSoundsVC.recievedAudio = data
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        // MARK: UI changes
        sender.hidden = true
        recordButton.enabled = true

        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayback)
        try! audioSession.setActive(false)

        
    }
    
}

