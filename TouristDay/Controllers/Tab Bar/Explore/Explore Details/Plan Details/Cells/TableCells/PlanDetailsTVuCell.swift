/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

class PlanDetailsTVuCell: UITableViewCell {
    //MARK: - VARIABLES
    private var didLayout = false
    var tagsArr: [String] = []
    //MARK: - ARRAYS
    
    //MARK: - OUTLETS
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var tagCVuHeight: NSLayoutConstraint!
    
    //MARK: - VIEW CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        registerNibs()
        fillData()
    }
    override func layoutSubviews() {
        //MARK: - VARIABLES
        // private var didLayout = false
        super.layoutSubviews()
        if !didLayout {
            didLayout = true
            tagsCollectionView.reloadData()
            tagsCollectionView.layoutIfNeeded()
            tagCVuHeight.constant = tagsCollectionView.contentSize.height
        }
    }
    //MARK: - Auto height function
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.contentView.frame = CGRect(origin: .zero, size: targetSize)
        self.layoutIfNeeded()
        return self.contentView.systemLayoutSizeFitting(
            CGSize(width: targetSize.width, height: UIView.layoutFittingCompressedSize.height)
        )
    }
}
//MARK: - COLLECTION VIEW
extension PlanDetailsTVuCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tagsArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        loadPlanTagsCVuCell(indexPath)
    }
}
//MARK: - COLLECTION VIEW FLOWLAYOUT
extension PlanDetailsTVuCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = tagsArr[indexPath.row]
        let font = UIFont.systemFont(ofSize: 14, weight: .bold)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        let width = ceil(size.width) + 20
        let height = ceil(size.height) + 10
        return CGSize(width: width, height: height)
    }
}
//MARK: - LOAD CELLS
extension PlanDetailsTVuCell{
    func loadPlanTagsCVuCell(_ indexPath: IndexPath)-> UICollectionViewCell{
        guard let cell = tagsCollectionView.dequeueReusableCell(withReuseIdentifier: "PlanTagsCVuCell", for: indexPath) as? PlanTagsCVuCell else { return PlanTagsCVuCell() }
        cell.taglabel.text = tagsArr[indexPath.row]
        return cell
    }
}
//MARK: - SETUP COLLECTION VIEW
extension PlanDetailsTVuCell{
    func setupCollectionView(){
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
    }

    func registerNibs(){
        let tagNib = UINib(nibName: "PlanTagsCVuCell", bundle: nil)
        tagsCollectionView.register(tagNib, forCellWithReuseIdentifier: "PlanTagsCVuCell")
    }
}
//MARK: - FILL DATA
extension PlanDetailsTVuCell{
    func fillData(){
        tagsArr = [
            "Foodies", "Food", "Culinary", "Luxury", "Taste", "Exotic", "Value", "Ambiance"
        ]
        tagsCollectionView.reloadData()
    }
}



