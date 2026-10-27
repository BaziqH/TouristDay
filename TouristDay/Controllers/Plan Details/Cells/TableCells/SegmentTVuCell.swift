/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/


class SegmentTVuCell: UITableViewCell {
    //MARK: - OUTLETS
    @IBOutlet weak var segItinerary: UIButton!
    @IBOutlet weak var segMap: UIButton!
    
    //MARK: - VARIABLES
    var showMap: ((Bool) -> Void)?
    //MARK: - ARRAYS
    var segmentBtns: [UIButton] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func segmentControl(_ sender: UIButton) {
        segmentBtns = [segItinerary, segMap]
        
        for btn in segmentBtns {
            if sender == btn {
                btn.configuration?.background.backgroundColor = .white
                btn.configuration?.baseForegroundColor = .black
            } else {
                btn.configuration?.background.backgroundColor = .clear
                btn.configuration?.baseForegroundColor = .darkGray
            }
        }
    }
    @IBAction func segmentAction(_ sender: UIButton) {
        if sender == segMap {
            showMap?(true)
        } else if sender == segItinerary {
            showMap?(false)
        }
    }
}
