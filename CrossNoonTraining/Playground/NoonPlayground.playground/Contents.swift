//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

//class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .white
//
//        let label = UILabel()
//        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
//        label.text = "Hello World!"
//        label.textColor = .black
//
//        view.addSubview(label)
//        self.view = view
//    }
//}
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()

// --------------------------------------------
// - ATHLETE
// --------------------------------------------

class Athlete: CustomStringConvertible {

    var id: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    var age: Int!

    var fullName: String {
        return firstName
    }

    var description: String {
        guard let first = firstName, let last = lastName else { return "" }
        return "\(first) \(last)"
    }
}

// --------------------------------------------
// - WOD
// --------------------------------------------



//protocol Wodable {
//
//    associatedtype ResultType
//
//    var id: String! { get set }
//    var name: String! { get set }
//    var type: WODType! { get set }
//    var timeCap: TimeInterval! { get set }
////    var movements: [MovementConfiguration]? { get set }
//
//}

//enum WODType<T>: Int {
//
//    case amrap, emom, for_time, finisher
//
//    var resultType: T.Type {
//        return T.self
//    }
//}

class Wod<T>: CustomStringConvertible {

    var id: String!
    var name: String!
    var timeCap: TimeInterval!
    var resultType: T.Type {
        return T.self
    }
    var movements: [MovementConfiguration]?

    var description: String {
        guard let name = name else { return "" }
        return "\(self) - \(name)"
    }
}

class WodAmrap: Wod<RoundResult> {}

class WodEmom: Wod<EmomResult> {}

class WodForTime: Wod<TimeResult> {}

class WodFinisher: Wod<TimeResult> {}

// --------------------------------------------
// - RESULTS
// --------------------------------------------

protocol Resultable {
    var resultRepresentation: String { get }
}

class Result {
    var athlete: Athlete!

    required init() {
        print("New Result")
    }
}

class RoundResult: Result, Resultable {

    var repetitions: Int!
    var rounds: Int!

    var resultRepresentation: String {
        return "\(repetitions) + \(rounds)"
    }
}

class TimeResult: Result, Resultable {

    var time: TimeInterval!

    var resultRepresentation: String {
        return String(time)
    }
}

class EmomResult: Result, Resultable {

    // EMOM
    var resultRepresentation: String {
        return ""
    }
}

// --------------------------------------------
// - MOVEMENT
// --------------------------------------------

class Movement: CustomStringConvertible {

    enum MovementCategory {
        case weightLifting
        case bodyWeight
        case endurance
    }

    enum MovementAmoutType {

        case meters
        case repetitions

        var format: String {
            return "reps"
        }
    }

    var name: String?
    var categories: [MovementCategory]?
    var amountType: MovementAmoutType?

    var description: String {
        return name != nil ? name! : ""
    }
}

// --------------------------------------------
// - MOVEMENT CONFIGURATION
// --------------------------------------------

class MovementConfiguration: CustomStringConvertible {

    var movement: Movement?
    var amount: Int?

    var description: String {
        guard let mov = movement, let am = amount else { return "" }
        return "\(mov) x \(am)"
    }
}

// T should be the result type
class Session<T> {

    var wod: Wod<T>
    var date: Date!
    var results: [T]!

    init<WodType: Wod<T>>(_ wod: WodType) {
        self.wod = wod
        self.results = [T]()
    }
}

// --------------------------------------------
// - CREATING ATHLETES
// --------------------------------------------

let athlete1 = Athlete()
athlete1.firstName = "Jonathan"
athlete1.lastName = "Arnal"

let athlete2 = Athlete()
athlete2.firstName = "Mégane"
athlete2.lastName = "Moreira"

let athlete3 = Athlete()
athlete3.firstName = "Kibin"
athlete3.lastName = "Machado"

// --------------------------------------------
// - CREATING MOVEMENTS
// --------------------------------------------

let muscleUP = Movement()
muscleUP.name = "Muscle-up"
muscleUP.categories = [.bodyWeight]
muscleUP.amountType = .repetitions

let pushUp = Movement()
pushUp.name = "Push-up"
pushUp.categories = [.bodyWeight]
pushUp.amountType = .repetitions

let run = Movement()
run.name = "Run"
run.categories = [.endurance]
run.amountType = .meters

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

let amrap = WodAmrap()
amrap.id = "1"
//amrap.name = "The first WOD1"
amrap.movements = [muConf, puConf, runConf]
amrap.timeCap = 20

let forTime = WodForTime()
forTime.id = "2"
//forTime.name = "The second WOD"
forTime.movements = [muConf, puConf, runConf]
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

let amrapSession = Session(amrap)
amrapSession.date = Date()
print(amrapSession.results)

let forTimeSession = Session(forTime)
forTimeSession.results = [result1, result2, result3]
print(forTimeSession.results)

