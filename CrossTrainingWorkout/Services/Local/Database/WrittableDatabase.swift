//
//  WrittableDatabase.swift
//  efitbackPraticien
//
//  Created by Jonathan Arnal on 16/02/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import Foundation

protocol WrittableDatabase {
    
    /// Save a storable object into database
    ///
    /// - Parameters:
    ///   - object: object to store
    ///   - update: defines if object needs to be updated or just added
    /// - Throws: database errors
    func save<T: Storable>(_ object: T, updateIfExisting update: Bool) throws
    
    /// Save a list of storable objects into database
    ///
    /// - Parameters:
    ///   - objects: list of objects to store
    ///   - update: defines if objects needs to be updated or just added
    /// - Throws: database errors
    func save<T: Storable>(_ objects: [T], updateIfExisting update: Bool) throws
    
    /// Update specifically and object
    /// Called when the operation on the object is a bit complexe
    ///
    /// - Parameter block: block containing the update logic
    /// - Throws: database errors
    func update(withBlock block: @escaping () -> Void) throws
    
}
