//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class FullItineraryTVuCell: UITableViewCell {
    //MARK: - VARIABLES
    var viewItinerary: (()->Void)?
    //MARK: - ARRAYS
    //MARK: - OUTLETS
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func viewFullItinerary(_ sender: Any) {
        viewItinerary?()
    }
}
