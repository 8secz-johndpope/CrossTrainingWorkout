//
//  ReadableDatabase.swift
//  efitbackPraticien
//
//  Created by Jonathan Arnal on 16/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation

protocol ReadableDatabase {
    
    /// Load all objects for a given type
    ///
    /// - Parameters:
    ///   - type: type the object to retrieve
    ///   - query: query to filter objects
    /// - Returns: array of objects retrieved
    func loadObjects<T: Storable>(ofType type: T.Type, matching query: NSPredicate?) -> [T]
    
    /// Load object of type depending on the given id
    ///
    /// - Parameters:
    ///   - type: type the object to retrieve
    ///   - id: id of the object
    /// - Returns: Object retrieved
    func loadObject<T: Storable>(ofType type: T.Type, withID id: String) -> T?
    
    /// Load objects of a given type with all of his subclasses
    ///
    /// - Parameters:
    ///   - parentType: root parent type
    ///   - subclasses: list of subclasses to retrieve
    /// - Returns: array of objects retrieved
    func loadObjects<T: Storable>(withParentType parentType: T.Type, subclasses: [T.Type]) -> [T]
}

enum ReadableDatabaseError: Error {
    case invalidType
}
