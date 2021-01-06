//
//  LocationTempViewController.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import UIKit

class LocationTempViewController: UIViewController {

    var place : Place?

    var tempArr : [WeatherDaily]?
    
    
    @IBOutlet weak var placelbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var forecastlbl: UILabel!
    @IBOutlet weak var templbl: UILabel!
    @IBOutlet weak var humiditylbl: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = place?.placeName ?? ""
        self.placelbl.text = place?.placeName ?? ""
        
        guard let place = place else {
            return
        }
        LocationTempViewModel.sharedInstance.getLocationTempFromAPI(latitude: (place.latitude)!, longitude: place.longitude!) {[weak self] (weather) in
            //print(weather)
            DispatchQueue.main.async {
                self!.forecastlbl.text = weather?.weather[0].description.capitalized ?? "Unknown"
                self!.imgView.isHidden = false
                self!.imgView.image = UIImage(named: (weather?.weather[0].icon)!)
                let temp = weather?.main.temp.toCelsius() ?? -999.00
                self!.templbl.text = "\(temp)°C"
                let humidity = Double(String(format:"%.1f",weather?.main.humidity ?? -999.00))
                self!.humiditylbl.text = "\(humidity!)"
            }
        }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        LocationTempViewModel.sharedInstance.getLocationDailyTemp(latitude: place.latitude!, longitude: place.longitude!) {[weak self] (weatherArr) in
            //print(weatherArr?.list)
            guard let list = weatherArr?.list else{return}
            
            DispatchQueue.main.async {
                self?.tempArr = list
                self!.collectionView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LocationTempViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        return self.tempArr?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DAILYTEMPCELL", for: indexPath) as? TempCollectionViewCell
       
        let dict = tempArr![indexPath.row]
        cell?.dateslbl.text = dict.dt_txt ?? ""
        cell?.imgView.image = UIImage(named: (dict.weather[0].icon ))
        let temp = dict.main.temp.toCelsius()
        cell?.templbl.text = "\(temp)°C"
        cell?.forecastlbl.text = dict.weather[0].description.capitalized
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: 200, height: 150)
        return size
    }
    
}
