//
//  MapUseCase.swift
//  Map
//
//  Created Sameh Mabrouk on 11/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

public protocol MapInteractable {
    func determineUserLocation() -> Observable<Location>
}

class MapUseCase: MapInteractable {

    private let service: MapServicePerforming
    private let locationService: LocationServiceChecking

    init(service: MapServicePerforming, locationService: LocationServiceChecking) {
        self.service = service
        self.locationService = locationService
    }
    
    func determineUserLocation() -> Observable<Location> {
        locationService.requestAuthorization()
        return Observable.create { [unowned self] observer in
            locationService.requestUserLocation { location in
                observer.onNext(location)
            }
            
            return Disposables.create()
        }
    }
}
