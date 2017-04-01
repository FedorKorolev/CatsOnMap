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
                          //этот блок кода будет вызван позже
                          success: { cats in
                            
        print("\nА вот и фотографии:\(cats)")
                            //т.к. этот код вызван не в осной очереди
                            //mainQueue 
                            //а мы сейчас начнем работать с интерфейсом
                            //нам нужно переключиться в очередь для раьоты
                            //с ним. (mainQueue)
                            DispatchQueue.main.async {
                                self.showPinsOnMap(pins: cats)
                            }

        //и этот тоже будет чуть позже вызван
        }) { error in
            
            print("\(error)")
        }
        
//        showGrandCentralDispatchInAction()
    }
    
    func showPinsOnMap(pins:[PhotoInfo])
    {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(pins)
    }
    
    func showGrandCentralDispatchInAction(){
        
        //создадим очередь - это объект,  внутри которого можно 
        //выполнять некоторую задачу
        let queue = DispatchQueue(label: "ru.specialist.swiftapps2")
        
        //можно выполнять код асинхронно
        queue.sync {
            for i in 0..<10 {
                print("🤡_\(i)")
            }
        }
        
        //эта задача выполеяеся асинхронно
//        queue.async {
            for i in 100..<110 {
                print("_👻\(i)")
            }
//        }
        
        
    }
    
    
}
