//
//  AthletesListViewController.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 18/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit
import RealmSwift

protocol AthletesDataSourceDelegate: class {
    func didUpdate()
}

class EntityDataSource<Entity: Object, CellView: UITableViewCell & ReusableCell, CellViewModel> : NSObject, UITableViewDataSource where CellView.Model == CellViewModel {

    var entities: Results<Entity>?
    
    init(withEntities entities: Results<Entity>?) {
        self.entities = entities
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellView.cellIdentifier, for: indexPath) as! CellView
        let entity = entities![indexPath.row]
        let viewModel = buidViewModel(withEntity: entity)
        cell.configure(withModel: viewModel)
        
        return cell
    }
    
    internal func buidViewModel(withEntity entity: Entity) -> CellViewModel {
        fatalError("Should be overriden")
    }
}

class AthleteDataSource: EntityDataSource<Athlete, AthleteCell, AthleteCellViewModel> {
    
    override func buidViewModel(withEntity entity: Athlete) -> AthleteCellViewModel {
        
        var viewModel = AthleteCellViewModel(firstName: "", lastName: "")
        viewModel.firstName = entity.firstName
        viewModel.lastName = entity.lastName
        return viewModel
    }
    
}

struct AthleteCellViewModel {
    
    var firstName: String
    var lastName: String
    
    var fullName: String {
        return "\(firstName)\(lastName)"
    }
}

class AthleteCell: UITableViewCell, ReusableCell {
    
    typealias Model = AthleteCellViewModel
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    func configure(withModel model: AthleteCellViewModel) {
        self.fullNameLabel.text = model.fullName
    }
}

class AthletesListViewController: UIViewController {
    
    var dataSource: AthleteDataSource!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        segue.destination.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBOutlet var tableView: UITableView! {
        didSet {

            let realm = try! Realm()
            let athletes: Results<Athlete> = realm.objects(Athlete.self)
            
            dataSource = AthleteDataSource(withEntities: athletes)
            
            tableView.dataSource = self.dataSource
            tableView.delegate = self
            tableView.reloadData()
        }
    }
    
    @IBOutlet var addAthleteButton: UIButton! {
        didSet {
            //?
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor(hexString: "#5B708A")
    }

}

extension AthletesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Suppr") { (action, indexPath) in
            print("deleteAction")
        }
        
        let showResultsAction = UITableViewRowAction(style: .default, title: "Résultats") { (action, indexPath) in
            print("showResultsAction")
        }
        
        return [showResultsAction, deleteAction]
    }
    
}

