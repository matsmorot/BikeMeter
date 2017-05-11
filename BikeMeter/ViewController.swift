//
//  ViewController.swift
//  BikeMeter
//
//  Created by Mattias Almén on 2017-03-22.
//  Copyright © 2017 pixlig.se. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var primaryProgress: KDCircularProgress!
    @IBOutlet weak var secondaryProgress: KDCircularProgress!
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    @IBOutlet weak var startButton: UIBarButtonItem!
    
    @IBOutlet weak var stopButton: UIBarButtonItem!
    
    @IBAction func startButtonPressed(_ sender: Any) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        motionManager.startDeviceMotionUpdates(to:
            OperationQueue.current!, withHandler: {
                (deviceMotion, error) -> Void in
                
                if(error == nil) {
                    self.handleDeviceMotionUpdate(deviceMotion: deviceMotion!)
                } else {
                    print("Device Motion not available")
                }
        })
        
        let startTime = DispatchTime.now()
        print(startTime)
        stopWatch.start()
        
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimeLabel(_:)), userInfo: nil, repeats: true)
    }
    
    @IBAction func levelButtonPressed(_ sender: Any) {
        level += grade
    }

    @IBAction func stopButtonPressed(_ sender: Any) {
        stopButton.isEnabled = false
        startButton.isEnabled = true
        motionManager.stopDeviceMotionUpdates()
        stopWatch.stop()
        
        print(183.042.hourMinuteSecondMS)
    }
    
    var motionManager: CMMotionManager!
    var deviceMotion: CMDeviceMotion!
    
    var stopWatch = Stopwatch()
    
    // Data point variables
    var elapsedTime: DispatchTime!
    var grade: Double = 0.0
    var level: Double = 0.0
    
    var bikeData = [String : String]()
    var indexedKeys = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gradientLayer = Gradients.gray
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        motionManager = CMMotionManager()
        motionManager.deviceMotionUpdateInterval = 1
        
        if motionManager.deviceMotion != nil {
            deviceMotion = motionManager.deviceMotion
        }
    }
    
    func updateTimeLabel(_ timer: Timer) {
        if stopWatch.isRunning {
            secondaryLabel.text = stopWatch.elapsedTime.hourMinuteSecondMS
            //secondaryProgress.animate(toAngle: Double(stopWatch.elapsedTime.second * 6), duration: 0.1, relativeDuration: false, completion: nil)
            secondaryProgress.angle = Double(stopWatch.elapsedTime.second * 6)
        } else {
            timer.invalidate()
        }
    }
    
    func handleDeviceMotionUpdate(deviceMotion: CMDeviceMotion) {
        
        //let acceleration = deviceMotion.userAcceleration
        
        let attitude = deviceMotion.attitude
        //let roll = attitude.roll
        let pitch = attitude.pitch
        //let yaw = attitude.yaw
        
        let gradeDegrees = pitch * 360 / (2 * .pi) * 4 - level
        let gradePercent = 100 * pitch * 360 / (2 * .pi) / 90 - level
        
        grade = gradePercent
        
        let roundedValue = Double(round(10 * grade) / 10)
        
        primaryLabel.text = "\(roundedValue) %"
        // Animation of grade progress too energy consuming, and too sluggish without it.
        //primaryProgress.animate(toAngle: gradeDegrees, duration: 0.9, relativeDuration: true, completion: nil)
        primaryProgress.angle = gradeDegrees
        
        //print("Roll: \(roll), Pitch: \(pitch), Yaw: \(yaw)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

