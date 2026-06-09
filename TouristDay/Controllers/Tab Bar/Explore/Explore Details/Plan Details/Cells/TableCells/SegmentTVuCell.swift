/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/


class SegmentTVuCell: UITableViewCell {
    //MARK: - VARIABLES
    var segmentBtns: [UIButton] = []
    //MARK: - ARRAYS
    //MARK: - OUTLETS
    @IBOutlet weak var segItinerary: UIButton!
    @IBOutlet weak var segMap: UIButton!
    
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
}
