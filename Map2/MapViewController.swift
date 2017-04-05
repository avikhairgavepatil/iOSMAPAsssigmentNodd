//
//  MapViewController.swift
//  Map2
//
//  Created by Admin on 11/01/1939 Saka.
//  Copyright © 1939 Saka Admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{
    var selecteddata:String?
    
    @IBAction func goToHoogleMap(sender: AnyObject) {
        var thirdcon=self.storyboard?.instantiateViewControllerWithIdentifier("secondcon") as! GoogleMapViewController
      
                thirdcon.selectedData=selecteddata
        self.navigationController?.pushViewController(thirdcon, animated: true)
        print(thirdcon.selectedData!)
        
        
     }
  @IBOutlet weak var mapView: MKMapView!
    var dict:Dictionary<String,AnyObject>?
    var mylocation:CLLocation?
    
    
    var locManager=CLLocationManager();
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       
        mapView.showsUserLocation=true;
        
        //activate location permission
        locManager.delegate=self;
        locManager.requestWhenInUseAuthorization();
        locManager.distanceFilter=kCLDistanceFilterNone
        locManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation
        locManager.startUpdatingLocation()
        
        //set map delegate
        mapView.delegate=self;
        
        //create region on map around mumbai
        let centerCordinate=CLLocationCoordinate2DMake(19.129216, 72.837464)
        
        let region = MKCoordinateRegionMakeWithDistance(centerCordinate, 20000, 20000)
        
        mapView.region=region;
        
        readJson();
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
            mylocation=locations.last;
            
            //create region on map around mumbai
            let centerCordinate=CLLocationCoordinate2DMake(
                (mylocation?.coordinate.latitude)!,
                (mylocation?.coordinate.longitude)! )
            
            let region = MKCoordinateRegionMakeWithDistance(centerCordinate, 200000, 200000)
        
            
            mapView.region=region;
        
    }
    
    
    func readJson()
    {
        var url=NSURL(string: "https://api.myjson.com/bins/d1g3n")
        
        
        //prepare request
        let request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "GET"
        
        //send request to url
        let urlSession = NSURLSession.sharedSession();
        
        /* let task:NSURLSessionDataTask = urlSession.dataTaskWithRequest(<#T##request: NSURLRequest##NSURLRequest#>, completionHandler: <#T##(NSData?, NSURLResponse?, NSError?) -> Void#>)
         */
        
        let task:NSURLSessionDataTask = urlSession.dataTaskWithRequest(request, completionHandler:
            {
                (data:NSData?, response:NSURLResponse?,
                error:NSError?)->Void
                in
                //process recieved data
                //display data as string
                // let str=String(data: data!, encoding: NSUTF8StringEncoding)
                //print("json: \(str)")
                
                //json parsing
                do{
                    //print("==================")
                    try self.dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)
                        as! Dictionary<String,AnyObject>
                    
                    var d=self.dict!["data"] as! Array<AnyObject>
                    // print("============\(d)")
                    
                    
                    
                    for i in 0...d.count-1
                    {
                        var dobject1 = d[i] as! AnyObject
                        var title1 = dobject1["title"] as! String
                        //print(title1);
                        //coordinate
                        var coordinate1 = dobject1["coordinate"] as! String
                        //print(coordinate1)
                        
                        var myStringArr = coordinate1.componentsSeparatedByString(",")
                        var co1 = Double(myStringArr [0])
                        var co2 = Double(myStringArr [1])
                        
                        var co1CL = CLLocationDegrees(co1!)
                        var co2CL = CLLocationDegrees(co2!)
                        
                        //  print("\(co1)  ---- \(co2)")
                        var type1 = dobject1["type"] as! String
                        //print(type1)
                        
                        
                        if(self.selecteddata == "IndividalEvent" && type1 == "ev"){
                            
                            let mapAnnotation1=PlaceAnnotation(pinColor: UIColor.darkGrayColor())
                            mapAnnotation1.title=type1;
                            mapAnnotation1.coordinate=CLLocationCoordinate2DMake(co1CL, co2CL)
                            mapAnnotation1.type=title1;
                           // mapAnnotation1.subtitle=type1;
                            
                            
                            // creating coordinate from data
                            
                            let centerCoordinate1=CLLocationCoordinate2DMake(co1CL as! CLLocationDegrees,co2CL as! CLLocationDegrees);
                            let cor1=CLLocation(latitude: self.mylocation!.coordinate.latitude, longitude: self.mylocation!.coordinate.longitude)
                            let cor2=CLLocation(latitude: co1CL as! CLLocationDegrees, longitude: co2CL as! CLLocationDegrees)
                            //geting distance from current location
                            
                            let distance=Float(cor1.distanceFromLocation(cor2))
                            mapAnnotation1.distance=distance
                            self.mapView.addAnnotation(mapAnnotation1)
                          }
                        else if(self.selecteddata == "NormalEvent" && type1 == "pe")
                        {
                            let mapAnnotation1=PlaceAnnotation(pinColor: UIColor.cyanColor())
                            mapAnnotation1.title=type1;
                            mapAnnotation1.coordinate=CLLocationCoordinate2DMake(co1CL, co2CL)
                            mapAnnotation1.type=title1;
                            
                            
                            
                            // creating coordinate from data
                            
                            let centerCoordinate1=CLLocationCoordinate2DMake(co1CL as! CLLocationDegrees,co2CL as! CLLocationDegrees);
                            let cor1=CLLocation(latitude: self.mylocation!.coordinate.latitude, longitude: self.mylocation!.coordinate.longitude)
                            let cor2=CLLocation(latitude: co1CL as! CLLocationDegrees, longitude: co2CL as! CLLocationDegrees)
                            //geting distance from current location
                            
                            let distance=Float(cor1.distanceFromLocation(cor2))
                            mapAnnotation1.distance=distance
                            self.mapView.addAnnotation(mapAnnotation1)

                        }
                        else if(self.selecteddata == "ExclusiveEvent" && type1 == "ex")
                        {
                            let mapAnnotation1=PlaceAnnotation(pinColor: UIColor.blueColor())
                            mapAnnotation1.title=type1;
                            mapAnnotation1.coordinate=CLLocationCoordinate2DMake(co1CL, co2CL)
                            mapAnnotation1.type=title1;
                            mapAnnotation1.color=UIColor.blackColor()
                            
                            
                            
                            // creating coordinate from data
                            
                            let centerCoordinate1=CLLocationCoordinate2DMake(co1CL as! CLLocationDegrees,co2CL as! CLLocationDegrees);
                            let cor1=CLLocation(latitude: self.mylocation!.coordinate.latitude, longitude: self.mylocation!.coordinate.longitude)
                            let cor2=CLLocation(latitude: co1CL as! CLLocationDegrees, longitude: co2CL as! CLLocationDegrees)
                            //geting distance from current location
                            
                            let distance=Float(cor1.distanceFromLocation(cor2))
                            mapAnnotation1.distance=distance
                            print("distance\(distance)")
                            self.mapView.addAnnotation(mapAnnotation1)
                            
                        }
                        else if(self.selecteddata == "all"){
                            let mapAnnotation1=PlaceAnnotation(pinColor: UIColor.blackColor())
                            mapAnnotation1.title=type1;
                            mapAnnotation1.coordinate=CLLocationCoordinate2DMake(co1CL, co2CL)
                            mapAnnotation1.type=title1;
                            //mapAnnotation1.subtitle
                            
                            
                            // creating coordinate from data
                            
                            let centerCoordinate1=CLLocationCoordinate2DMake(co1CL as! CLLocationDegrees,co2CL as! CLLocationDegrees);
                            let cor1=CLLocation(latitude: self.mylocation!.coordinate.latitude, longitude: self.mylocation!.coordinate.longitude)
                            let cor2=CLLocation(latitude: co1CL as! CLLocationDegrees, longitude: co2CL as! CLLocationDegrees)
                            //geting distance from current location
                            
                            let distance=Float(cor1.distanceFromLocation(cor2))
                            mapAnnotation1.distance=distance
                        
                        self.mapView.addAnnotation(mapAnnotation1)
                        }
                    }
                    
                }
                catch
                {
                    print(error)
                }
                
        } );
        //------------------------
        task.resume()
        
        
    }
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        ///handle marker pin click/selection
        
        let annotation = view.annotation as! PlaceAnnotation
        //detailsLabel.text = annotation.title
        
        
        var alert = UIAlertController(title: "title:"+annotation.title!, message:"type:"+"\(annotation.type)"+"    "+"Distanse="+"\(annotation.distance)"+"meter", preferredStyle: UIAlertControllerStyle.Alert);
        var action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        alert.addAction(action);
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
  
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
       var tt = String(annotation.title)
       var title   = "ex"
       //print("tt="+tt)
         print("title="+title)
          let annotationView = MKPinAnnotationView()
        if( tt  == "ex"){
      
        annotationView.pinTintColor = UIColor.orangeColor()
             return annotationView
        }
        else if(tt  == String("pe"))
        {
           
            annotationView.pinTintColor = UIColor.blueColor()
            return annotationView
        }
        else if(tt  == "ev")
        {
  
              annotationView.pinTintColor = UIColor.purpleColor()
            return annotationView
        }
        else
        {
            annotationView.pinTintColor = UIColor.blackColor()
          return annotationView
        
        }
       
         //return annotationView
        
    }
    
  

 

}
