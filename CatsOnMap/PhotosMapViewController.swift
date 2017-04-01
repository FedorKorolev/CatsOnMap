//
//  PhotosMapViewController.swift
//  CatsOnMap
//
//  Created by Nikolay Shubenkov on 01/04/2017.
//  Copyright © 2017 Nikolay Shubenkov. All rights reserved.
//

import UIKit
import MapKit

class PhotosMapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    private var apiService = FlickrAPIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.search(tag: "киса",
                          success: { cats in
                            
        }) { error in
            print("\(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
