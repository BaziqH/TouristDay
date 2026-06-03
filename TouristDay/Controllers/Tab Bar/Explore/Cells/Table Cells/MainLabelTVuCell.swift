//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class MainLabelTVuCell: UITableViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var bigLabelView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(){
        bigLabelView.isHidden = true
    }
}
