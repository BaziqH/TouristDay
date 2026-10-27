//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

// MARK: - ShimmerView

final class ShimmerView: UIView {

    private let gradientLayer = CAGradientLayer()
    private static let animationKey = "shimmer"
    private static let duration: CFTimeInterval = 1.2

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    deinit { NotificationCenter.default.removeObserver(self) }

    private func setup() {
        isUserInteractionEnabled = false
        clipsToBounds = true
        isAccessibilityElement = false
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0, 0.5, 1]
        layer.addSublayer(gradientLayer)
        updateColors()
        NotificationCenter.default.addObserver(
            self, selector: #selector(restart),
            name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        layer.cornerRadius = (superview?.layer.cornerRadius ?? 0) > 0
            ? superview!.layer.cornerRadius : 4
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        window == nil ? stop() : start()
    }

    override func traitCollectionDidChange(_ previous: UITraitCollection?) {
        super.traitCollectionDidChange(previous)
        updateColors()
    }

    private func updateColors() {
        traitCollection.performAsCurrent {
            let base = UIColor.systemGray5.cgColor
            let highlight = UIColor.systemGray4.cgColor
            backgroundColor = .systemGray5
            gradientLayer.colors = [base, highlight, base]
        }
    }

    private func start() {
        guard gradientLayer.animation(forKey: Self.animationKey) == nil,
              !UIAccessibility.isReduceMotionEnabled else { return }
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = Self.duration
        animation.repeatCount = .infinity
        animation.timeOffset = CACurrentMediaTime()
            .truncatingRemainder(dividingBy: Self.duration)
        gradientLayer.add(animation, forKey: Self.animationKey)
    }

    private func stop() {
        gradientLayer.removeAnimation(forKey: Self.animationKey)
    }

    @objc private func restart() {
        stop()
        if window != nil { start() }
    }
}

// MARK: - UIView + Skeleton

private enum SkeletonKeys {
    static var skeletonable = 0
}

extension UIView {

    @IBInspectable var isSkeletonable: Bool {
        get { objc_getAssociatedObject(self, &SkeletonKeys.skeletonable) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &SkeletonKeys.skeletonable, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func showSkeleton() {
        for subview in subviews {
            guard !subview.isHidden, subview.alpha > 0, !(subview is ShimmerView) else { continue }
            if subview.isSkeletonable {
                subview.attachShimmer()
            } else {
                subview.showSkeleton()
            }
        }
    }

    func hideSkeleton(animated: Bool = true) {
        for subview in subviews {
            if let shimmer = subview as? ShimmerView {
                guard animated else { shimmer.removeFromSuperview(); continue }
                UIView.animate(withDuration: 0.2, animations: { shimmer.alpha = 0 }) { _ in
                    shimmer.removeFromSuperview()
                }
            } else {
                subview.hideSkeleton(animated: animated)
            }
        }
    }

    private func attachShimmer() {
        guard !subviews.contains(where: { $0 is ShimmerView }) else { return }
        let shimmer = ShimmerView()
        shimmer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shimmer)
        NSLayoutConstraint.activate([
            shimmer.topAnchor.constraint(equalTo: topAnchor),
            shimmer.bottomAnchor.constraint(equalTo: bottomAnchor),
            shimmer.leadingAnchor.constraint(equalTo: leadingAnchor),
            shimmer.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
// MARK: - LoadingState

enum LoadingState {
    case loading
    case loaded
}
