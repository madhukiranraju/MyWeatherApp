//
//  MapViewController.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var refreshData:((_ place : Place?)->())?//call back
    var selectedPlace = Place()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Type place name here"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        self.mapView.delegate = self
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTap))
        mapView.addGestureRecognizer(longTapGesture)
        
    }
    
    @objc func handleTap(sender: UIGestureRecognizer){
        print("long tap")
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            print(locationOnMap.latitude,locationOnMap.longitude)
            //self.mapView.addAnnotation(locationOnMap as! MKAnnotation)

            let coordinate: CLLocation = CLLocation(latitude:locationOnMap.latitude, longitude: locationOnMap.longitude)

            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(coordinate) { (placemarks, error) in
                if let locality = placemarks {
                    //Create annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = locality[0].locality!
                    annotation.subtitle = locality[0].locality!
                    annotation.coordinate = CLLocationCoordinate2DMake(locationOnMap.latitude, locationOnMap.longitude)
                    self.mapView.addAnnotation(annotation)
                    self.selectedPlace = Place(placeName: locality[0].locality ?? "", latitude: String(describing: locationOnMap.latitude ) , longitude: String(describing: locationOnMap.longitude ) , uuid: UUID().uuidString)
                    //Zooming in on annotation
                    let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(locationOnMap.latitude, locationOnMap.longitude)
                    let span = MKCoordinateSpan.init(latitudeDelta: 0.1, longitudeDelta: 0.1)//MKCoordinateSpanMake(0.1, 0.1)
                    let region = MKCoordinateRegion.init(center: coordinate, span: span)//coordinate, span
                    self.mapView.setRegion(region, animated: true)
                }
            }

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    func showAnnotationLocation(_ place : String){

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = place
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = response?.mapItems[0].name
                annotation.subtitle = response?.mapItems[0].name
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                self.selectedPlace = Place(placeName: response?.mapItems[0].name ?? "", latitude: String(describing: latitude ?? 0.0), longitude: String(describing: longitude ?? 0.0), uuid: UUID().uuidString)
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan.init(latitudeDelta: 0.1, longitudeDelta: 0.1)//MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegion.init(center: coordinate, span: span)//coordinate, span
                self.mapView.setRegion(region, animated: true)
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController :UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text!.isEmpty {
            return
        }
        self.showAnnotationLocation(searchController.searchBar.text!)
    }
}

//Extension for MapViewController

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }
        
        let customAnnotationView = self.customAnnotationView(in: mapView, for: annotation)
        return customAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(#function)
        if control == view.rightCalloutAccessoryView {
            
            //storing the place in CoreData
            MapViewModel.sharedInstance.insertPlaceIntoDB(place: self.selectedPlace) {[weak self] (status) -> (Void) in
                DispatchQueue.main.async {
                    if status{
                        self?.navigationController?.popViewController(animated: true)
                        //call back
                        self!.refreshData?(self?.selectedPlace)
                    }else{
                        //stay in the same View
                        print("Failed")
                    }
                }//end of dispatch main
            }
        }
    }
    

    private func customAnnotationView(in mapView: MKMapView, for annotation: MKAnnotation) -> CustomSPAnnotationView {
        let identifier = "CustomAnnotationViewID"
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomSPAnnotationView {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let customAnnotationView = CustomSPAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            customAnnotationView.canShowCallout = true
            return customAnnotationView
        }
    }
}


class CustomSPAnnotationView: MKAnnotationView {
    private let annotationFrame = CGRect(x: 0, y: 0, width: 40, height: 40)

    private let imgView: UIImageView

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.imgView = UIImageView(frame: annotationFrame.offsetBy(dx: 0, dy: -6))
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = annotationFrame
        self.imgView.image = UIImage(named: "location1")!
        let rightButton = UIButton(type: .contactAdd)
        self.rightCalloutAccessoryView = rightButton
        self.addSubview(self.imgView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }

}
