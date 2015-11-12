//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by Miguel Fagundez on 11/6/15.
//  Copyright © 2015 Miguel Fagundez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var persistedDataLbl: UILabel!
    @IBOutlet weak var choreFld: UITextField!
    @IBOutlet weak var personFld: UITextField!
    @IBOutlet weak var chorePckr: UIPickerView!
    @IBOutlet weak var personPckr: UIPickerView!
    @IBOutlet weak var datePckr: UIDatePicker!
    
    // MARK: - Variables
    var appDelegate : AppDelegate?
    var choreRollerHelper : PickerViewHelperViewController = PickerViewHelperViewController()
    var personRollerHelper : PickerViewHelperViewController = PickerViewHelperViewController()
    // MARK: - View Controller Life Cycle Methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Gets Reference to AppDelegate and Updates UI
        self.appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        self.chorePckr.delegate = self.choreRollerHelper
        self.chorePckr.dataSource = self.choreRollerHelper
        
        self.personPckr.delegate = self.personRollerHelper
        self.personPckr.dataSource = self.personRollerHelper
        
        
        self.updateChoreRoller()
        self.updatePersonRoller()
        self.updateLogList()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - IBActions
    
    @IBAction func addChoreTapped(sender: UIButton) {
    
        let c = self.appDelegate!.createChoreMO()
        c.chore_name = self.choreFld.text
        self.appDelegate?.saveContext()
        self.updateChoreRoller()
    }
    
    @IBAction func addPersonTapped(sender: UIButton) {
        let p = self.appDelegate!.createPersonMO()
        p.person_name = self.personFld.text
        self.appDelegate?.saveContext()
        self.updatePersonRoller()
    }
    
    @IBAction func addChoreLogTapped(sender: UIButton) {
        
        let choreRow = self.chorePckr.selectedRowInComponent(0)
        let personRow = self.personPckr.selectedRowInComponent(0)
        
        let chore = self.choreRollerHelper.getItemFromArray(choreRow) as! ChoreMO
        let person = self.personRollerHelper.getItemFromArray(personRow) as! PersonMO
        
        let choreLog = self.appDelegate?.createChoreLogMO()
        choreLog?.person_who_did_it = person
        choreLog?.chore_done = chore
        choreLog?.when = self.datePckr.date
        
        self.appDelegate?.saveContext()
        self.updateLogList()
        
    }
    
    @IBAction func deleteTapped(sender: UIButton) {
        
        let moc = self.appDelegate?.managedObjectContext
        let fetchReqChore = NSFetchRequest(entityName: "Chore")
        
        do {
            let results = try moc!.executeFetchRequest(fetchReqChore)
            
            // Deletes every ChoreMO inside results
            _ = results.map { moc?.deleteObject($0 as! ChoreMO)}

        }catch {
            print("Error fetching Chore")
            abort()
        }
        
        let fetchReqPerson = NSFetchRequest(entityName: "Person")
        
        do {
            let results = try moc!.executeFetchRequest(fetchReqPerson)
            
            // Deletes every PersonMO inside results
            _ = results.map { moc?.deleteObject($0 as! PersonMO)}
            
        }catch {
            print("Error fetching Persons")
            abort()
        }
        
        let fetchReqChoreLog = NSFetchRequest(entityName: "ChoreLog")
        
        do {
            let results = try moc!.executeFetchRequest(fetchReqChoreLog)
            
            // Deletes every ChoreLogMO inside results
            _ = results.map { moc?.deleteObject($0 as! ChoreLogMO)}
            
            
        }catch {
            print("Error fetching ChoreLogs")
            abort()
        }
        self.appDelegate?.saveContext()
        self.updateLogList()
        self.updatePersonRoller()
        self.updateChoreRoller()
    }
    
 
    // MARK: - Helper Functions
    
    // Updates chores list (UI)
    func updateLogList(){
    
        let moc = self.appDelegate?.managedObjectContext
        let fetchReq = NSFetchRequest(entityName: "ChoreLog")
        var choresString = ""
        
        do {
            let results = try moc!.executeFetchRequest(fetchReq)
            
            // Join all ChoreLogs with \n to make them in differents lines
            choresString = results.map{ ($0 as! ChoreLogMO).description}.joinWithSeparator("\n")
            
        } catch {
            print("Error fetching Chore")
            abort()
        }
        
        self.persistedDataLbl.text = choresString
        
        
    }
    
    func updateChoreRoller(){
        let moc = self.appDelegate?.managedObjectContext
        let fetchReq = NSFetchRequest(entityName: "Chore")
        do {
            let results = try moc!.executeFetchRequest(fetchReq)
            self.choreRollerHelper.setArray(results)
            self.chorePckr.reloadAllComponents()
            
        } catch {
            print("Error fetching Chore")
            abort()
        }
        
    }
    
    func updatePersonRoller(){
        let moc = self.appDelegate?.managedObjectContext
        let fetchReq = NSFetchRequest(entityName: "Person")
        do {
            let results = try moc!.executeFetchRequest(fetchReq)
            self.personRollerHelper.setArray(results)
            self.personPckr.reloadAllComponents()
            
        } catch {
            print("Error fetching Person")
            abort()
        }
        
    }
}

