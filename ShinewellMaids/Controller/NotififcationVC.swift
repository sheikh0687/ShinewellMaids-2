//
//  NotififcationVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 14/06/23.
//

import UIKit

class NotififcationVC: UIViewController {

    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var lblHIdden: UILabel!
    
    let identifier = "NotificationCell"
    var arrNotify: [ResNotify] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Notification", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.notification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func notification()
    {
        Api.shared.getNotification(self) { responseData in
            if responseData.count > 0 {
                self.arrNotify = responseData
                self.lblHIdden.isHidden = true
            }else{
                self.arrNotify = []
                self.lblHIdden.isHidden = false
            }
            self.notificationTableView.reloadData()
        }
    }
}

extension NotififcationVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNotify.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let obj = self.arrNotify[indexPath.row]
        cell.lblName.text = obj.title ?? ""
        cell.lblDescription.text = obj.message ?? ""
        cell.lblTime.text = obj.date_time ?? ""
        return cell
    }
}
