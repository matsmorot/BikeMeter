//
//  ViewController.swift
//  BikeMeter
//
//  Created by Mattias Almén on 2017-03-22.
//  Copyright © 2017 pixlig.se. All rights reserved.
//

import UIKit
import CoreMotion
import QuartzCore

class ViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    
    @IBOutlet weak var mainLabel: UILabel!
    
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
    }
    
    @IBAction func levelButtonPressed(_ sender: Any) {
        level += grade
    }

    @IBAction func stopButtonPressed(_ sender: Any) {
        stopButton.isEnabled = false
        startButton.isEnabled = true
        motionManager.stopDeviceMotionUpdates()
        
        print(183.042.minuteSecondMS)
    }
    
    var carousel: iCarousel = iCarousel()
    
    var motionManager: CMMotionManager!
    var deviceMotion: CMDeviceMotion!
    
    var stopWatch = Stopwatch()
    
    // Data point variables
    var elapsedTime: DispatchTime!
    var grade: Double = 0.0
    var level: Double = 0.0
    
    var carouselData = [String : String]()
    var indexedKeys = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        carousel.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        carousel = iCarousel(frame: self.view.bounds)
        
        carousel.delegate = self
        carousel.dataSource = self
        
        carousel.type = .cylinder
        carousel.isVertical = true
        carousel.perspective = -0.0001
        
        view.insertSubview(carousel, at: 0)
        
        
        let margins = view.layoutMarginsGuide
        
        carousel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        carousel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        carousel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        carousel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        
        
        carouselData = ["Grade" : "0.0 %",
                        "Speed" : "0.0 km/h",
                        "Average speed" : "0.0 km/h",
                        "Max speed" : "0.0 km/h",
                        "Distance" : "0.0 km",
                        "Elevation gain" : "0 m",
                        "Elapsed time" : "0:00:00.000",
                        "Timer" : "0:0:0"]
        
        indexedKeys = [String](carouselData.keys)
        
        motionManager = CMMotionManager()
        motionManager.deviceMotionUpdateInterval = 0.2
        
        if motionManager.deviceMotion != nil {
            deviceMotion = motionManager.deviceMotion
        }
    }
    
    func handleDeviceMotionUpdate(deviceMotion: CMDeviceMotion) {
        
        let acceleration = deviceMotion.userAcceleration
        
        let attitude = deviceMotion.attitude
        //let roll = attitude.roll
        let pitch = attitude.pitch
        //let yaw = attitude.yaw
        
        let gradeDegrees = pitch * 360 / (2 * .pi) - level
        let gradePercent = 100 * pitch * 360 / (2 * .pi) / 90 - level
        
        grade = gradePercent
        
        let roundedValue = Double(round(10 * grade) / 10)
        
        carouselData["Grade"] = "\(roundedValue) %"
        carousel.reloadData()
        //carouselData["Speed"] = "Fort!"
        
        //print("Roll: \(roll), Pitch: \(pitch), Yaw: \(yaw)")
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return carouselData.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var header: UILabel
        var label: UILabel
        var footer: UILabel
        var itemView: UIImageView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
            header = itemView.viewWithTag(1) as! UILabel
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
            //itemView.image = UIImage(named: "page.png")
            itemView.contentMode = .center
            
            header = UILabel(frame: CGRect(x: itemView.frame.origin.x, y: itemView.frame.origin.y, width: itemView.frame.width, height: itemView.frame.height / 3))
            label = UILabel(frame: CGRect(x: itemView.frame.origin.x, y: header.frame.maxY, width: itemView.frame.width, height: itemView.frame.height / 3))
            footer = UILabel(frame: CGRect(x: itemView.frame.origin.x, y: label.frame.maxY, width: itemView.frame.width, height: itemView.frame.height / 3))
            
            //itemView.alpha = 0.9
            header.backgroundColor = UIColor.black
            label.backgroundColor = UIColor.black
            footer.backgroundColor = UIColor.black
            header.textColor = ColorPalette.mint
            label.textColor = ColorPalette.pink
            header.textAlignment = .center
            label.textAlignment = .center
            header.font = Fonts.medium
            label.font = Fonts.big
            header.tag = 1
            label.tag = 1
            itemView.addSubview(header)
            itemView.addSubview(label)
            itemView.addSubview(footer)
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        /*
        switch carouselData.keys {
        case "Grade":
            label.text = "\(carouselData["Grade"]!)"
        }*/
        
        if indexedKeys[index] == "Grade" {
            header.text = "\(indexedKeys[index])"
            label.text = "\(carouselData["Grade"]!)"
            
        } else if indexedKeys[index] == "Speed" {
            header.text = "\(indexedKeys[index])"
            label.text = "\(carouselData["Speed"]!)"
            
        } else if indexedKeys[index] == "Distance" {
            header.text = "\(indexedKeys[index])"
            label.text = "\(carouselData["Distance"]!)"
            
        } else if indexedKeys[index] == "Elevation gain" {
            header.text = "\(indexedKeys[index])"
            label.text = "\(carouselData["Elevation gain"]!)"
            
        } else if indexedKeys[index] == "Elapsed time" {
            header.text = "\(indexedKeys[index])"
            label.text = "\(carouselData["Elapsed time"]!)"
            
        } else if indexedKeys[index] == "Timer" {
            header.text = "\(indexedKeys[index])"
            label.text = "\(carouselData["Timer"]!)"
            
        } else if indexedKeys[index] == "Elapsed time" {
            header.text = "\(indexedKeys[index])"
            label.text = "\(carouselData["Elapsed time"]!)"
        }
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == .spacing {
            return value //* 1.1
        } /*else if option == .visibleItems {
            return 5
        }*/
        return value
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

