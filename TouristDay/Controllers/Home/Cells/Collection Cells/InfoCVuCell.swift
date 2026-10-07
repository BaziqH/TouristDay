//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class InfoCVuCell: UICollectionViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var mainView: DesignableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //MARK: - CONFIGURE
    func configure(indexPath:IndexPath){
        if indexPath.row == 1 {
            numLabel.text = "8.5h"
            infoLabel.text = "Total Time"
            mainView.backgroundColor = .red.withAlphaComponent(0.3)
        }
    }
}
