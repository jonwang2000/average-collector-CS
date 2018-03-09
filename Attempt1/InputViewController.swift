//
//  InputViewController.swift
//  Attempt1
//
//  Created by Wang, Jonathan on 2018-03-03.
//  Copyright © 2018 JonathanWang. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var avgTextField: UITextField!
    @IBOutlet weak var weightsTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var course: Course?
    
    // Function that will turn the given Double array into a String to be outputted back to user 
    // DON'T REMOVE THIS IT'LL CRASH THE APP
    func convertToString(x:[Double]) -> String {
        var withoutCommas = String(x).componentsSeparatedByString(",")
        for a in 0...x.count - 1 {
            withoutCommas[a] = withoutCommas[a].stringByReplacingOccurrencesOfString("[", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            withoutCommas[a] = withoutCommas[a].stringByReplacingOccurrencesOfString("]", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            withoutCommas[a] = withoutCommas[a].stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
        
        let combineThis = withoutCommas.joinWithSeparator(", ")
        return combineThis
    }
    
    func convertToDouble(x:String) -> [Double] {
        let removeSpaces = x.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let removeSpaces1 = removeSpaces.componentsSeparatedByString(",")
        let doubleList = removeSpaces1.map{Double($0)!}
        return doubleList
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        weightsTextField.delegate = self
        
        if let course = course {
            nameTextField.text = course.name
            navigationItem.title = course.name
            avgTextField.text = convertToString(course.avgs)
            weightsTextField.text = convertToString(course.weights)
        }
        
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        print(textField)
        saveButton.enabled = false
        if textField == weightsTextField {
            print("test")
            moveTextField(textField, moveDistance: -250, up: true)
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == weightsTextField {
            moveTextField(textField, moveDistance: -250, up: false)
        }
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField(textfield: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
        
    }
    
    // MARK: Navigation (real)
    
    @IBAction func cancel(sender: UIBarButtonItem) {
//        let isPresentinginAddCourseMode = presentingViewController is UINavigationController
//        if isPresentinginAddCourseMode {
//            dismissViewControllerAnimated(true, completion: nil)
//        } else if let owningNavigationController = navigationController {
//            owningNavigationController.popViewControllerAnimated(true)
//        } else {
//            fatalError()
//        }
        
          // I'm not too sure why the above doesn't work; it seems I can only cancel one type (Edit or Add)
          // I think add is more useful so we'll keep it like this for now I guess
          dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem where button === saveButton else {
            return
        }
        
        let name = nameTextField.text ?? ""
        let marks_input = avgTextField.text!
        let weights_input = weightsTextField.text!
        
        
//        let marks_split = marks_input.componentsSeparatedByString(",")
//        let weights_split = weights_input.componentsSeparatedByString(",")
        
        let marks = convertToDouble(marks_input)
        let weights = convertToDouble(weights_input)
        
        course = Course(name: name, avgs: marks, weights: weights)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    private func updateSaveButtonState(){
        //Disable save button if text fields are empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
        
    }

}
