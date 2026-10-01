/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

@IBDesignable
class DesignableSearchBar: UISearchBar {

    @IBInspectable var barHeight: CGFloat = 56 {
        didSet {
            invalidateIntrinsicContentSize()
            heightConstraintApplied = false
            setNeedsLayout()
        }
    }

    @IBInspectable var textFieldBackgroundColor: UIColor = .systemGray6 {
        didSet { applyStyles() }
    }

    @IBInspectable var textColor: UIColor = .label {
        didSet { applyStyles() }
    }

    @IBInspectable var placeholderColor: UIColor = .placeholderText {
        didSet { applyStyles() }
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet { applyStyles() }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { applyStyles() }
    }

    @IBInspectable var textFieldCornerRadius: CGFloat = 10 {
        didSet { applyStyles() }
    }
    
    @IBInspectable var iconSize: CGFloat = 20 {
        didSet {
            iconSizeApplied = false
            setNeedsLayout()
        }
    }

    @IBInspectable var searchIconColor: UIColor = .systemGray {
        didSet { applyStyles() }
    }
    
    @IBInspectable var showMicrophone: Bool = false {
        didSet { applyStyles() }
    }

    @IBInspectable var barColor: UIColor = .clear {
        didSet { applyStyles() }
    }

    private var heightConstraintApplied = false
    private var iconSizeApplied = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        applyStyles()
        invalidateIntrinsicContentSize()

        let font = UIFont(name: "Helvetica-Bold", size: 16)!
        searchTextField.font = font

        if let placeholder = searchTextField.placeholder {
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.font: font]
            )
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: barHeight)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyStyles()
        applyTextFieldConstraints()
        applyIconSizeConstraints()
    }

    // MARK: - Text Field Sizing (grows search bar via constraints, no frame hacks)
    private func applyTextFieldConstraints() {
        guard !heightConstraintApplied else { return }
        guard let textField = searchTextField as UISearchTextField? else { return }

        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: barHeight),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        heightConstraintApplied = true
    }

    // MARK: - Search/Glass Icon Sizing
    private func applyIconSizeConstraints() {
        guard !iconSizeApplied else { return }
        guard let textField = searchTextField as UISearchTextField? else { return }
        guard let glassIcon = textField.leftView else { return }

        if let imageView = glassIcon as? UIImageView {
            imageView.contentMode = .scaleAspectFit
        }

        glassIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            glassIcon.widthAnchor.constraint(equalToConstant: iconSize),
            glassIcon.heightAnchor.constraint(equalToConstant: iconSize)
        ])

        iconSizeApplied = true
    }

    private func applyStyles() {
        backgroundImage = UIImage()
        backgroundColor = barColor

        guard let textField = searchTextField as UISearchTextField? else { return }

        textField.backgroundColor = textFieldBackgroundColor

        // borderStyle = .roundedRect (default) pulls in _UISearchBarSearchFieldBackgroundView
        // with its own grey fill — .none removes it so our colors apply correctly
        textField.borderStyle = .none

        textField.layer.cornerRadius = textFieldCornerRadius
        textField.clipsToBounds = true
        textField.textColor = textColor

        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = borderWidth

        if let placeholder = textField.placeholder {
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: placeholderColor]
            )
        }

        if let glassIcon = textField.leftView as? UIImageView {
            glassIcon.tintColor = searchIconColor
        }
        if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
            let image = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(image, for: .normal)
            clearButton.tintColor = searchIconColor
        }

        showsBookmarkButton = showMicrophone
    }
}
