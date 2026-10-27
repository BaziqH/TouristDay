//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class HighlightsTVuCell: UITableViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var highlightsStack: UIStackView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var placesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var highlightLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.hideSkeleton(animated: false)
    }
    func configureForSkeleton(showSkeleton: Bool,indexPath: IndexPath){
        showSkeleton ? contentView.showSkeleton() : contentView.hideSkeleton()
        highlightsStack.isHidden = indexPath.row != 0
    }
    
    func configure(indexPath: IndexPath, model: Activity){
        highlightsStack.isHidden = indexPath.row != 0
        numberLabel.text = String(indexPath.row + 1)
        placesLabel.text = model.placeName
        contentView.hideSkeleton(animated: true)
//        ratingLabel.text = model.rating
    }
    
}
