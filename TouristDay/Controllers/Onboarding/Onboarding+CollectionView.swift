/********** Developed by Drudots Technology **********/
/******** https://www.drudotstech.com **********/

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tagsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        loadPlanTagsCVuCell(indexPath)
    }
}
extension OnboardingVC{
    func loadPlanTagsCVuCell(_ indexPath: IndexPath)->UICollectionViewCell{
        guard let cell = onboardTagsCVu.dequeueReusableCell(withReuseIdentifier: "PlanTagsCVuCell", for: indexPath) as? PlanTagsCVuCell else {
            return PlanTagsCVuCell()
        }
        cell.taglabel.text = tagsArr[indexPath.row]
        return cell
    }
}

extension OnboardingVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = tagsArr[indexPath.row]
        label.sizeToFit()
        let width = label.frame.width + 20
        let height = label.frame.height + 10
        return CGSize(width: width, height: height)
    }
}
extension OnboardingVC{
    
    func centerContentVertically() {
        let contentHeight = onboardTagsCVu.contentSize.height
        let collectionHeight = onboardTagsCVu.frame.height
        let topInset = max(0, (collectionHeight - contentHeight) / 2)
        onboardTagsCVu.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
    }
    
}
extension OnboardingVC{
    func setupCollectionView(){
        onboardTagsCVu.delegate = self
        onboardTagsCVu.dataSource = self
        
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .center)
        onboardTagsCVu.collectionViewLayout = layout
    }
    func registerNibs(){
        let tagNib = UINib(nibName: "PlanTagsCVuCell", bundle: nil)
        onboardTagsCVu.register(tagNib, forCellWithReuseIdentifier: "PlanTagsCVuCell")
    }
}

