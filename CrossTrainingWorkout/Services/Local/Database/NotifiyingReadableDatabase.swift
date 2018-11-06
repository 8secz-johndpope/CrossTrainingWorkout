//
//  NotifiyingReadableDatabase.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 02/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation

protocol NotifiyingReadableDatabase: ReadableDatabase {
    
    /// Loads objects and subscribe for events on the retrieved objects
    ///
    /// - Parameters:
    ///   - type:
    ///   - query: <#query description#>
    ///   - observeBlock: <#observeBlock description#>
    /// - Returns: <#return value description#>
    func loadObjects<T: Storable>(ofType type: T.Type, matching query: NSPredicate?, observeBlock: ( (DatabaseCollectionChange)->Void )? ) -> DatabaseResults<T>
    
    /// Invalidate a specific observer token
    ///
    /// - Parameter token: token to stop
    func invalidateObserver(token: NotifiyingToken)
    
}
