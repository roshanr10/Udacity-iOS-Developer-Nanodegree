//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Roshan Ravi on 6/13/15.
//  Copyright (c) 2015 Innovate Loop Enterprises. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var microphone: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!

    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        pauseButton.hidden = true
        resumeButton.hidden = true
        microphone.enabled = true
        recordingInProgress.text = "Record!"

    }

    @IBAction func recordAudio(sender: UIButton) {
        // Show text "recording in progress"
        recordingInProgress.text = "Recording!"
        stopButton.hidden = false
        pauseButton.hidden = false
        microphone.enabled = false
        
        // Record the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func pauseAudio(sender: UIButton) {
        audioRecorder.pause()
        recordingInProgress.text = "Paused!"
        resumeButton.hidden = false
        pauseButton.hidden = true
    }
    
    @IBAction func resumeAudio(sender: UIButton) {
        audioRecorder.record()
        recordingInProgress.text = "Recording!"
        resumeButton.hidden = true
        pauseButton.hidden = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent, file: recorder.url)
            
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            // Recording was not successful.
            microphone.enabled = true
            recordingInProgress.hidden = true
            stopButton.hidden = true
            pauseButton.hidden = true
            resumeButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopRecordingButton(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

