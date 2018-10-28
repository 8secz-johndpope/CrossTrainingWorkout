//
//  AppDelegate.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 21/01/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit
import RealmSwift

extension Realm {
    
    func filter<ParentType: Object>(parentType: ParentType.Type, subclasses: [ParentType.Type]) -> [ParentType] {
        return ([parentType] + subclasses).flatMap { classType in
            return Array(self.objects(classType))
        }
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // --------------------------------------------
        // - CREATING ATHLETES
        // --------------------------------------------
        
        let athlete1 = Athlete()
        athlete1.id = "1"
        athlete1.firstName = "Jonathan"
        athlete1.lastName = "Arnal"
        
        let athlete2 = Athlete()
        athlete2.id = "2"
        athlete2.firstName = "Mégane"
        athlete2.lastName = "Moreira"
        
        let athlete3 = Athlete()
        athlete3.id = "3"
        athlete3.firstName = "Kibin"
        athlete3.lastName = "Machado"
        
        // --------------------------------------------
        // - CREATING MOVEMENTS
        // --------------------------------------------
        
        let muscleUP = Movement()
        muscleUP.name = "Muscle-up"
        muscleUP.categories = List<Int>()
        muscleUP.amountType = 1
        
        let pushUp = Movement()
        pushUp.name = "Push-up"
        pushUp.categories = List<Int>()
        pushUp.amountType = 1
        
        let run = Movement()
        run.name = "Run"
        run.categories = List<Int>()
        run.amountType = 1
        
        // --------------------------------------------
        // - CONFIGURING MOVEMENTS
        // --------------------------------------------
        
        let muConf = MovementConfiguration()
        muConf.amount = 20
        muConf.movement = muscleUP
        
        let puConf = MovementConfiguration()
        puConf.amount = 20
        puConf.movement = pushUp
        
        let runConf = MovementConfiguration()
        runConf.amount = 1000
        runConf.movement = run
        
        // --------------------------------------------
        // - CREATING WOD
        // --------------------------------------------
        
        let movements = List<MovementConfiguration>()
        movements.append(objectsIn: [muConf, puConf, runConf])
        
        let amrap = Wod()
        amrap.id = "1"
        amrap.wodType = .amrap
        amrap.name = "The first WOD1"
        amrap.movements = movements
        amrap.timeCap = 20
        
        let forTime = Wod()
        forTime.wodType = .forTime
        forTime.id = "2"
        forTime.name = "The second WOD"
        forTime.movements = movements
        forTime.timeCap = 20
        
        // --------------------------------------------
        // - CREATING RESULTS
        // --------------------------------------------
        
        let result1 = TimeResult()
        result1.athlete = athlete2
        result1.time = 2000
        
        let result2 = TimeResult()
        result2.athlete = athlete2
        result2.time = 3000
        
        let result3 = TimeResult()
        result3.athlete = athlete2
        result3.time = 4000
        
        // --------------------------------------------
        // - CREATING RESULTS
        // --------------------------------------------
        
//        let testMap = Map(mappingType: .fromJSON, JSON: ["": ""])
        
        let session1 = SessionAmrap()
        session1.date = Date()
        session1.wod = amrap
        
        let session2 = SessionForTime()
        session2.date = Date()
        session2.wod = forTime
        
        let session3 = SessionAmrap()
        session3.date = Date()
        session3.wod = amrap
        
        let session4 = SessionAmrap()
        session4.date = Date()
        session4.wod = amrap
        
//        let sessions: [Session] = [session1, session2]
        
//        print("🔥🔥🔥 \(Model.self is Object.self)")
//        print("🔥🔥🔥 \(String == Query)")
    
        let realm = try! Realm()
        try! realm.safeWrite(withoutNotifying: []) {
            realm.deleteAll()
            
            realm.add(athlete1)
            realm.add(athlete2)
            realm.add(athlete3)
        }
        
//        let sessions6: [Session] = realm.loadObjects(withParentType: Session.self, subclasses: [SessionAmrap.self, SessionForTime.self, SessionEmom.self])
//        print( sessions6 )
        
//        let testttt = realm.objects(SessionAmrap.self)
//        testttt.observe { (changes) in
//            switch changes {
//            case .initial: break
////                tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//                // Query results have changed, so apply them to the UITableView
//                print("⚠️ Insertions \(insertions)")
//                DispatchQueue.main.async {
//                    print(testttt.count)
//                }
////                print("⚠️ Modifications \(modifications)")
//            case .error(let error):
//                // handle error
//                ()
//            }
//        }
        
//        let results = realm.loadObjects(ofType: SessionAmrap.self, matching: nil) { changes in
//            switch changes {
//            case .initial:
//                print(realm.objects(SessionAmrap.self).count)
//                print("initial")
//            case .update(let deletions, let insertions, let modifications):
////                print(realm.objects(SessionAmrap.self).count)
//                print("deletions \(deletions)")
//                print("insertions \(insertions)")
//                print("modifications \(modifications)")
//            case .error(let error):
//                print("error")
//            }
//        }
        
//        var data: [SessionAmrap] = results.results
        
//        try! realm.write {
//            realm.add(athlete1)
//            realm.add(athlete2)
//            realm.add(athlete3)
//        }
//
//        try! realm.write {
//            realm.add(session1)
//        }
//
//        try! realm.write {
//            realm.add(session2)
//            realm.add(session4)
//        }
//
//        try! realm.write {
//            realm.add(session3)
//        }
        
//        realm.invalidate(token: results.token!)
//
//        try! realm.write {
//            realm.add(session4)
//        }
        
//        print(realm.objects(SessionAmrap.self).count)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

