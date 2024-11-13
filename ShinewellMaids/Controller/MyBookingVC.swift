//
//  MyBookingVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class MyBookingVC: UIViewController {

    @IBOutlet weak var bookingTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "BookingCell"
    var arrBooking: [ResBookingList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookingTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "My Booking", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.bookingList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    func bookingList()
    {
        Api.shared.getBookingList(self) { responseData in
            if responseData.count > 0
            {
                self.arrBooking = responseData
                self.lblHidden.isHidden = true
            }else
            {
                self.arrBooking = []
                self.lblHidden.isHidden = false
            }
            self.bookingTableView.reloadData()
        }
    }
    
}

extension MyBookingVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrBooking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath) as! BookingCell
        
        let obj = arrBooking[indexPath.row]
        
        cell.lblHour_Amount.text! = "\(obj.how_many_hours ?? "") Hours @AED \(obj.total_amount ?? "")"
        cell.lblDay_Date.text! = obj.format_date ?? ""
        cell.lblTime.text! = obj.time ?? ""
        cell.lblNumberOfService.text! = obj.how_offen_want_service ?? ""
        cell.lblHour.text! = "No. of Hours : \(obj.how_many_hours ?? "") Hours"
        cell.lblMaid.text! = "No. of Maids : \(obj.how_many_cleaners ?? "")"
        cell.lblCLeaning.text! = "Cleaning Material : \(obj.need_any_cleaning_material ?? "")"
        cell.lblAmount.text! = "\(obj.total_amount ?? "") AED"
        
        if obj.payment_status == "Pending"{
            cell.lblPaymentStatus.text = "Not Paid"
            cell.lblPaymentStatus.textColor = UIColor.systemRed
        }else{
            cell.lblPaymentStatus.text = "Paid"
            cell.lblPaymentStatus.textColor = UIColor.systemGreen
        }
        
        if obj.how_offen_want_service ?? "" == "Weekly"{
            cell.lblPaymentStatus.isHidden = true
        }else{
            cell.lblPaymentStatus.isHidden = false
        }
        
        cell.cloDetails = {
            if obj.how_offen_want_service ?? "" == "Weekly"{
                let vc = Kstoryboard.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
                vc.requestId = obj.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }else if obj.payment_status ?? "" == "Complete" && obj.how_offen_want_service == "Once" {
                let vc = Kstoryboard.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
                vc.requestId = obj.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = Kstoryboard.instantiateViewController(withIdentifier: "BookingRequestVC") as! BookingRequestVC
                vc.requestId = obj.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return cell
    }
}
