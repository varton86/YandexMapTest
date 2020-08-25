//
//  ViewController.swift
//  TestTaskCrassula
//
//  Created by Oleg Soloviev on 05.03.2019.
//  Copyright © 2019 varton. All rights reserved.
//

import UIKit
import YandexMapKit
import CoreLocation

class UserLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: YMKMapView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchText: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var loadPhoto: UIView!
    @IBOutlet weak var loadPhotoText: UILabel!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionConstraint: NSLayoutConstraint!
    
    private var userLocationLayer: YMKUserLocationLayer!
    private let TARGET_LOCATION = YMKPoint(latitude: 55.755785999230845, longitude: 37.61763300000001)
    private let geocoder = CLGeocoder()
    private let scale = UIScreen.main.scale

    let adapter = Adapter<UIImage, ImageCell>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
        setupLocation()
        setupLabel()
        prepareGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        userLocationLayer.setAnchorWithAnchorNormal(
            CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
            anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessage" {
            let navController = segue.destination as! UINavigationController
            let controller = navController.viewControllers.first as! MessageViewController
            controller.delegate = self
        }
    }
    
}

private extension UserLocationViewController {
    
    func buildUI() {
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 5.0
        containerView.layer.shadowRadius = 1.0
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        containerView.layer.shadowOpacity = 0.5
        
        mapView.layer.cornerRadius = 5.0
        mapView.clipsToBounds = true

        searchView.layer.masksToBounds = false
        searchView.layer.cornerRadius = 23.0
        searchView.layer.shadowRadius = 1.0
        searchView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        searchView.layer.shadowOpacity = 0.5
        
        searchText.textColor = Color.text

        messageView.layer.masksToBounds = false
        messageView.layer.cornerRadius = 23.0
        messageView.layer.shadowRadius = 1.0
        messageView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        messageView.layer.shadowOpacity = 0.5
        
        messageText.textColor = Color.text
        loadPhotoText.textColor = Color.main

        sendView.layer.masksToBounds = false
        sendView.layer.cornerRadius = 23.0
        sendView.backgroundColor = Color.main

        collectionView.isHidden = true
        collectionConstraint.constant = 21
        
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        collectionView.register(cellType: ImageCell.self)
        
        adapter.configure = { image, cell in
            cell.imageView.image = image
        }
    }
    
    func setupLocation() {
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        mapView.mapWindow.map.move(with: YMKCameraPosition(target: TARGET_LOCATION, zoom: 14, azimuth: 0, tilt: 0))

        let mapKit = YMKMapKit.sharedInstance()
        userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true

        mapView.mapWindow.map.addCameraListener(with: self)
    }

    func setupLabel() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("*** No access")
                updateLabel(TARGET_LOCATION)
            case .authorizedAlways, .authorizedWhenInUse:
                print("*** Access")
            }
        } else {
            print("*** Location services are not enabled")
        }
    }
    
    func updateLabel(_ target: YMKPoint) {
        searchText.text = "Wait ..."
        let newLocation = CLLocation(latitude: target.latitude, longitude: target.longitude)
        geocoder.reverseGeocodeLocation(newLocation, completionHandler: { [unowned self] (placemarks, error) in
            if error == nil, let p = placemarks, !p.isEmpty {
                if let street = p.first?.thoroughfare {
                    self.searchText.text = street
                    if let house = p.first?.subThoroughfare {
                        self.searchText.text = "\(street) \(house)"
                    }
                }
            } else {
                self.searchText.text = "Error ..."
            }
        })
    }

    func prepareGestureRecognizer() {
        messageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMessage)))
        loadPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPhotoMenu)))
    }
    
    @objc func showMessage() {
        performSegue(withIdentifier: "ShowMessage", sender: nil)
    }
}

extension UserLocationViewController: YMKMapCameraListener {
    func onCameraPositionChanged(with map: YMKMap,
                                 cameraPosition: YMKCameraPosition,
                                 cameraUpdateSource: YMKCameraUpdateSource,
                                 finished: Bool) {
        if finished {
            updateLabel(cameraPosition.target)
        }
    }
}
