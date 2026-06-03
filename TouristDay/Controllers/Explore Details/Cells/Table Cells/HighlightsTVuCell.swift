//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class HighlightsTVuCell: UITableViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var highlightsLabel: UIStackView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var placesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(indexPath: IndexPath, model: PlacesDTO){
        if indexPath.row != 0 {
            highlightsLabel.isHidden = true
        } else {
            highlightsLabel.isHidden = false
        }
        numberLabel.text = String(model.number)
        placesLabel.text = model.name
        ratingLabel.text = model.rating
    }
    
}
