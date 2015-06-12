//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Julius Danek on 09.06.15.
//  Copyright (c) 2015 Julius Danek. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var RecordingLabel: UILabel!
    @IBOutlet weak var StopButton: UIButton!
    @IBOutlet weak var RecordingButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RecordAudio(sender: UIButton) {
        pauseButton.hidden = false
        StopButton.hidden = false
        RecordingLabel.text = "recording"
        RecordingButton.enabled = false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        //assign directory path
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        //path for file, consisting of name of file and the path to the storing directory
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        //starting an audiosession for recording and playing
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }
    
    @IBAction func pauseRecording(sender: UIButton) {
        println("start click")
        if (pauseButton.titleLabel?.text == "Pause Recording") {
            audioRecorder.pause()
            pauseButton.setTitle("Resume Recording", forState: nil)
            RecordingLabel.text = "recording paused"
            println("Pause")
        } else if (pauseButton.titleLabel!.text == "Resume Recording") {
            audioRecorder.record()
            pauseButton.setTitle("Pause Recording", forState: nil)
            RecordingLabel.text = "recording"
            println("resume")
        }
        println("end click")
    }
    //let's the recording play and pause dependent on the label text.

    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag) {
        
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            //if audiorecording has been processed successfully, segue can be performed.
            
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            println("Recording successful")
            //Segue identifier shows 1. which segue will be performed
        } else {
            println("Recording was not successful")
            RecordingButton.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            //This is why identifier is important, if the segue identifier fits the profile, data will get passed
            let playSoundsVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            //allowing data to pass to next viewcontroller.
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
            // First we are accessing the destination VC and then we are creating a variable for our own data which then gets passed into the destination VCs variable. 
        }
    }
    
    @IBAction func StopAudio(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        //
        
    }
    
    override func viewWillAppear(animated: Bool) {
        StopButton.hidden = true
        RecordingButton.enabled = true
        RecordingLabel.text = "Tap Mic To Record"
        pauseButton.hidden = true
        //rearranging buttons so they appear as in the beginning
    }

}

