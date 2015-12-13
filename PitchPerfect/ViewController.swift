//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Todor Gospodinov on 12/13/15.
//  Copyright © 2015 Todor Gospodinov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: UIButton) {
        // UI changes
        recordButton.enabled = false
        recordingLabel.hidden = false
        stopButton.hidden = false
        
        
        
        //TODO: record users voice
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true
        recordButton.enabled = true
        sender.hidden = true
    }
}

