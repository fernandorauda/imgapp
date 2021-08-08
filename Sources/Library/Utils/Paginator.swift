//
//  Paginator.swift
//  imgapp
//
//  Created by Adonys Rauda on 8/8/21.
//

import RxCocoa
import RxSwift

final class Paginator<Model> {
    // MARK: - Properties

    let onNext: PublishSubject<Void>
    let onRestart: PublishSubject<Void>
    let onLoading: BehaviorRelay<Bool>
    let onUpdate: Observable<Void>
    
    private let store: BehaviorRelay<[Model]>
    private let state: PaginatorState
    
    init(fetcher: @escaping (Int) -> Observable<[Model]>) {
        onNext = PublishSubject()
        onRestart = PublishSubject()
        store = BehaviorRelay(value: [])
        onLoading = BehaviorRelay(value: false)
        state = PaginatorState(hasNext: true, isLoading: false, currentPage: 1, isEmpty: false)
        
        let shouldRestart = onRestart.do(onNext: {[state, store] in
            state.currentPage = 1
            store.accept([])
        })
        
        let shouldFetchNextPage = onNext
            .filter { [state] in !state.isLoading && state.hasNext }
            .do(onNext: { [state] in
                state.isLoading = true
            })
        
        onUpdate = Observable.combineLatest(shouldFetchNextPage, shouldRestart)
            .toVoid()
            .do(onNext: { [onLoading] _ in onLoading.accept(true) })
            .flatMapLatest { [state, fetcher] _ -> Observable<[Model]> in
                fetcher(state.currentPage)
            }
            .do(onNext: { [state, onLoading] models in
                state.isLoading = false
                state.currentPage += 1
                state.hasNext = !models.isEmpty
                onLoading.accept(false)
            },
            onError: { [state]_ in state.isLoading = false }
            )
            .map { [store, state] models -> [Model] in
                var currentModels = store.value
                currentModels.append(contentsOf: models)
                state.isEmpty = currentModels.isEmpty
                return currentModels
            }
            .do(onNext: { [store] models in
                store.accept(models)
            })
            .toVoid()
    }
}
