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
    
    var audioEngine: AVAudioEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            var fileUrl = NSURL.fileURLWithPath(filePath)
//            
//        } else {
//            println("Couldn't find file")
//        }
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        //Received audio gets accessed through the filePathUrl (couldn't we hardcode this and store it somewhere as a global variable?)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioPlay(playRate:Float) {
        audioPlayer.stop()
        audioPlayer.rate = playRate
        audioPlayer.play()
    }
    
    @IBAction func SlowSound(sender: UIButton) {
        audioPlay(0.5)
    }

    @IBAction func FastSound(sender: UIButton) {
        audioPlay(2.0)
    }
    
    @IBAction func StopSound(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
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
