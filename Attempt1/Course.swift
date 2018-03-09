//
//  Course.swift
//  Attempt1
//
//  Created by Wang, Jonathan on 2018-03-03.
//  Copyright © 2018 JonathanWang. All rights reserved.
//

import UIKit

class Course: NSObject, NSCoding {
    
    //MARK: Properties
    struct PropertyKey {
        static let name = "name"
        static let avgs = "avgs"
        static let weights = "weights"
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("courses")
    
    var name: String!
    var avgs = [Double]()
    var weights = [Double]()
    
    init?(name:String, avgs: [Double], weights: [Double]){
        
        if name.isEmpty || avgs.isEmpty || weights.isEmpty {
            return
        }
        
        self.name = name
        self.avgs = avgs
        self.weights = weights
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.name)
        aCoder.encodeObject(avgs, forKey: PropertyKey.avgs)
        aCoder.encodeObject(weights, forKey: PropertyKey.weights)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObjectForKey(PropertyKey.name) as? String
            else {
                return nil
        }
        let avgs = aDecoder.decodeObjectForKey(PropertyKey.avgs) as? [Double]
        let weights = aDecoder.decodeObjectForKey(PropertyKey.weights) as? [Double]
        
        self.init(name: name, avgs: avgs!, weights: weights!)
    }
    
}