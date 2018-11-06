//
//  RealmDatabase.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 11/02/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension Object: Storable {}
extension NotificationToken: NotifiyingToken {}

typealias Database = ReadableDatabase & WrittableDatabase & DeletableDatabase
typealias NotificationDatabase = ReadableDatabase & NotifiyingWrittableDatabase & DeletableDatabase

class DatabaseResults<T> {
    
    let results: [T]
    let token: NotifiyingToken?
    
    init(withResults results: [T], andToken token: NotifiyingToken?) {
        self.results = results
        self.token = token
    }
    
}

extension Realm {
    
    public func safeWrite(withoutNotifying tokens: [NotificationToken], _ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            beginWrite()
            try block()
            try commitWrite(withoutNotifying: tokens)
        }
    }
}

extension Realm: WrittableDatabase {
    
    func save<T>(_ object: T, updateIfExisting update: Bool) throws where T : Storable {
        
        guard let modelObject = object as? Object else { throw ReadableDatabaseError.invalidType }
        try self.safeWrite(withoutNotifying: []) {
            self.add(modelObject, update: update)
        }
    }
    
    func save<T>(_ objects: [T], updateIfExisting update: Bool) throws where T : Storable {
        
        guard let modelObjects = objects as? [Object] else { throw NotifiyingDatabaseError.invalidTokenType }
        
        try self.safeWrite(withoutNotifying: []) {
            for modelObject in modelObjects {
                self.add(modelObject, update: update)
            }
        }
    }
    
    func update(withBlock block: @escaping () -> Void) throws {
        
        try self.safeWrite(withoutNotifying: []) {
            block()
        }
    }
}

extension Realm: DeletableDatabase {
    
    func delete<T>(_ object: T) throws where T : Storable {
        
        guard let modelObject = object as? Object else { throw NotifiyingDatabaseError.invalidTokenType }
        try self.safeWrite(withoutNotifying: []) {
            self.delete(modelObject)
        }
    }
    
    func deleteAll<T>(ofType type: T) throws where T : Storable {
        
        let objects = self.loadObjects(ofType: T.self, matching: nil)
        try self.safeWrite(withoutNotifying: []) {
            for object in objects {
                try self.delete(object)
            }
        }
    }
}

extension Realm: NotifiyingWrittableDatabase {
    
    func save<T>(_ objects: [T], updateIfExisting update: Bool, withoutNotifying tokens: [NotifiyingToken]) throws where T : Storable {
        
        guard let realmTokens = tokens as? [NotificationToken] else { throw NotifiyingDatabaseError.invalidTokenType }
        guard let modelObjects = objects as? [Object] else { throw NotifiyingDatabaseError.invalidTokenType }
        
        try self.safeWrite(withoutNotifying: realmTokens) {
            for modelObject in modelObjects {
                self.add(modelObject, update: update)
            }
        }
    }
    
    func save<T>(_ object: T, updateIfExisting update: Bool, withoutNotifying tokens: [NotifiyingToken]) throws where T : Storable {
        
        guard let realmTokens = tokens as? [NotificationToken] else { throw NotifiyingDatabaseError.invalidTokenType }
        guard let modelObject = object as? Object else { throw NotifiyingDatabaseError.invalidTokenType }
        
        try self.safeWrite(withoutNotifying: realmTokens) {
            self.add(modelObject, update: update)
        }
    }
    
    func update(withoutNotifying tokens: [NotifiyingToken], withBlock block: @escaping () -> Void) throws {
        
        guard let realmTokens = tokens as? [NotificationToken] else { throw NotifiyingDatabaseError.invalidTokenType }
        try self.safeWrite(withoutNotifying: realmTokens) {
            block()
        }
    }
}

extension Realm: ReadableDatabase {
    
    func loadObject<T>(ofType type: T.Type, withID id: String) -> T? where T : Storable {
        
        let typeName = String(describing: T.self)
        let result: T? = self.dynamicObject(ofType: typeName, forPrimaryKey: id) as? T
        return result
    }
    
    func loadObjects<T>(ofType type: T.Type, matching query: NSPredicate?) -> [T] where T : Storable {
        
        let typeName = String(describing: T.self)
        if let unwrappedQuery = query {
            
            let results = self.dynamicObjects(typeName).filter(unwrappedQuery)
            return Array(results) as! [T]
            
        } else {
            
            let results = self.dynamicObjects(typeName)
            return Array(results) as! [T]
        }
    }
    
    func loadObjects<T>(withParentType parentType: T.Type, subclasses: [T.Type]) -> [T] where T : Storable {
        
        var results = [T]()
        ([parentType] + subclasses).forEach { classType in
            let typeName = String(describing: classType)
            let objects: [T] = Array( self.dynamicObjects(typeName) ) as! [T]
            results = results + objects
        }
        return results
    }
    
}

enum DatabaseCollectionChange {

    case initial
    case update(deletions: [Int], insertions: [Int], modifications: [Int])
    case error(Error)
}

extension Realm: NotifiyingReadableDatabase {
    
    func invalidateObserver(token: NotifiyingToken) {
        
        guard let realToken = token as? NotificationToken else { fatalError("❌ Wrong type of token") }
        realToken.invalidate()
    }
    
    internal func observe<T>(_ objects: Results<T>, observerBlock block: @escaping (DatabaseCollectionChange) -> Void) -> NotifiyingToken where T : Storable {
        
        return objects.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                block( .initial )
            case .update(_, let deletions, let insertions, let modifications):
                block( .update(deletions: deletions, insertions: insertions, modifications: modifications) )
            case .error(let error):
                block( .error(error) )
            }
        }
    }
    
    func loadObjects<T>(ofType type: T.Type, matching query: NSPredicate?, observeBlock: ( (DatabaseCollectionChange)->Void )? ) -> DatabaseResults<T> where T : Storable {

        let typeName = String(describing: T.self)
        
        let results: Results<DynamicObject>
        if let unwrappedQuery = query {
            results = self.dynamicObjects(typeName).filter(unwrappedQuery)
        } else {
            results = self.dynamicObjects(typeName)
        }
        
        let arrayResults = Array(results) as! [T]
        
        var token: NotifiyingToken?
        if let unwrappedObserveBlock = observeBlock {
            token = observe(results, observerBlock: unwrappedObserveBlock)
        }
        
        return DatabaseResults(withResults: arrayResults, andToken: token)
    }
    
}

