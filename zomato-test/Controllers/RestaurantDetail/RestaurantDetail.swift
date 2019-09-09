//
//  RestaurantDetail.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/9/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MapKit

class RestaurantDetail:UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var establishment: UILabel!
    @IBOutlet weak var cityStateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cuisine: UILabel!
    @IBOutlet weak var avgCost: UILabel!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateCount: UILabel!
    @IBOutlet weak var rateContainer: UIView!
    @IBOutlet weak var addressContainer: UIView!
    
    var restaurant:Restaurant!
    var highlights:[String] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (restaurant != nil){
            self.navigationItem.title = restaurant.name
            let url = URL(string: restaurant.featuredImage)
            if (url != nil){
                Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseImage{ response in
                    if (response.result.value != nil){
                        self.featuredImage.image = response.result.value
                        self.featuredImage.contentMode = .scaleToFill
                    }
                }
            }
            rateLabel.text = restaurant.userRating.aggregateRating
            rateLabel.backgroundColor = UIColor(hex: restaurant.userRating.ratingColor)
            rateContainer.layer.cornerRadius = 5
            rateContainer.clipsToBounds = true
            rateContainer.layer.borderColor = UIColor.lightGray.cgColor
            rateContainer.layer.borderWidth = 0.5
            addressContainer.layer.cornerRadius = 5
            addressContainer.clipsToBounds = true
            nameLabel.text = restaurant.name
            establishment.text = restaurant.establishment + " - " + restaurant.cuisines
            cityStateLabel.text = restaurant.location.city
            addressLabel.text = restaurant.location.address
            cuisine.text = restaurant.cuisines
            avgCost.text = "$\(restaurant.averageCostForTwo) for two people (approx.)"
            highlights = restaurant.highlights
            rateCount.text = "\(restaurant.reviewCount)"
            infoCollectionView.reloadData()
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.location.latitude, longitude: restaurant.location.longitude)
            mapView.addAnnotation(annotation)
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: CLLocationDistance(exactly: 100)!, longitudinalMeters: CLLocationDistance(exactly: 100)!)
            mapView.setRegion(mapView.regionThatFits(region), animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let contentSize = CGSize(width: self.view.frame.width, height: 1100)
        scrollView.contentSize = contentSize
    }
}

extension RestaurantDetail:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return highlights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "highlight", for: indexPath) as! HighlightsCell
        cell.highlightLabel.text = highlights[indexPath.row]
        return cell
    }
    
    
}
