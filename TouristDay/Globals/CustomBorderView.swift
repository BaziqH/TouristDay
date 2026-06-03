//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

import UIKit

@IBDesignable
class BottomRoundedBorderView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 12 { didSet { setNeedsLayout() } }
    @IBInspectable var borderWidth: CGFloat = 1 { didSet { setNeedsLayout() } }
    @IBInspectable var borderColor: UIColor = .black { didSet { setNeedsLayout() } }
    
    private let borderLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorder()
    }
    
    private func setupBorder() {
        let xOffset: CGFloat = 0.5
        
        // Setup rounding for the view background
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let path = UIBezierPath()
        
        // 1. Start at top-left
        path.move(to: CGPoint(x: xOffset, y: 0))
        
        // 2. Line down to the start of the curve
        // The curve starts 'cornerRadius' above the bottom
        path.addLine(to: CGPoint(x: xOffset, y: bounds.height - cornerRadius))
        
        // 3. Bottom-left curve
        // Center X must be (xOffset + cornerRadius) to align with the vertical line at xOffset
        path.addArc(withCenter: CGPoint(x: xOffset + cornerRadius, y: bounds.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: .pi,
                    endAngle: .pi / 2,
                    clockwise: false)
        
        // 4. Bottom line to start of bottom-right curve
        // The curve starts 'cornerRadius' away from the right edge line (which is at width - xOffset)
        path.addLine(to: CGPoint(x: bounds.width - xOffset - cornerRadius, y: bounds.height))
        
        // 5. Bottom-right curve
        // Center X must be (bounds.width - xOffset - cornerRadius)
        path.addArc(withCenter: CGPoint(x: bounds.width - xOffset - cornerRadius, y: bounds.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: .pi / 2,
                    endAngle: 0,
                    clockwise: false)
        
        // 6. Line up to top-right (at width - xOffset)
        path.addLine(to: CGPoint(x: bounds.width - xOffset, y: 0))
        
        borderLayer.path = path.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        
        if borderLayer.superlayer == nil {
            layer.addSublayer(borderLayer)
        }
        
        layer.borderWidth = 0
    }
}
