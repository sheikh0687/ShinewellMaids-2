//
//  DateTimeVC.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 12/06/23.
//

import UIKit
import FSCalendar
import DropDown

class DateTimeVC: UIViewController,UIGestureRecognizerDelegate,FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var calenderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var btnDrop1: UIButton!
    @IBOutlet weak var btnDrop2: UIButton!
    @IBOutlet weak var viewToHide: UIView!
    
    let identifier = "DayCell"
    var selectedDate = [String]()
    var dropDown1 = DropDown()
    var dropDown2 = DropDown()
    var selectedTime = ""
    var selectedMonth = "Once"
    var addressId = ""
    var address = ""
    var hour = ""
    var Maid = ""
    var cleaningMaterial = ""
    var materialName = ""
    var materialId = ""
    var materialPrice = ""
    var additionalService  = ""
    var serviceName = ""
    var servicePrice = ""
    var serviceTime = ""
    var serviceId = ""
    var cleanerEnter = ""
    var instruction = ""
    var amount = ""
    var serviceAmount = ""
    var vatAmount = ""
    var VAT = ""
    var descriptionVal = ""
    var formattedDate = ""
    var dayName = ""
    var userLat = 0.0
    var userLon = 0.0
    var selectedItem = [Int : Bool]()
    var selectedValues: [String] = []
    var commaSeparatedString = ""
    var currentTimeString = ""
    var currentDate = ""
    var filteredTimeArray = [String]()
    var filteredArray = [String]()
    
    var arrTime =
    [
        "08:00",
        "09:00",
        "10:00",
        "11:00",
        "12:00",
        "13:00",
        "14:00",
        "15:00",
        "16:00"
    ]
    
    var arrMonth =
    [
        "Once",
        "Weekly"
    ]
    
    var arrDayName =
    [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
    ]
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calender, action: #selector(self.calender.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayCollectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calenderHeightConstraint.constant = 400
        }
        
        self.calender.select(Date())
        
        let dateString = Date()
        
        print(dateString)
        
        let dateConverted = dateFormatter.string(from: dateString)
        
        print(dateConverted)
        
        if let date = dateFormatter.date(from: dateConverted) {
            dateFormatter.dateFormat = "MMMM dd"
            self.formattedDate = dateFormatter.string(from: date)
            self.currentDate = dateFormatter.string(from: date)
            print(formattedDate) // Output: "July 06"
            print(self.currentDate)
        } else {
            print("Invalid date format")
        }
        
        // Get the current date
        let currentDate = Date()
        
        // Create an instance of the calendar
        let calendar = Calendar.current
        
        // Get the day of the week for the current date
        let weekday = calendar.component(.weekday, from: currentDate)
        
        // Get the localized weekday symbols from the calendar
        let weekdaySymbols = calendar.weekdaySymbols
        
        // Get the day name using the weekday index
        self.dayName = weekdaySymbols[weekday - 1] // Subtract 1 as the weekday index is 1-based
        
        print(dayName) // Output: Monday, Tuesday, Wednesday, etc.
        
        
        self.view.addGestureRecognizer(self.scopeGesture)
        //        self.newTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calender.scope = .week
        
        // For UITest
        self.calender.accessibilityIdentifier = "calendar"
        
        let components = calendar.dateComponents([.hour, .minute], from: currentDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        self.currentTimeString = dateFormatter.string(from: calendar.date(from: components)!)
        
        print(self.currentTimeString)
        
        filterTimeArrayForDate(currentDate)
        
        // Set the initial title of the drop-down button with the first filtered value
        if let firstFilteredTime = dropDown1.dataSource.first {
            self.btnDrop1.setTitle(firstFilteredTime, for: .normal)
        }
        
        if self.formattedDate == self.currentDate {
            if self.filteredTimeArray.count > 0 {
                self.btnDrop1.setTitle(self.filteredTimeArray[0], for: .normal)
            }
        }else{
            self.btnDrop1.setTitle(self.arrTime[0], for: .normal)
        }
        
        //        if self.filteredTimeArray.count > 0 {
        //            self.btnDrop1.setTitle(self.filteredTimeArray[0] , for: .normal)
        //        }else{
        //            self.btnDrop1.setTitle("" , for: .normal)
        //        }
    }
    
    deinit {
        print("\(#function)")
    }
    
    private func filterTimeArrayForDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: Date())
        
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        if currentDateComponents == selectedDateComponents {
            // For the current date, only display values greater than the current time
            self.filteredTimeArray = self.arrTime.filter { $0 > currentTime }
            dropDown1.dataSource = filteredTimeArray
        } else {
            // For other dates, display the whole time array
            dropDown1.dataSource = arrTime
        }
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        // Get the current date
        let currentDate = Date()
        
        // Allow selection only for dates on or after the current date (ignoring time component)
        return date >= currentDate
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calenderHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        self.selectedDate = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDate)")
        if let date = dateFormatter.date(from: selectedDate[0]) {
            // Set the desired output format
            dateFormatter.dateFormat = "MMMM dd"
            
            // Convert the date to a string with the desired format
            self.formattedDate = dateFormatter.string(from: date)
            
            print(formattedDate) // Output: "July 07, 2023"
        } else {
            print("Invalid date format")
        }
        
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let weekdaySymbols = calendar.weekdaySymbols
        self.dayName = weekdaySymbols[weekday - 1]
        print(dayName)
        
        filterTimeArrayForDate(date)
        
        if let firstFilteredTime = dropDown1.dataSource.first {
            self.btnDrop1.setTitle(firstFilteredTime, for: .normal)
        }
        
        self.btnDrop1.setTitle("", for: .normal)
        
        if self.formattedDate == self.currentDate {
            if self.filteredTimeArray.count > 0 {
                self.btnDrop1.setTitle(self.filteredTimeArray[0], for: .normal)
            }
        }else{
            self.btnDrop1.setTitle(self.arrTime[0], for: .normal)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Select Date and Time", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#D2F6F4", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.collectionHeight.constant = CGFloat(self.arrDayName.count * 45)
        self.dayCollectionView.allowsMultipleSelection = true
        self.configureDropDown1()
        self.configureDropDown2()
        self.viewToHide.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func blankSelected()
    {
        for i in 0...arrDayName.count
        {
            selectedItem[i] = false
        }
    }
    
    @IBAction func btnDropDown1(_ sender: UIButton) {
        dropDown1.show()
    }
    
    func configureDropDown1()
    {
        dropDown1.anchorView = self.btnDrop1
        //        dropDown1.dataSource = self.arrTime
        dropDown1.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown1.selectionAction = { [weak self] index, item in
            print("Selected item: \(item) at index: \(index)")
            self?.selectedTime = item
            print(self?.currentTimeString ?? "")
            print(self?.selectedTime ?? "")
            self?.btnDrop1.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnDropDown2(_ sender: UIButton) {
        self.dropDown2.show()
    }
    
    func configureDropDown2()
    {
        dropDown2.anchorView = self.btnDrop2
        dropDown2.dataSource = self.arrMonth
        dropDown2.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown2.selectionAction = { [weak self] index, item in
            print("Selected item: \(item) at index: \(index)")
            self?.selectedMonth = item
            self?.btnDrop2.setTitle(item, for: .normal)
            if index == 1 {
                self?.viewToHide.isHidden = false
            }else{
                self?.viewToHide.isHidden = true
            }
        }
    }
    
    @IBAction func btnContinue(_ sender: UIButton) {
        if Utility.isUserLogin() {
            if self.selectedTime == "" {
                print("Please select the time slot!")
            }else{
                self.validate()
                self.addBooking()
            }
        } else {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func validate()
    {
        self.dayName = selectedValues.joined(separator: ",")
        print(commaSeparatedString)
    }
    
    func addBooking()
    {
        Api.shared.addBookings(self, self.paramDetails()) { responseData in
            if responseData.how_offen_want_service == "Once"{
                Utility.showAlertWithAction(withTitle: k.appName, message: "Booked Successfull", delegate: nil, parentViewController: self) { boool in
                    let vc = Kstoryboard.instantiateViewController(withIdentifier: "BookingRequestVC") as! BookingRequestVC
                    vc.requestId = responseData.id ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                Utility.showAlertWithAction(withTitle: k.appName, message: "Booked Successfull", delegate: nil, parentViewController: self) { boool in
                    Switcher.checkLogin()
                }
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject]       = [:]
        dict["user_id"]                      = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["total_amount"]                 = self.amount as AnyObject
        dict["service_amount"]               = self.serviceAmount as AnyObject
        dict["VAT_amount"]                   = self.vatAmount as AnyObject
        dict["VAT"]                          = self.VAT as AnyObject
        dict["date"]                         = self.formattedDate as AnyObject
        dict["time"]                         = self.selectedTime as AnyObject
        dict["address"]                      = self.address as AnyObject
        dict["address_id"]                   = self.addressId as AnyObject
        dict["description"]                  = self.descriptionVal as AnyObject
        dict["offer_id"]                     = k.emptyString as AnyObject
        dict["offer_code"]                   = k.emptyString as AnyObject
        dict["how_offen_want_service"]       = self.selectedMonth as AnyObject
        dict["how_many_hours"]               = self.hour as AnyObject
        dict["how_many_cleaners"]            = self.Maid as AnyObject
        dict["need_any_cleaning_material"]   = self.cleaningMaterial as AnyObject
        dict["additional_service"]           = self.additionalService as AnyObject
        dict["cleaning_material_name"]       = self.materialName as AnyObject
        dict["cleaning_material_id"]         = self.materialId as AnyObject
        dict["cleaning_material_price"]      = self.materialPrice as AnyObject
        dict["additional_service_name"]      = self.serviceName as AnyObject
        dict["additional_service_price"]     = self.servicePrice as AnyObject
        dict["additional_service_time"]      = self.serviceTime as AnyObject
        dict["additional_service_id"]        = self.serviceId as AnyObject
        dict["how_cleaner_enter"]            = self.cleanerEnter as AnyObject
        dict["cleaning_instruction"]         = self.instruction as AnyObject
        dict["timezone"]                     = localTimeZoneIdentifier as AnyObject
        dict["payment_type"]                 = k.emptyString as AnyObject
        dict["day_name"]                     = self.dayName as AnyObject
        dict["discount"]                     = k.emptyString as AnyObject
        dict["lat"]                          = self.userLat as AnyObject
        dict["lon"]                          = self.userLon as AnyObject
        print(dict)
        return dict
    }
}

extension DateTimeVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrDayName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        if self.selectedItem[indexPath.row] == true{
            cell.lblDay.text = self.arrDayName[indexPath.row]
            cell.img.image = UIImage(named: "Checked")
        }else{
            cell.lblDay.text = self.arrDayName[indexPath.row]
            cell.img.image = UIImage(named: "Uncheck1")
        }
        return cell
    }
}

extension DateTimeVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/2), height: 45)
    }
}

extension DateTimeVC: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = dayCollectionView.cellForItem(at: indexPath) as! DayCell
        cell.img.image = UIImage(named: "Checked")
        self.selectedItem[indexPath.row] = true
        print(selectedItem)
        
        let selectValue = self.arrDayName[indexPath.item]
        print(selectValue)
        if selectedValues.contains(selectValue){
            selectedValues.removeAll { $0 == selectValue }
        }else{
            selectedValues.append(selectValue)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = dayCollectionView.cellForItem(at: indexPath) as! DayCell
        cell.img.image = UIImage(named: "Uncheck1")
        self.selectedItem[indexPath.row] = false
    }
}
