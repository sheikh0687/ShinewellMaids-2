//
//  Extension.swift
//  ShinewellMaids
//
//  Created by Techimmense Software Solutions on 10/06/23.
//

import UIKit
class Extention: NSObject {

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
  func whiteSpacesRemoved() -> String {
    return self.filter { $0 != Character(" ") }
  }
}

class CustomTabBar : UITabBar {
    
    @IBInspectable var height: CGFloat = 65.0
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            
            if #available(iOS 11.0, *) {
                sizeThatFits.height = height + window.safeAreaInsets.bottom
            } else {
                sizeThatFits.height = height
            }
        }
        return sizeThatFits
    }
}

extension String {
    func toDouble(_ locale: Locale) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = locale
        formatter.usesGroupingSeparator = true
        if let result = formatter.number(from: self)?.doubleValue {
            return result
        } else {
            return 0
        }
    }
}

extension UITableView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}

extension UICollectionView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text:String) -> NSMutableAttributedString {
        
        let attrs : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Bold", size: 12)!,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let attrs : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 12)!,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        let normal =  NSAttributedString(string: text,  attributes:attrs)
        self.append(normal)
        return self
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if #available(iOS 11.0, *) {
            sizeThatFits.height = window.safeAreaInsets.bottom + 40
        } else {
            // Fallback on earlier versions
        }
        return sizeThatFits
    }
}

@IBDesignable extension UILabel {
    
    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
@IBDesignable extension UIButton {
    
    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    
}



@IBDesignable
class TextField: UITextField {
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}

@IBDesignable extension UITextField {
    
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }

    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
@IBDesignable extension UITextView {
    
    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    
}

extension UISwitch {
    func setDimensions(width: CGFloat, height: CGFloat) {
        var newFrame = frame
        newFrame.size.width = width
        newFrame.size.height = height
        frame = newFrame
    }
}

extension UITextView {
    
    func addHint(_ hint: String) {
        let hintLabel = UILabel()
        hintLabel.text = hint
        hintLabel.font = self.font
        hintLabel.textColor = UIColor.lightGray
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(hintLabel)
        
        NSLayoutConstraint.activate([
            hintLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            hintLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
            // Add additional constraints as needed
        ])
        
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: nil, queue: nil) { [weak self] _ in
            self?.updateHintVisibility(hintLabel)
        }
        
        updateHintVisibility(hintLabel)
    }
    
    private func updateHintVisibility(_ hintLabel: UILabel) {
        hintLabel.isHidden = !self.text.isEmpty
    }
}


//extension UITextField {
//    @IBInspectable var placeHolderColor: UIColor? {
//        get {
//            return self.placeHolderColor
//        }
//        set {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
//        }
//    }
//}
@IBDesignable extension UIImageView {
    
    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    
}
@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth1: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius1: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor1: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 10, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

extension String {
    static func GetNoonTime() -> String {
        let date = Date()
        // Make Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a"
        // hh for hour mm for minutes and a will show you AM or PM
        let str: String = dateFormatter.string(from: date)
        print("\(str)")
        // Sperate str by space i.e. you will get time and AM/PM at index 0 and 1 respectively
        var array: [Any] = str.components(separatedBy: " ")
        
        // Now you can check it by 12. If < 12 means Its morning > 12 means its evening or night
        
        var message: String = ""
        let timeInHour: String = array[0] as! String
        let am_pm: String = array[1] as! String
        
        if CInt(timeInHour)! < 12 && (am_pm == "AM") {
            message = "Good Morning"
        }
        else if CInt(timeInHour)! <= 4 && (am_pm == "PM") {
            message = "Good Afternoon"
        }
        else if CInt(timeInHour) == 12 && (am_pm == "PM") {
            message = "Good Afternoon"
        }
        else if CInt(timeInHour)! > 4 && (am_pm == "PM") {
            message = "Good Night"
        }
        print("\(message)")

        return message
    }
}

@IBDesignable class BigSwitch: UISwitch {

    @IBInspectable var scale : CGFloat = 1{
        didSet{
            setup()
        }
    }

    //from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    //from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup(){
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
    }

    override func prepareForInterfaceBuilder() {
        setup()
        super.prepareForInterfaceBuilder()
    }


}

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.borderColor = color.cgColor
      } else {
        layer.borderColor = nil
      }
    }
  }
  
  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable
  var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }
  
  @IBInspectable
  var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  var shadowColor: UIColor? {
    get {
      if let color = layer.shadowColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.shadowColor = color.cgColor
      } else {
        layer.shadowColor = nil
      }
    }
  }
}
