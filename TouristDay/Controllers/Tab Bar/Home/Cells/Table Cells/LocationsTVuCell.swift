//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class LocationsTVuCell: UITableViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    //MARK: - VARIABLES
    var scheduleData: [ScheduleModelDTO] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        fillData()
        setupCollectionView()
        registerNibs()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Auto height function
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.contentView.frame = self.bounds
        self.layoutIfNeeded()
        var size = self.locationCollectionView.contentSize
        size.height += 45
        return size
    }
}
//MARK: - COLLECTION VIEW
extension LocationsTVuCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scheduleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        loadPaymentCVuCell(indexPath)
    }
}
//MARK: - COLLECTION VIEW FLOWLAYOUT
extension LocationsTVuCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row != 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: 220)
        }
    }
}
//MARK: - LOAD CELLS
extension LocationsTVuCell{
    func loadPaymentCVuCell(_ indexPath: IndexPath)-> UICollectionViewCell{
        guard let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: "LocationCVuCell", for: indexPath) as? LocationCVuCell else { return LocationCVuCell() }
        cell.configure(indexPath: indexPath, model: scheduleData[indexPath.row])
        return cell
    }
}
//MARK: - SETUP COLLECTION VIEW
extension LocationsTVuCell{
    func setupCollectionView(){
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
    }
    
    func registerNibs(){
        let locationNib = UINib(nibName: "LocationCVuCell", bundle: nil)
        locationCollectionView.register(locationNib, forCellWithReuseIdentifier: "LocationCVuCell")
    }
}
//MARK: - FILL DATA
extension LocationsTVuCell{
    func fillData(){
        scheduleData = [
            ScheduleModelDTO(
                image: UIImage(named: "img_tower") ?? UIImage(),
                placeIcon: UIImage(systemName: "mappin.circle") ?? UIImage(),
                IconBackColor: .blue.withAlphaComponent(0.2),
                placeLabel: "Visit Tower",
                placeTag: "Attraction",
                timeLabel: "1.5 hours",
                location: "Bahria Town"
            ),
            ScheduleModelDTO(
                image: UIImage(named: "img_tower") ?? UIImage(),
                placeIcon: UIImage(systemName: "leaf.fill") ?? UIImage(),
                IconBackColor: .green.withAlphaComponent(0.2),
                placeLabel: "Central Park",
                placeTag: "Nature",
                timeLabel: "45 mins",
                location: "Downtown"
            ),
            ScheduleModelDTO(
                image: UIImage(named: "img_tower") ?? UIImage(),
                placeIcon: UIImage(systemName: "cup.and.saucer.fill") ?? UIImage(),
                IconBackColor: .orange.withAlphaComponent(0.2),
                placeLabel: "Coffee Break",
                placeTag: "Food",
                timeLabel: "30 mins",
                location: "Main Blvd"
            )
        ]
    }
}
