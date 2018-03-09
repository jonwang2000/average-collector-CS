//
//  FirstTableViewController.swift
//  Attempt1
//
//  Created by Wang, Jonathan on 2018-03-04.
//  Copyright © 2018 JonathanWang. All rights reserved.
//

import UIKit

extension Double {
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor)/divisor
    }
}

class FirstTableViewController: UITableViewController {

    
    func weightedAverage(avgs:[Double], weights: [Double]) -> Double {
        var weighted = 0.0
        var result:Double = 0
        var fullweighted = 0.0
        for x in 0...avgs.count - 1 {
            let avg = avgs[x]
            let weight = weights[x]/100
            weighted = weighted + (avg*weight)
            fullweighted = fullweighted + weight
        }
        result = weighted/fullweighted
        result = result.roundToPlaces(1)
        return result
    }
    
    func Average(list:[Double]) -> Double {
        var numbers = 0.0
        var result: Double
        var meme: Int
        if list.count == 0 {
            meme = 0
        } else {
            meme = list.count - 1
            for x in 0...meme {
                numbers += list[x]
            }
        }
        result = numbers/Double(list.count)
        return result
    }
    
    // Global Variable
    struct GlobalVariable {
        static var overallAvg = [Double]()
        static var actualAvg:Double = 0.0001
        static var avgtrend:Bool = true
    }
    
    var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedCourses = loadCourses(){
            courses = savedCourses
        }
        else {
            // Load the test data
            loadSampleCourses()
        }
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        courses = loadCourses()!
        tableView.reloadData()
        
        let a = Average(GlobalVariable.overallAvg)
        GlobalVariable.overallAvg.removeAll()
        
        
        
        for x in 0...courses.count - 1 {
            GlobalVariable.overallAvg.append(weightedAverage(courses[x].avgs, weights: courses[x].weights))
        }
        
        let b = Average(GlobalVariable.overallAvg)
        // actualAvg = Average(overallAvg)
        
        if a == b {
        }
        else if a > b {
            GlobalVariable.avgtrend = false
        } else {
            GlobalVariable.avgtrend = true
        }
        
        GlobalVariable.actualAvg = Average(GlobalVariable.overallAvg)
        
        
        print(GlobalVariable.actualAvg)
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "FirstTableViewCell"
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? FirstTableViewCell else {
            fatalError()
        }
        
        let course = courses[indexPath.row]
        
        cell.CourseNameLabel.text = course.name
        
        let avg_text = String(weightedAverage(course.avgs, weights: course.weights))
        cell.AverageLabel.text = "\(avg_text)%"
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
