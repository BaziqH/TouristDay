/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class PlacesTVuCell: UITableViewCell {
    //MARK: - VARIABLES
    //MARK: - ARRAYS
    
    //MARK: - OUTLETS
    @IBOutlet weak var placeNo: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNoLine: UIView!
    @IBOutlet var ratingStars: [UIImageView]!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var phnNoLabel: UILabel!
    @IBOutlet weak var userRatingsNoLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLvlLabel: UILabel!
    @IBOutlet weak var placesStack: UIStackView!
    
    
    var priceConverter = PriceToCurrencySymbol()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(placeNo: Int, isFirst: Bool, isLast: Bool, model: PlaceDetails){
                
        self.placeNo.text = "\(placeNo)"
        self.placeTitle.text = model.displayName
        self.phnNoLabel.text = model.phoneNumber
        self.userRatingsNoLabel.text = String(model.userRatingCount ?? 0)
        self.addressLabel.text = model.address
        self.priceLvlLabel.text = priceConverter.priceString(level: model.priceLevel, regionCode: model.regionCode)
        
        placeImage.isHidden = !isFirst && !isLast
        placeNoLine.isHidden = isLast
        
        if let rating = model.rating {
            fillingRatingStars(rating: rating)
        }
    }
    
    func fillingRatingStars(rating: Double){
        ratingLbl.text = String(rating)
        let (integer, decimal) = modf(rating)
        if decimal >= 0.5 {
            for star in 0..<Int(integer) {
                ratingStars[star].image = UIImage(systemName: "star.fill")
            }
            ratingStars[Int(integer)].image = UIImage(systemName: "star.fill.left")
        } else {
            for star in 0..<Int(integer) {
                ratingStars[star].image = UIImage(systemName: "star.fill")
            }
        }
    }
}
