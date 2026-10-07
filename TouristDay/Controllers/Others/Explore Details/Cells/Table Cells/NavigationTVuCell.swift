//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class NavigationTVuCell: UITableViewCell {
//MARK: - OUTLETS
    var backTap: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func backTapped(_ sender: Any) {
        backTap?()
    }
}
