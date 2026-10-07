/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class PlacesTVuCell: UITableViewCell {
    //MARK: - VARIABLES
    //MARK: - ARRAYS
    
    //MARK: - OUTLETS
    @IBOutlet weak var placeNo: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNoLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(placeNo: Int){
        self.placeNo.text = "\(placeNo)"
        
        if placeNo != 1 && placeNo != 5{
            placeImage.isHidden = true
        } else {
            placeImage.isHidden = false
        }
        if placeNo == 5 {
            placeNoLine.isHidden = true
        } else {
            placeNoLine.isHidden = false
        }
    }
}
