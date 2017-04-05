//
//  ViewController.swift
//  Map2
//
//  Created by Admin on 11/01/1939 Saka.
//  Copyright © 1939 Saka Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var eventArray=Array<PlacePojo>();

    override func viewDidLoad() {
        super.viewDidLoad()

        let e1=PlacePojo(locName: "IndividalEvent")
        let e2=PlacePojo( locName: "NormalEvent");
        let e3=PlacePojo(locName: "ExclusiveEvent");
        let e4=PlacePojo(locName: "all");
        eventArray.append(e1)
        eventArray.append(e2)
        eventArray.append(e3)
        eventArray.append(e4)
        tableView.delegate=self
        tableView.dataSource=self;
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        cell.textLabel?.text=eventArray[indexPath.row].locName

        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        var selectedData=eventArray[indexPath.row].locName
        
       
        var secondcon=self.storyboard?.instantiateViewControllerWithIdentifier("firstcon") as! MapViewController
       secondcon.selecteddata=selectedData
          var thirdcon=self.storyboard?.instantiateViewControllerWithIdentifier("secondcon") as! GoogleMapViewController
       
        self.navigationController?.pushViewController(secondcon, animated: true)
        
    }
    }

  
    




