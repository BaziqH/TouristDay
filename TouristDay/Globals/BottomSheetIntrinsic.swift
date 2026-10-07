//******** Developed by Drudots Technologies **********/
//******** https://drudotstech.com **********//

//import UIKit
//
//open class BottomSheetViewController: UIViewController {
//    
//    // Store multiple tokens to track both size and visibility changes simultaneously
//    private static var observerTokens: [NSKeyValueObservation] = []
//    
//    public static func presentContent(
//        _ viewController: UIViewController,
//        from presenter: UIViewController,
//        tableView: UITableView? = nil,
//        extraHeight: CGFloat = 0,
//        showGrabber: Bool = false,
//        cornerRadius: CGFloat = 20
//    ) {
//        // Clear out any old active observers
//        observerTokens.forEach { $0.invalidate() }
//        observerTokens.removeAll()
//        
//        viewController.loadViewIfNeeded()
//        
//        let targetWidth = presenter.view.bounds.width
//        let maxHeight = presenter.view.bounds.height * 0.85
//        
//        // 1. Set baseline initial structural configurations
//        viewController.preferredContentSize = CGSize(width: targetWidth, height: 400)
//        viewController.modalPresentationStyle = .pageSheet
//        
//        if let sheet = viewController.sheetPresentationController {
//            let id = UISheetPresentationController.Detent.Identifier("dynamic")
//            
//            if #available(iOS 16.0, *) {
//                sheet.detents = [
//                    .custom(identifier: id) { context in
//                        let currentHeight = viewController.preferredContentSize.height
//                        return min(currentHeight, maxHeight)
//                    }
//                ]
//            } else {
//                sheet.detents = [.medium(), .large()]
//            }
//            
//            sheet.largestUndimmedDetentIdentifier = .large
//            sheet.selectedDetentIdentifier = id
//            sheet.prefersGrabberVisible = showGrabber
//            sheet.preferredCornerRadius = cornerRadius
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//        }
//        
//        // Inline layout helper to dynamically toggle calculations based on table view visibility states
//        let updateSheetHeight = {
//            let targetSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)
//            var targetHeight: CGFloat = 0
//            
//            // If table view exists AND is physically visible, size based on its cells
//            if let tv = tableView, !tv.isHidden {
//                targetHeight = tv.contentSize.height + extraHeight
//            } else {
//                // If table is nil OR hidden, use compressed Auto Layout fitting sizes for the rest of the views
//                targetHeight = viewController.view.systemLayoutSizeFitting(
//                    targetSize,
//                    withHorizontalFittingPriority: .required,
//                    verticalFittingPriority: .fittingSizeLevel
//                ).height
//            }
//            
//            let finalHeight = min(targetHeight, maxHeight)
//            
//            if viewController.preferredContentSize.height != finalHeight {
//                DispatchQueue.main.async {
//                    // 1. Force the layout pass on the content view first to calculate new positions
//                    viewController.view.setNeedsLayout()
//                    
//                    // 2. Animate the preferredContentSize and sheet framework layout changes together
//                    UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
//                        viewController.preferredContentSize = CGSize(width: targetWidth, height: finalHeight)
//                        viewController.view.layoutIfNeeded()
//                        
//                        if #available(iOS 16.0, *) {
//                            viewController.sheetPresentationController?.invalidateDetents()
//                        }
//                    }, completion: nil)
//                }
//            }
//        }
//        
//        // 2. Attach reactive state tracking listeners if a table view context is present
//        if let tv = tableView {
//            // Token A: Watch cell loading modifications
//            let sizeObserver = tv.observe(\.contentSize, options: [.new]) { _, _ in
//                updateSheetHeight()
//            }
//            
//            // Token B: Watch the .isHidden property toggle switch
//            let visibilityObserver = tv.observe(\.isHidden, options: [.new]) { _, _ in
//                updateSheetHeight()
//            }
//            
//            observerTokens.append(contentsOf: [sizeObserver, visibilityObserver])
//        }
//        
//        // Run an initial layout engine evaluation path right before presenting
//        updateSheetHeight()
//        
//        presenter.view.tintAdjustmentMode = .normal
//        presenter.present(viewController, animated: true)
//    }
//}


//******** Developed by Drudots Technologies **********/
//******** https://drudotstech.com **********//

//******** Developed by Drudots Technologies **********/
//******** https://drudotstech.com **********//

import UIKit

open class BottomSheetViewController: UIViewController {
    
    // Store multiple tokens to track both size and visibility changes simultaneously
    private static var observerTokens: [NSKeyValueObservation] = []
    
    // A tracking variable to feed the animation context into the custom detent block safely
    private static var targetContentHeight: CGFloat = 400
    
    public static func presentContent(
        _ viewController: UIViewController,
        from presenter: UIViewController,
        tableView: UITableView? = nil,
        extraHeight: CGFloat = 0,
        showGrabber: Bool = false,
        cornerRadius: CGFloat = 20
    ) {
        // Clear out any old active observers
        observerTokens.forEach { $0.invalidate() }
        observerTokens.removeAll()
        
        viewController.loadViewIfNeeded()
        
        let targetWidth = presenter.view.bounds.width
        let maxHeight = presenter.view.bounds.height * 0.85
        
        // Initialize baseline tracking height
        self.targetContentHeight = 400
        viewController.preferredContentSize = CGSize(width: targetWidth, height: self.targetContentHeight)
        viewController.modalPresentationStyle = .pageSheet
        
        if let sheet = viewController.sheetPresentationController {
            let id = UISheetPresentationController.Detent.Identifier("dynamic")
            
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom(identifier: id) { _ in
                        return min(self.targetContentHeight, maxHeight)
                    }
                ]
            } else {
                sheet.detents = [.medium(), .large()]
            }
            
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.selectedDetentIdentifier = id
            sheet.prefersGrabberVisible = showGrabber
            sheet.preferredCornerRadius = cornerRadius
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
        // Inline layout helper to dynamically toggle calculations based on table view visibility states
        let updateSheetHeight = {
            let targetSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)
            var targetHeight: CGFloat = 0
            
            if let tv = tableView, !tv.isHidden {
                targetHeight = tv.contentSize.height + extraHeight
            } else {
                targetHeight = viewController.view.systemLayoutSizeFitting(
                    targetSize,
                    withHorizontalFittingPriority: .required,
                    verticalFittingPriority: .fittingSizeLevel
                ).height
            }
            
            let finalHeight = min(targetHeight, maxHeight)
            
            // Only fire animation if the target height has truly changed
            if self.targetContentHeight != finalHeight {
                DispatchQueue.main.async {
                    self.targetContentHeight = finalHeight
                    viewController.preferredContentSize = CGSize(width: targetWidth, height: finalHeight)
                    
                    if #available(iOS 16.0, *) {
                        if let sheet = viewController.sheetPresentationController {
                            sheet.animateChanges {
                                viewController.view.layoutIfNeeded()
                                sheet.invalidateDetents()
                            }
                        }
                    }
                }
            }
        }
        
        // 2. Attach reactive state tracking listeners if a table view context is present
        if let tv = tableView {
            let sizeObserver = tv.observe(\.contentSize, options: [.new]) { _, _ in
                updateSheetHeight()
            }
            
            let visibilityObserver = tv.observe(\.isHidden, options: [.new]) { _, _ in
                updateSheetHeight()
            }
            
            observerTokens.append(contentsOf: [sizeObserver, visibilityObserver])
        }
        
        updateSheetHeight()
        
        presenter.view.tintAdjustmentMode = .normal
        presenter.present(viewController, animated: true)
    }
}
