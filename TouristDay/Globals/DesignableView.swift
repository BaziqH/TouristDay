import UIKit
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

@IBDesignable public class DesignableView: UIView {
    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
    
    @IBInspectable public var roundCorner: Bool = true {
        didSet {
            layer.cornerRadius = roundCorner ? layer.frame.size.height / 2 : 0
            
            clipsToBounds = true
            
        }
    }
    
    @IBInspectable public var desireCorner: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = desireCorner
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var leftTopCorner: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = leftTopCorner
            layer.maskedCorners = [.layerMinXMinYCorner]
            layer.masksToBounds = true
            clipsToBounds = true
        }
    }
    
    @IBInspectable var leftBottomCorner: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = leftBottomCorner
            layer.maskedCorners = [.layerMinXMaxYCorner]
            layer.masksToBounds = true
            clipsToBounds = true
        }
    }
    
    @IBInspectable var rightTopCorner: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = rightTopCorner
            layer.maskedCorners = [.layerMaxXMinYCorner]
            layer.masksToBounds = true
            clipsToBounds = true
            
        }
    }
    
    @IBInspectable var rightBottom: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = rightBottom
            layer.maskedCorners = [.layerMaxXMinYCorner]
            layer.masksToBounds = true
            clipsToBounds = true
        }
    }
    
    @IBInspectable var RightCornerRadius: CGFloat = 0.0 {
        didSet {
//            updateCorners()
            layer.cornerRadius = RightCornerRadius
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            layer.masksToBounds = true
            clipsToBounds = true
        }
    }
    
    @IBInspectable var LeftCornerRadius: CGFloat = 0.0 {
        didSet {
//            updateCorners()
            layer.cornerRadius = LeftCornerRadius
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            layer.masksToBounds = true
            clipsToBounds = true
        }
    }
    
    @IBInspectable var bottomCornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = bottomCornerRadius
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            layer.masksToBounds = true
            clipsToBounds = true
        }
    }
    
    @IBInspectable var topCornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = topCornerRadius
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            layer.masksToBounds = true
            clipsToBounds = true
        }
    }
    
    @IBInspectable var AllCorner: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = AllCorner
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            layer.masksToBounds = true
            clipsToBounds = true
        }
    }
    
    // MARK: - Gradient Color
    @IBInspectable var firstColor: UIColor = UIColor.clear{
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.updateView()
            }
        }
    }
    @IBInspectable var SecondColor: UIColor = UIColor.clear{
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.updateView()
            }
        }
    }
    
    public override class var layerClass: AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    func updateView()
    {
        guard let layer = self.layer as? CAGradientLayer else { return }
        
        layer.colors = [firstColor.cgColor, SecondColor.cgColor]
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}

extension UIImageView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        } get {
            return self.cornerRadius
        }
    }
}

