//
//  PickerViewHelperViewController.swift
//  CoreDataTutorial
//
//  Created by Miguel Fagundez on 11/11/15.
//  Copyright © 2015 Miguel Fagundez. All rights reserved.
//

import UIKit

class PickerViewHelperViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var pickerData :[AnyObject] = []
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    convenience init(){
        self.init(nibName: nil, bundle: nil)
    }

    func setArray(array :[AnyObject]){
        self.pickerData = array
    }
    
    func addItem(item:AnyObject){
        self.pickerData.append(item)
    }
    
    func getItemFromArray(index:Int) -> AnyObject{
        return self.pickerData[index]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getItemFromArray(row).description
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
