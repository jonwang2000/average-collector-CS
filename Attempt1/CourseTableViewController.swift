//
//  CourseTableViewController.swift
//  Attempt1
//
//  Created by Wang, Jonathan on 2018-03-03.
//  Copyright © 2018 JonathanWang. All rights reserved.
//

import UIKit


class CourseTableViewController: UITableViewController {

    //MARK: Properties
    var courses = [Course]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedCourses = loadCourses(){
            courses += savedCourses
        }
        else {
            // Load the test data
            loadSampleCourses()
        }
        
        
        
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
        
        let cellIdentifier = "CourseTableViewCell"
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? CourseTableViewCell else {
            fatalError("The dequeued cell is not an instance of CourseTableViewCell.")
        }
        
        let course = courses[indexPath.row]
        
        cell.nameLabel.text = course.name

        // Configure the cell...

        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            courses.removeAtIndex(indexPath.row)
            saveCourses()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "AddItem":
                return
            case "ShowDetail":
                guard let courseDetailViewController = segue.destinationViewController as? InputViewController else {
                    fatalError()
                }
            
                guard let selectedCourseCell = sender as? CourseTableViewCell else {
                    fatalError()
                }
            
                guard let indexPath = tableView.indexPathForCell(selectedCourseCell) else {
                    fatalError()
                }
            
                let selectedCourse  = courses[indexPath.row]
                courseDetailViewController.course = selectedCourse
            
        default:
            fatalError()
        }
    }
    
    
    
    //MARK: Private Methods
    private func loadSampleCourses() {
        
        guard let course1 = Course(name: "Test Course", avgs: [100.0], weights: [100.0]) else {
            fatalError("Unable to instantiate test course")
        }
        
        courses += [course1]
    }
    
    private func saveCourses() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(courses, toFile: Course.ArchiveURL.path!)
        if isSuccessfulSave {
            print("Worked")
        } else {
            print("didn't save lol")
        }
    }
    
    private func loadCourses() -> [Course]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Course.ArchiveURL.path!) as? [Course]
    }
    
    //MARK: Actions
    
    @IBAction func unwindToCourseList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? InputViewController, course = sourceViewController.course {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing course
                courses[selectedIndexPath.row] = course
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .Automatic)
            } else {
                //Add a new course
                let newIndexPath = NSIndexPath(forRow: courses.count, inSection: 0)
            
                courses.append(course)
            
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
            }
            saveCourses()
        }
    }

}
