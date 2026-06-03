//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class OptionsTVuCell: UITableViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    
    //MARK: - VARIABLES
    var optionsData: [OptionsDTO] = []
    var onTap: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        fillData()
        setupCollectionView()
        registerNibs()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK: - Auto height function
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.contentView.frame = self.bounds
        self.layoutIfNeeded()
        var size = self.optionsCollectionView.contentSize
        size.height += 12
        return size
    }
}
//MARK: - COLLECTION VIEW
extension OptionsTVuCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        optionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        loadOptionsCVuCell(indexPath)
    }
}
//MARK: - COLLECTION VIEW FLOWLAYOUT
extension OptionsTVuCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 5, height: 149)
    }
}
//MARK: - LOAD CELLS
extension OptionsTVuCell{
    func loadOptionsCVuCell(_ indexPath: IndexPath)-> UICollectionViewCell{
        guard let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCVuCell", for: indexPath) as? OptionsCVuCell else { return OptionsCVuCell() }
        cell.configure(model: optionsData[indexPath.row])
        return cell
    }
}
//MARK: - SELECT CELL TO EXPLORE
extension OptionsTVuCell{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Use this inside your didSelectRowAt or button action
        onTap?()
    }
}
//MARK: - SETUP COLLECTION VIEW
extension OptionsTVuCell{
    func setupCollectionView(){
        optionsCollectionView.delegate = self
        optionsCollectionView.dataSource = self
    }
    
    func registerNibs(){
        let optionsNib = UINib(nibName: "OptionsCVuCell", bundle: nil)
        optionsCollectionView.register(optionsNib, forCellWithReuseIdentifier: "OptionsCVuCell")
    }
}

//MARK: - FILL DATA
extension OptionsTVuCell{
    func fillData(){
        optionsData = [
            OptionsDTO(iconImg: UIImage(systemName: "fork.knife") ?? UIImage(),
                       iconBackColor: UIColor.blue.withAlphaComponent(0.3),
                       optionLabel: "Food Experience",
                       optionDesc: "Restaurants, markets & other culinary delights"),
            
            OptionsDTO(iconImg: UIImage(systemName: "theatermasks.fill") ?? UIImage(),
                       iconBackColor: UIColor.purple.withAlphaComponent(0.3),
                       optionLabel: "Culture & Arts",
                       optionDesc: "Museums, galleries, and local performances"),
            
            OptionsDTO(iconImg: UIImage(systemName: "airplane") ?? UIImage(),
                       iconBackColor: UIColor.orange.withAlphaComponent(0.3),
                       optionLabel: "Travel & Leisure",
                       optionDesc: "Flights, hotels, and sightseeing tours"),
            
            OptionsDTO(iconImg: UIImage(systemName: "figure.hiking") ?? UIImage(),
                       iconBackColor: UIColor.green.withAlphaComponent(0.3),
                       optionLabel: "Nature & Outdoors",
                       optionDesc: "Hiking trails, parks, and scenic views"),
            
            OptionsDTO(iconImg: UIImage(systemName: "cart.fill") ?? UIImage(),
                       iconBackColor: UIColor.systemPink.withAlphaComponent(0.3),
                       optionLabel: "Shopping",
                       optionDesc: "Boutiques, malls, and local craft markets"),
            
            OptionsDTO(iconImg: UIImage(systemName: "film.fill") ?? UIImage(),
                       iconBackColor: UIColor.systemRed.withAlphaComponent(0.3),
                       optionLabel: "Cinema",
                       optionDesc: "Latest blockbusters, indie films & theaters")
        ]
    }
}
