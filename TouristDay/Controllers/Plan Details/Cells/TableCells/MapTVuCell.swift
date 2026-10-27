//********** Developed by Drudots Technology **********//
//******* https://www.drudotstech.com **********//

class MapTVuCell: UITableViewCell {
    
    var places : [PlaceDetails] = []
    
    @IBOutlet weak var mapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.delegate = self
    }
    
    func configure(places: [PlaceDetails]) {
        self.places = places
        pinsOnMap()
    }
}


extension MapTVuCell: MKMapViewDelegate {
    
    func pinsOnMap() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)

        var annotations: [MKPointAnnotation] = []
        var coordinates: [CLLocationCoordinate2D] = []

        for item in places {
            guard let lat = item.latitude, let lon = item.longitude else { continue }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.subtitle = item.displayName
            annotations.append(annotation)
            coordinates.append(coordinate)
        }

        mapView.addAnnotations(annotations)
        drawRoutes(through: coordinates)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else { return MKOverlayRenderer(overlay: overlay) }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 4
        renderer.lineCap = .round
        renderer.lineJoin = .round
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let id = "PlacePin"
        let view = (mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKMarkerAnnotationView)
            ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: id)
        view.annotation = annotation
        view.displayPriority = .required
        view.collisionMode = .none
        view.clusteringIdentifier = nil
        return view
    }
    
    func drawRoutes(through coordinates: [CLLocationCoordinate2D]) {
        guard coordinates.count > 1 else { return }
        let group = DispatchGroup()
        var polylines = [MKPolyline?](repeating: nil, count: coordinates.count - 1)

        for i in 0..<coordinates.count - 1 {
            let request = MKDirections.Request()
            request.source          = MKMapItem(placemark: MKPlacemark(coordinate: coordinates[i]))
            request.destination     = MKMapItem(placemark: MKPlacemark(coordinate: coordinates[i + 1]))
            request.transportType   = .walking
            

            group.enter()
            MKDirections(request: request).calculate { response, _ in
                if let route = response?.routes.first {
                    polylines[i] = route.polyline
                } else {
                    // fallback: straight line for this leg only
                    polylines[i] = MKPolyline(coordinates: [coordinates[i], coordinates[i + 1]], count: 2)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            let valid = polylines.compactMap { $0 }
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.addOverlays(valid, level: .aboveRoads)
            let rect = valid.dropFirst().reduce(valid[0].boundingMapRect) { $0.union($1.boundingMapRect) }
            self.mapView.setVisibleMapRect(rect,
                                           edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 20),
                                           animated: false)
        }
    }
}
