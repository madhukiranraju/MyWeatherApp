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
    @IBOutlet weak var windspeedlbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = place?.placeName ?? ""
        self.imgView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        guard let place = place else {
            return
        }
        LocationTempViewModel.sharedInstance.getLocationTempFromAPI(latitude: (place.latitude)!, longitude: place.longitude!) {[weak self] (weather) in
           // print(weather)
            guard let weather = weather else {return}
            DispatchQueue.main.async {
                self!.placelbl.text = "\(place.placeName ?? "") (\(weather.name))"

                self!.forecastlbl.text = weather.weather[0].description.capitalized 
                self!.imgView.isHidden = false
                self!.imgView.image = UIImage(named: (weather.weather[0].icon))
                if !UserDefaults.standard.bool(forKey: Constant.kMetricConstant){
                    let temp = weather.main.temp.toCelsius() 
                    self!.templbl.text = "\(temp)°C"
//                    self?.windspeedlbl.text = "Wind speed : \(weather.wind.deg)°, \(weather?.wind.speed)Kmph"
                }else{
                    let temp = weather.main.temp.toFahrenheit() 
                    self!.templbl.text = "\(temp)°F"
//                    self?.windspeedlbl.text = "Wind speed : \(weather.wind.deg)°, \(weather?.wind.speed)Mph"
                }
                let humidity = Double(String(format:"%.1f",weather.main.humidity ))
                self!.humiditylbl.text = "\(humidity!)%"
                self?.windspeedlbl.text = "Wind speed : \(weather.wind.deg)°, \(weather.wind.speed)Kmph"
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
        if !UserDefaults.standard.bool(forKey: Constant.kMetricConstant){
            let temp = dict.main.temp.toCelsius()
            cell?.templbl.text = "\(temp)°C"
        }else{
            let temp = dict.main.temp.toFahrenheit()
            cell?.templbl.text = "\(temp)°F"
        }
        cell?.forecastlbl.text = dict.weather[0].description.capitalized
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: 200, height: 150)
        return size
    }
    
}
