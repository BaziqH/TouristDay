//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class FullItineraryTVuCell: UITableViewCell {
    //MARK: - VARIABLES
    var viewItinerary: (()->Void)?
    @IBOutlet weak var viewItineraryBtn: UIButton!
    @IBOutlet weak var itineraryView: DesignableView!
    @IBOutlet weak var borderView: BottomRoundedBorderView!
    @IBOutlet weak var itineraryLbl: UILabel!
    //MARK: - ARRAYS
    //MARK: - OUTLETS
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureForLoading(isEnabled: Bool, progressText: String){
        viewItineraryBtn.isEnabled = isEnabled
        itineraryLbl.text = progressText
    }
    
    @IBAction func viewFullItinerary(_ sender: Any) {
        viewItinerary?()
    }
}
