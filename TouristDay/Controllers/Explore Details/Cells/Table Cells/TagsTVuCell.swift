//
/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/
//

class TagsTVuCell: UITableViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    //MARK: - VARIABLES
    var tagsArr: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        fillData()
        setupCollectionView()
        registerNibs()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //MARK: - Auto height function
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.contentView.frame = self.bounds
        self.layoutIfNeeded()
        var size = self.tagsCollectionView.contentSize
        size.height += 40
        return size
    }
}
//MARK: - COLLECTION VIEW
extension TagsTVuCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tagsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        loadTagCVuCell(indexPath)
    }
}
//MARK: - COLLECTION VIEW FLOWLAYOUT
extension TagsTVuCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = tagsArr[indexPath.row]
        let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        let width = ceil(size.width) + 20
        let height = ceil(size.height) + 10
        return CGSize(width: width, height: height)
    }
}
//MARK: - LOAD CELLS
extension TagsTVuCell{
    func loadTagCVuCell(_ indexPath: IndexPath)-> UICollectionViewCell{
        guard let cell = tagsCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCVuCell", for: indexPath) as? TagCVuCell else { return TagCVuCell() }
        cell.tagLabel.text = tagsArr[indexPath.row]
        return cell
    }
}
//MARK: - SETUP COLLECTION VIEW
extension TagsTVuCell{
    func setupCollectionView(){
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
    }
    
    func registerNibs(){
        let tagNib = UINib(nibName: "TagCVuCell", bundle: nil)
        tagsCollectionView.register(tagNib, forCellWithReuseIdentifier: "TagCVuCell")
    }
}
//MARK: - FILL DATA
extension TagsTVuCell{
    func fillData(){
        tagsArr = [
            "Foodies", "Food", "Culinary", "Luxury", "Taste", "Exotic", "Value", "Ambiance"
        ]
    }
}
