//
//  CouponContainerVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 12/06/23.
//

import UIKit

class CouponContainerVC: UIViewController {

    @IBOutlet weak var offerCollectionView: UICollectionView!
    
    let identifier = "OfferCell"
    var arrOffer: [ResOfferList] = []
    var totalAmount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offerCollectionView.register(UINib(nibName: identifier, bundle: nil),forCellWithReuseIdentifier: identifier)
        print(self.totalAmount)
    }

    func offerList()
    {
        Api.shared.getOfferList(self) { responseData in
            if responseData.count > 0
            {
                self.arrOffer = responseData
            }else
            {
                self.arrOffer = []
            }
            self.offerCollectionView.reloadData()
        }
    }
    
    func applyOffer(_ id: String, _ code : String) {
        Api.shared.applyOffer(self, self.paramDetails(id, code)) { responseData in
            self.alert(alertmessage: "Apply Offer Successfully!")
        }
    }
    
    func paramDetails(_ providerId: String, _ offerCode: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["provider_id"]            = providerId as AnyObject
        dict["offer_code"]             = offerCode as AnyObject
        dict["amount"]                 = self.totalAmount as AnyObject
        return dict
    }
}

extension CouponContainerVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrOffer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as! OfferCell
        
        let obj = arrOffer[indexPath.row]
        cell.lblCode.text! = obj.code ?? ""
        cell.lblDescription.text! = obj.description ?? ""
        if let imageUrl = URL(string: obj.image ?? ""){
            cell.img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""), options: .continueInBackground,completed: nil)
        }
        
        cell.cloApply = {
            self.applyOffer(obj.id ?? "", obj.code ?? "")
        }
        return cell
    }
}

extension CouponContainerVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}
