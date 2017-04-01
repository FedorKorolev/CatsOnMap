//
//  PhotoDetailedViewController.swift
//  CatsOnMap
//
//  Created by Nikolay Shubenkov on 01/04/2017.
//  Copyright © 2017 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class PhotoDetailedViewController: UIViewController {

    var photo:PhotoInfo?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false,
                                                     animated: false)
       
        navigationController?.hidesBarsOnTap = false
        title = photo?.title
        imageView.loadImage(link: photo?.fullPhotoLink ?? "")
        imageView.contentMode = .scaleAspectFit
    }
}
