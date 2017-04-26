//
//  Tower.swift
//  The Alan Parsons Project
//
//  Created by Thomas Schönmann on 10.04.17.
//  Copyright © 2017 Thomas Schönmann. All rights reserved.
//

import Foundation

class BuildableUnit : Hashable {
    
    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    var hashValue: Int {
        get {
            return "\(self.column),\(self.row)".hashValue
        }
    }

    let initalResourcesRequired: [Resources : Double]
    var currentResourcesRequired = [Resources : Double]()
    let column: Int
    let row: Int
    let category: BuildableUnitCategories
    //var visual: VisualRepresentation?
    
    init(column: Int, row: Int, initalResourcesRequired: [Resources : Double], category: BuildableUnitCategories) {
        guard column >= 0 && row >= 0 else {
            print("ERROR @ Building : init() : One or more arguments are invalid.")
            abort()
        }
        
        self.column = column
        self.row = row
        self.category = category
        
        // Dictonaries get passed by value.
        // -> http://stackoverflow.com/questions/24816754/how-to-copy-a-dictionary-in-swift
        self.initalResourcesRequired = initalResourcesRequired
        self.currentResourcesRequired = initalResourcesRequired
    }
    
    init() {
        self.column = -1
        self.row = -1
        self.category = .Miscellaneous
        self.initalResourcesRequired = [Resources : Double]()
    }
    
    static func == (lhs: BuildableUnit, rhs: BuildableUnit) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}