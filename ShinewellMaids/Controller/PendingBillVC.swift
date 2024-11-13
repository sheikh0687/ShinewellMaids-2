//
//  PendingBillVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit

class PendingBillVC: UIViewController {

    @IBOutlet weak var pendingTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "PendingCell"
    var arrPending: [ResPendingBill] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pendingTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Pending Bill", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.pendingBill()
    }
    
    override func leftClick() {
        toggleLeft()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func pendingBill()
    {
        Api.shared.getPendingBill(self) { responseData in
            if responseData.count > 0
            {
                self.arrPending = responseData
                self.lblHidden.isHidden = true
            }else
            {
                self.arrPending = []
                self.lblHidden.isHidden = false
            }
            self.pendingTableView.reloadData()
        }
    }
}

extension PendingBillVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPending.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingCell", for: indexPath) as! PendingCell
        let obj = arrPending[indexPath.row]
        
        cell.lblBName.text! = obj.description ?? ""
        cell.lblAmount.text! = "AED \(obj.total_amount ?? "")"
        cell.lblPaymentStatus.text! = obj.status ?? ""
        
        cell.cloPay = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "BillPaymentVC") as! BillPaymentVC
            vc.bill_id = obj.id ?? ""
            vc.amount = Double(obj.total_amount ?? "") ?? 0.0
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}
