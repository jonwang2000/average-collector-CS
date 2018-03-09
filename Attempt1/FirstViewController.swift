//
//  FirstViewController.swift
//  Attempt1
//
//  Created by Wang, Jonathan on 2018-02-28.
//  Copyright © 2018 JonathanWang. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var YourAvgLbl: UILabel!
    @IBOutlet weak var redTri: UIImageView!
    @IBOutlet weak var greenTri: UIImageView!
    
    
    
    
    var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        print("loaded")
//        
//        if let savedCourses = loadCourses(){
//            courses += savedCourses
//        }
//        else {
//            // Load the test data
//            loadSampleCourses()
//        }
//        
//        
//        YourAvgLbl.text = ("Your Average is: \(avg)%")
//        //label.text = courses[0].name
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let avg = FirstTableViewController.GlobalVariable.actualAvg
        let avgtrend = FirstTableViewController.GlobalVariable.avgtrend
        
        print("loaded")
        
        if let savedCourses = loadCourses(){
            courses += savedCourses
        }
        else {
            // Load the test data
            loadSampleCourses()
        }
        
        if avg == 0.0001 {
            YourAvgLbl.text = ("Swap tabs!")
        } else {
        let avg1 = avg.roundToPlaces(1)
        YourAvgLbl.text = ("Your Average is: \(avg1)%")
        }
        
        if avgtrend == true {
            greenTri.hidden = false
            redTri.hidden = true
        } else {
            redTri.hidden = false
            greenTri.hidden = true
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    private func loadSampleCourses() {
        
        guard let course1 = Course(name: "Test Course", avgs: [100.0], weights: [100.0]) else {
            fatalError("Unable to instantiate test course")
        }
        
        courses += [course1]
    }
    
    private func loadCourses() -> [Course]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Course.ArchiveURL.path!) as? [Course]
    }


}

