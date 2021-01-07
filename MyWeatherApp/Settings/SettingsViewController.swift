//
//  SettingsViewController.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
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
extension SettingsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SETTINGSCELL")!
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Help"
            cell.accessoryType = .detailButton
          
        case 1 :
            cell.textLabel?.text = "Change metrics"
            cell.accessoryType = .disclosureIndicator
            
        case 2 :
            cell.textLabel?.text = "Reset all Bookmarked locations"
            cell.accessoryType = .disclosureIndicator
        default:
            print("")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row{
        case 0 :
            performSegue(withIdentifier: "SETTINGSTOHELP", sender: nil)
        case 1 :
            print("toggle metrics")
            let alert = UIAlertController(title: "Change the Units", message: "",         preferredStyle: UIAlertController.Style.actionSheet)
           
            alert.addAction(UIAlertAction(title: "Metric (°C)",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
                                           
                                            UserDefaults.standard.set(false, forKey: Constant.kMetricConstant)
                                            UserDefaults.standard.synchronize()

                                          }))
            alert.addAction(UIAlertAction(title: "Imperial (°F)",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
                                            UserDefaults.standard.set(true, forKey: Constant.kMetricConstant)
                                            UserDefaults.standard.synchronize()
                                          }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
                //Cancel Action
            }))
            self.present(alert, animated: true, completion: nil)
        case 2 :
            print("Reset all bookmarked")
            let alert = UIAlertController(title: "Reset all Bookmarked Locations?", message: "Cannot be restored again.",         preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                //Cancel Action
            }))
            alert.addAction(UIAlertAction(title: "Reset",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
                                            DataManager.sharedInstance.removeAllFavorites()
                                          }))
            self.present(alert, animated: true, completion: nil)
        default:
            print("default")
        }
    }
}
