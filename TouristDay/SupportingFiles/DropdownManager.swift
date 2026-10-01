/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
import UIKit

//Conform the dropdown VC that you want to present to this protocol
//Change the return accordingly
protocol DropDownPresentable: UIViewController {
    var options: [String] { get set }
}

class DropDownManager {
    
    // MARK: - State
    private weak var presentingVC: UIViewController?
    private var dropDownVC: UIViewController?
    private var backdrop: UIControl?
    private var blurBackdrop: UIVisualEffectView?
    
    // MARK: - Init
    init(presentingVC: UIViewController) {
        self.presentingVC = presentingVC
    }
    
    // MARK: - Show
    func show(
        from sender: UIView,
        storyboard: String,
        identifier: String,
        width: CGFloat,
        height: CGFloat,
        options: [String] = []
    ) {
        if dropDownVC != nil {
            dismiss()
            return
        }
        
        guard let window = presentingVC?.view.window else { return }
        
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: identifier)
        
        if let presentable = vc as? DropDownPresentable {
            presentable.options = options
        }
        
        let buttonFrame = sender.convert(sender.bounds, to: window)
        vc.view.frame = CGRect(
            x: buttonFrame.minX,
            y: buttonFrame.maxY + 12,
            width: width,
            height: height
        )
        vc.view.alpha = 0
        
        // Blur
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blurView.frame = window.bounds
        blurView.alpha = 0
        window.addSubview(blurView)
        blurBackdrop = blurView
        
        // Backdrop
        let bg = UIControl(frame: window.bounds)
        bg.backgroundColor = .clear
        bg.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        blurView.contentView.addSubview(bg)
        backdrop = bg
        
        window.addSubview(vc.view)
        dropDownVC = vc
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            vc.view.alpha = 1
            blurView.alpha = 0
        }
    }
    
    // MARK: - Dismiss
    @objc func dismiss() {
        backdrop?.removeFromSuperview()
        backdrop = nil
        blurBackdrop?.removeFromSuperview()
        blurBackdrop = nil
        
        guard let existing = dropDownVC else { return }
        dropDownVC = nil
        UIView.animate(withDuration: 0.2, animations: {
            existing.view.alpha = 0
        }) { _ in
            existing.view.removeFromSuperview()
        }
    }
}
