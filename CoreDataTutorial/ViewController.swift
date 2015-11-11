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
    
    // MARK: - Variables
    var appDelegate : AppDelegate?
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Gets Reference to AppDelegate and Updates UI
        self.appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
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
        self.updateLogList()
    }
    
    @IBAction func deleteTapped(sender: UIButton) {
        
        let moc = self.appDelegate?.managedObjectContext
        let fetchReq = NSFetchRequest(entityName: "Chore")
        
        do {
            let results = try moc!.executeFetchRequest(fetchReq)
            
            // Deletes every ChoreMO inside results
            _ = results.map { moc?.deleteObject($0 as! ChoreMO)}
            self.appDelegate?.saveContext()

        }catch {
            print("Error fetching Chore")
            abort()
        }
        
        self.updateLogList()
    }
    
    // MARK: - Helper Functions
    
    // Updates chores list (UI)
    func updateLogList(){
    
        let moc = self.appDelegate?.managedObjectContext
        let fetchReq = NSFetchRequest(entityName: "Chore")
        var choresString = ""
        
        do {
            let results = try moc!.executeFetchRequest(fetchReq)
            
            // Join all chore_name with \n to make them in differents lines
            choresString = results.map{ ($0 as! ChoreMO).chore_name!}.joinWithSeparator("\n")
            
        } catch {
            print("Error fetching Chore")
            abort()
        }
        
        self.persistedDataLbl.text = choresString
        
        
    }
}

