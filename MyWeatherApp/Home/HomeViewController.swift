//
//  HomeViewController.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import UIKit

class HomeViewController: UIViewController  {

    @IBOutlet weak var tableView: UITableView!
  
    
    @IBAction func showMapView(_ sender: Any) {
        performSegue(withIdentifier: "HOMETOMAPVIEW", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
