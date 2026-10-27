//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class OptionsCVuCell: UICollectionViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//MARK: - CONFIGURE
    func configure(model: OptionsDTO){
        iconImg.image = model.iconImg
        iconImg.backgroundColor = model.iconBackColor
        mainLabel.text = model.optionLabel
        descLabel.text = model.optionDesc
    }
}
