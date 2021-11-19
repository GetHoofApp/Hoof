//
//  MapViewModel.swift
//  Map
//
//  Created Sameh Mabrouk on 11/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol MapViewModellable: ViewModellable {
    var inputs: MapViewModelInputs { get }
    var outputs: MapViewModelOutputs { get }
}

struct MapViewModelInputs {
    var viewState = PublishSubject<ViewState>()
}

struct MapViewModelOutputs {
    var showUserLocation = PublishSubject<(lat: Double, lng: Double)>()
}

class MapViewModel: MapViewModellable {

    let disposeBag = DisposeBag()
    let inputs = MapViewModelInputs()
    let outputs = MapViewModelOutputs()
    var useCase: MapInteractable

    init(useCase: MapInteractable) {
        self.useCase = useCase
        
        setupObservables()
    }
}

// MARK: - Observables

private extension MapViewModel {

    func setupObservables() {
        inputs.viewState.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loaded:
                self.useCase.determineUserLocation().subscribe { event in
                    guard let location = event.element else { return }
                    self.outputs.showUserLocation.onNext((location.lat, location.lng))
                }.disposed(by: self.disposeBag)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}
