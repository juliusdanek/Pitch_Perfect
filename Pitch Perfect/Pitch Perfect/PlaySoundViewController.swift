//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Julius Danek on 09.06.15.
//  Copyright (c) 2015 Julius Danek. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEcho: AVAudioPlayer!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        //Received audio gets accessed through the filePathUrl (couldn't we hardcode this and store it somewhere as a global variable?)
        // Do any additional setup after loading the view.
        audioEcho = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioPlay(playRate:Float, echo: Bool) {
        audioPlayer.stop()
        audioEcho.stop()
        audioPlayer.currentTime = 0
        audioPlayer.rate = playRate
        audioPlayer.play()
        if (echo) {
            audioEcho.currentTime = 0
            audioEcho.volume = 0.8
            audioEcho.playAtTime(audioEcho.deviceCurrentTime + NSTimeInterval(0.5))
        }
    }
    //function for audioplaying and stopping. resets audio everytime and sees whether the effect should be echoed or not.
    
    func audioEngineReset (){
        audioEngine.stop()
        audioEngine.reset()
        //resets audio engine
    }
    
    @IBAction func SlowSound(sender: UIButton) {
        audioEngineReset()
        audioPlay(0.5, echo: false)
    }

    @IBAction func FastSound(sender: UIButton) {
        audioEngineReset()
        audioPlay(2.0, echo: false)
    }
    
    @IBAction func StopSound(sender: UIButton) {
        audioPlayer.stop()
        audioEngineReset()
        audioEcho.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func echoSound(sender: UIButton) {
        audioPlay(1.0, echo: true)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        //attach the node to audioEngine
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        //pitch effect added to audioEngine
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        //connecting the audioplaying to the effect and then to the output
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        //starts audioengine with the the file
        
        audioPlayerNode.play()
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
