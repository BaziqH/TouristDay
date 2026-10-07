//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class HeaderInfoTVuCell: UITableViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var citySelectBtn: UIButton!
    
    var selectCity: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        registerNibs()
        // Initialization code
    }
    // MARK: - CONFIGURE
    func configure(selectedCity: String){
        var config = citySelectBtn.configuration
        config?.title = selectedCity
        config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incomingAttributes in
            var outgoingAttributes = incomingAttributes
            let existingFont = self.citySelectBtn.titleLabel?.font ?? UIFont(name: "HelveticaNeue", size: 16)
            outgoingAttributes.font = existingFont
            return outgoingAttributes
        }
        citySelectBtn.configuration = config
    }
    
    //MARK: - ACTIONS
    @IBAction func citySelectBtnClicked(_ sender: Any) {
        selectCity?()
    }
}
//MARK: - COLLECTION VIEW
extension HeaderInfoTVuCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        loadPaymentCVuCell(indexPath)
    }
    
    
}
//MARK: - COLLECTION VIEW FLOWLAYOUT
extension HeaderInfoTVuCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2 - 5, height: collectionView.frame.height)
    }
}
//MARK: - LOAD CELLS
extension HeaderInfoTVuCell{
    func loadPaymentCVuCell(_ indexPath: IndexPath)-> UICollectionViewCell{
        guard let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: "InfoCVuCell", for: indexPath) as? InfoCVuCell else { return InfoCVuCell() }
        cell.configure(indexPath: indexPath)
        return cell
    }
}
//MARK: - SETUP COLLECTION VIEW
extension HeaderInfoTVuCell{
    func setupCollectionView(){
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
    }
    
    func registerNibs(){
        let infoNib = UINib(nibName: "InfoCVuCell", bundle: nil)
        infoCollectionView.register(infoNib, forCellWithReuseIdentifier: "InfoCVuCell")
    }
}
