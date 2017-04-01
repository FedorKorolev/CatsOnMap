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

    var searchBar: UISearchBar!
    @IBOutlet var mapView: MKMapView!
    
    private var apiService = FlickrAPIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearch()
        
        mapView.delegate = self
//        showGrandCentralDispatchInAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //каждый раз, когда наш контроллер ьудет появляться на экране
        //мы позволим скрывать шапку при касании карты
        navigationController!.hidesBarsOnSwipe = true
        navigationController?.hidesBarsOnTap = true
    }
    
    func setupSearch(){
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            //заставим обновить свой размер
        searchBar.sizeToFit()
        
        //вставим строку поиска в шапку
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PhotoDetailedViewController,
            let photo = sender as? PhotoInfo {
            vc.photo = photo
        }
    }
    
    func searchFor(text:String){
        
        apiService.search(tag: text,
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


extension PhotosMapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //если это не метка, созданная нами
        //вернем nil, пусть mapView сам разбирается с тем,
        //как эту метку показать
        guard let photo = annotation as? PhotoInfo else {
            return nil
        }
        
        //это идентификатор для всех вью, которые будут показывать метку
        let viewId = "photoPin"
        
        //запросим свободный вью для отобржаения метки с таким-то идентификатором
        var photoView = mapView.dequeueReusableAnnotationView(withIdentifier: viewId)
        
        //если нет свободных меток 
        //то создадим его сами
        if photoView == nil {
            photoView = MKPinAnnotationView(annotation: photo,
                                            reuseIdentifier: viewId)
            photoView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        photoView?.annotation = photo
        
        //тут мы будем хранить картинку
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 50,
                                                  height: 50))
        
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.loadImage(link: photo.iconLink)
        
        
        photoView?.leftCalloutAccessoryView = imageView
        photoView?.canShowCallout = true
        
        return photoView
    }
    
    //когда пользователь нажал на любой элемент типа
    //UIButton, UISwitch все, что является наследником от UIControl
    //сработает этот метод
    //т.к. у нас на метке только один объект такого типа
    //мы знаем, что можем выполнить лишь одно действие
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let photo = view.annotation as? PhotoInfo else {
            return
        }
        
        performSegue(withIdentifier: "Show Photo Detailes",
                     sender: photo)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let imageView = (view as? MKPinAnnotationView)?.leftCalloutAccessoryView as? UIImageView,
            let photo = view.annotation as? PhotoInfo{
            imageView.loadImage(link: photo.iconLink,
                                highPriority:true)
        }
    }
}


