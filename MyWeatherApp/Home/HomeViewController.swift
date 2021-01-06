//
//  HomeViewController.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import UIKit

class HomeViewController: UIViewController  {

    var places = [Place]()
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func showMapView(_ sender: Any) {
        performSegue(withIdentifier: "HOMETOMAPVIEW", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.tableFooterView = UIView()
        HomeViewModel.sharedInstance.fetchPlaces {[weak self] (places) in
            guard let places = places else{return}
            DispatchQueue.main.async {
                self?.places = places
                self?.tableView.reloadData()
            }
        }
        
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "HOMETOMAPVIEW"{
            let vc = segue.destination as! MapViewController
            vc.refreshData = {(place ) in
                guard let place = place else{return}
                print(place.placeName!, place.latitude!, place.longitude!)
                
            }
        }
    }
    

}


extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LocationTableViewCell
        let dict = self.places[indexPath.row]
        cell.namelbl.text = dict.placeName ?? ""
        cell.desclbl.text = dict.placeName ?? ""
        cell.latitudelbl.text = dict.latitude ?? ""
        cell.longitudelbl.text = dict.longitude ?? ""
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
}
