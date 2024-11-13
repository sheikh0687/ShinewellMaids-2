//
//  BookingHistoryVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class BookingHistoryVC: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "HistoryCell"
    var arrHistory: [ResBookingHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "History", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.history()
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    func history()
    {
        Api.shared.getBookingHistory(self) { responseData in
            if responseData.count > 0
            {
                self.arrHistory = responseData
                self.lblHidden.isHidden = true
            }else
            {
                self.arrHistory = []
                self.lblHidden.isHidden = false
            }
            self.historyTableView.reloadData()
        }
    }
}

extension BookingHistoryVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        let obj = arrHistory[indexPath.row]
        
        cell.lblHour_Amount.text! = "\(obj.how_many_hours ?? "") Hours @AED \(obj.total_amount ?? "")"
        cell.lblDay_Date.text! = obj.format_date ?? ""
        cell.lblTime.text! = obj.time ?? ""
        cell.lblNumberOfService.text! = obj.how_offen_want_service ?? ""
        cell.lblHour.text! = "No. of Hours : \(obj.how_many_hours ?? "") Hours"
        cell.lblMaid.text! = "No. of Maids : \(obj.how_many_cleaners ?? "")"
        cell.lblCLeaning.text! = "Cleaning Material : \(obj.need_any_cleaning_material ?? "")"
        cell.lblAmount.text! = "\(obj.total_amount ?? "") AED"
//        cell.lblPaymentStatus.text! =
        cell.viewToHide.isHidden = true
        return cell
    }
}
