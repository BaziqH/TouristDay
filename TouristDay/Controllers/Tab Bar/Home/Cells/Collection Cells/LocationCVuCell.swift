//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class LocationCVuCell: UICollectionViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var iconView: DesignableView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var placeTag: UILabel!
    @IBOutlet weak var timeSpent: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(indexPath: IndexPath, model: ScheduleModelDTO){
        if indexPath.row != 0 {
            imageView.isHidden = true
            stackTopConstraint.constant = 10
        } else {
            imageView.isHidden = false
            stackTopConstraint.constant = 0
        }
        locationImage.image = model.image
        iconView.backgroundColor = model.IconBackColor
        iconImage.backgroundColor = model.IconBackColor
        iconImage.image = model.placeIcon
        placeLabel.text = model.placeLabel
        placeTag.text = model.placeTag
        timeSpent.text = model.timeLabel
        location.text = model.location
    }
}
