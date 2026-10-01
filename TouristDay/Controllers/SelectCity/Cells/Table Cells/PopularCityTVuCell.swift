/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class PopularCityTVuCell: UITableViewCell {
    //MARK: - VARIABLES
    //MARK: - ARRAYS
    
    //MARK: - OUTLETS
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: PopularCity){
        cityLbl.text = model.city
        countryLabel.text = model.country
    }
}
