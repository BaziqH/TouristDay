/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

import UIKit

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
        applyStyles()
        applyTextFieldConstraints()
        applyIconSizeConstraints()
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
        
        // 🌟 FIX: Explicitly pinned top and bottom anchors with a lower priority.
        // This breaks any constraint collisions with private system container views.
        let topConstraint = textField.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        topConstraint.priority = UILayoutPriority(999)
        bottomConstraint.priority = UILayoutPriority(999)

        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: barHeight),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            topConstraint,
            bottomConstraint
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
        searchBarStyle = .minimal
        backgroundColor = barColor

        guard let textField = searchTextField as UISearchTextField? else { return }

        textField.backgroundColor = textFieldBackgroundColor
        textField.tintColor = searchIconColor

        // borderStyle = .none removes private system background drawing subviews
        textField.borderStyle = .none

        textField.layer.cornerRadius = textFieldCornerRadius
        textField.clipsToBounds = true
        textField.textColor = textColor

        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = borderWidth

        if let placeholder = textField.placeholder {
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    .foregroundColor: placeholderColor,
                    .font: textField.font ?? UIFont.systemFont(ofSize: 16)
                ]
            )
        }

        if let glassIcon = textField.leftView as? UIImageView {
            glassIcon.image = glassIcon.image?.withRenderingMode(.alwaysTemplate)
            glassIcon.tintColor = searchIconColor
        }
        let clearButtonProxy = UIButton.appearance(whenContainedInInstancesOf: [UISearchBar.self])
                clearButtonProxy.tintColor = searchIconColor
        showsBookmarkButton = showMicrophone
    }
}
