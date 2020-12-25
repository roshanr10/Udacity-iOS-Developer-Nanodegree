//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Roshan Ravi on 6/13/15.
//  Copyright (c) 2015 Innovate Loop Enterprises. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var audioPlayer2:AVAudioPlayer!
    
    var reverbPlayers:[AVAudioPlayer] = []
    let N:Int = 10
    
    var receivedAudio:RecordedAudio!

    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioPlayer2 = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        
        audioEngine = AVAudioEngine()
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        for i in 0...N {
            var temp = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl,
                fileTypeHint: "mp3",
                error: nil)
            reverbPlayers.append(temp)
        }
        
        var session = AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
    }

    @IBAction func slowPlayback(sender: UIButton) {
        resetPlayer()
        audioPlayer.rate = 0.5
        playAudio()
    }
    
    @IBAction func fastPlayback(sender: UIButton) {
        resetPlayer()
        audioPlayer.rate = 1.5
        playAudio()
    }
    
    @IBAction func chipmunkPlayback(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthVaderPlayback(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func echoPlayback(sender: UIButton) {
        resetPlayer()
        playAudio()
        
        let delay:NSTimeInterval = 0.1 //100ms
        var playtime:NSTimeInterval
        playtime = audioPlayer2.deviceCurrentTime + delay
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.8;
        audioPlayer2.playAtTime(playtime)
    }
    
    @IBAction func reverbPlayback(sender: UIButton) {
        /*
        20ms produces detectable delays
        */
        let delay:NSTimeInterval = 0.02
        for i in 0...N {
            var curDelay:NSTimeInterval = delay*NSTimeInterval(i)
            var player:AVAudioPlayer = reverbPlayers[i]
            //M_E is e=2.718...
            //dividing N by 2 made it sound ok for the case N=10
            var exponent:Double = -Double(i)/Double(N/2)
            var volume = Float(pow(Double(M_E), exponent))
            player.volume = volume
            player.playAtTime(player.deviceCurrentTime + curDelay)
        }
    }
    
    func playAudio(){
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        resetPlayer()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func resetPlayer(){
        audioPlayer.stop()
        audioPlayer.rate = 1.0
        audioPlayer2.stop()
        audioEngine.stop()
        audioEngine.reset()
        for i in 0...N {
            reverbPlayers[i].stop()
        }
    }
    
    @IBAction func stopPlayback(sender: UIButton) {
        resetPlayer()
    }
}
