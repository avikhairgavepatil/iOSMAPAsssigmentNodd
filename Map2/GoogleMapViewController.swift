//
//  GoogleMapViewController.swift
//  Map2
//
//  Created by Admin on 12/01/1939 Saka.
//  Copyright © 1939 Saka Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class GoogleMapViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var myView: UIView!
    let locationManager=CLLocationManager();
    var mapView=GMSMapView()
     let marker=GMSMarker();
     var dict:Dictionary<String,AnyObject>?
     var mylocation:CLLocation?
     var selectedData:String?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.locationManager.delegate=self;
       self.locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
       self.locationManager.requestWhenInUseAuthorization()
       self.locationManager.stopUpdatingLocation();
        let camera=GMSCameraPosition.cameraWithLatitude((self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: 14)
        
        mapView=GMSMapView.mapWithFrame(CGRectMake(0, 0, self.myView.frame.size.width, self.myView.frame.size.height), camera: camera)
        view = mapView
        
        
        mapView.settings.myLocationButton=true
        mapView.myLocationEnabled=true
        let marker=GMSMarker();
    ///marker.icon = GMSMarker.markerImageWithColor(<#T##UIColor?#>)
        marker.position=camera.target
        marker.snippet="current ocation"
        marker.title="hiiiiii"
        //marker.icon=UIImage(named: "pin1")
    
        marker.map=mapView
        // drow circle
        let circleCenter = CLLocationCoordinate2D(latitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let circ = GMSCircle(position: circleCenter, radius: 10000)
        circ.map = mapView
        //self.view.addSubview(mapView)
        

        

    }

    override func viewDidAppear(animated: Bool) {
      // json parsing from JSONData.json file
        
        let path = NSBundle.mainBundle().pathForResource("JSONData", ofType: "json")
            let data = try! NSData(contentsOfFile: path! as! String, options: NSDataReadingOptions.DataReadingMapped)
                do{
             let responseString = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
             let jsonArray = String(responseString) // hole json data
                    let dataArray=responseString["data"] as! Array<Dictionary<String,String>>
                    //print("data="+String(data))
                    if(dataArray.count != 0)
                    {
        
                        for var i in 0...dataArray.count-1
                        {
                            let type=dataArray[i];
                            let type1=type["type"];
                            let cordinate=type["coordinate"]
                            let separators = NSCharacterSet(charactersInString: " ,")
                            
                            var latLanArr = cordinate!.componentsSeparatedByCharactersInSet(separators)
                            var latString=latLanArr[0];
                            let lngString=latLanArr[1];
                            let lat:Double=Double(latString)!
                            let lng:Double=Double(lngString)!
                            
        
                            let tite=type["title"]
             
                       
                            
                           print("+*******SElectedData"+selectedData!)
                             if(self.selectedData == "IndividalEvent" && type1 == "ev")
                             {
                            let position = CLLocationCoordinate2DMake(lat, lng)
                            let london = GMSMarker(position: position)
                            london.title = "Type::\(type1!)"
                            london.snippet = "Title:\(tite!)"
                        
                            london.map = mapView
                             }
                            else if(self.selectedData == "NormalEvent" && type1 == "pe")
                             {
                                let position = CLLocationCoordinate2DMake(lat, lng)
                                let london = GMSMarker(position: position)
                                london.title = "Type::\(type1!)"
                                london.snippet = "Title:\(tite!)"
                                //london.userData = mCustomData
                                london.map = mapView
                                
                            }
                            else if(self.selectedData == "ExclusiveEvent" && type1 == "ex")
                             {
                                let position = CLLocationCoordinate2DMake(lat, lng)
                                let london = GMSMarker(position: position)
                                london.title = "Type::\(type1!)"
                                london.snippet = "Title:\(tite!)"
                               
                                london.map = mapView
                                
                            }
                            else if(self.selectedData == "all")
                             {
                                let position = CLLocationCoordinate2DMake(lat, lng)
                                let london = GMSMarker(position: position)
                                london.title = "Type::\(type1!)"
                                london.snippet = "Title:\(tite!)"
                                //london.userData = mCustomData
                                london.map = mapView
                                
                            }
       
        
                            
                        }
                        
                        
                    }
               
              print(jsonArray)
                } catch{
                    
                }
                


        
    }

}
