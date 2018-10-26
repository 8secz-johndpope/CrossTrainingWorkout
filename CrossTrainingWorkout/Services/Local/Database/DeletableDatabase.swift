//
//  DeletableDatabase.swift
//  efitbackPraticien
//
//  Created by Jonathan Arnal on 16/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation

protocol DeletableDatabase {
    
    /// Delete an object from database
    ///
    /// - Parameter object: object to delete
    /// - Throws: database error
    func delete<T: Storable>(_ object: T) throws
    
    /// Delete all objects for a given type
    ///
    /// - Parameter type: type of object to remove
    /// - Throws: database error
    func deleteAll<T: Storable>(ofType type: T) throws
}
