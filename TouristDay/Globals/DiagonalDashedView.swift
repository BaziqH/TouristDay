//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//


@IBDesignable
class DiagonalDashedLayerView: UIView {
    private let shapeLayer = CAShapeLayer()
    
    @IBInspectable var lineGap: CGFloat = 10.0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable var lineWidth: CGFloat = 2.0 {
        didSet { shapeLayer.lineWidth = lineWidth }
    }
    
    @IBInspectable var lineColor: UIColor = .lightGray {
        didSet { shapeLayer.strokeColor = lineColor.cgColor }
    }
    
    @IBInspectable var dashPatternString: String = "4,4" {
        didSet {
            let components = dashPatternString.components(separatedBy: ",")
            shapeLayer.lineDashPattern = components.compactMap { str in
                if let value = Int(str.trimmingCharacters(in: .whitespaces)) {
                    return NSNumber(value: value)
                }
                return nil
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
    }

    private func setupLayer() {
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = [4, 4]
        
        layer.addSublayer(shapeLayer)
        layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.frame = bounds
        shapeLayer.path = createDiagonalPath().cgPath
    }

    private func createDiagonalPath() -> UIBezierPath {
        let path = UIBezierPath()
        let width = bounds.width
        let height = bounds.height
        
        // We go from -height to width + height to ensure full coverage during rotations/resizing
        for x in stride(from: -height, to: width + height, by: lineGap) {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x + height, y: height))
        }
        return path
    }
}
