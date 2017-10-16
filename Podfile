platform :ios, '11.0'

def rx_swift
    pod 'RxSwift', '~> 3.0'
end

def rx_cocoa
    pod 'RxCocoa', '~> 3.0'
end

def rx_data_sources
    pod 'RxDataSources', '~> 1.0'
end

def test_pods
    pod 'RxTest', '~> 3.0'
    pod 'RxBlocking', '~> 3.0'
    pod 'Nimble'
end

target 'todoist' do
    use_frameworks!
    rx_cocoa
    rx_swift
    rx_data_sources
    pod 'QueryKit'

    target 'todoistTests' do
        inherit! :search_paths
        test_pods
    end
end

target 'Domain' do
    use_frameworks!
    rx_swift
    rx_data_sources
    target 'DomainTests' do
        inherit! :search_paths
        test_pods
    end
end

target 'RealmRepository' do
    use_frameworks!
    rx_swift
    rx_data_sources
    pod 'RxRealm'
    pod 'QueryKit'
    pod 'RealmSwift'
    pod 'Realm'

    target 'RealmRepositoryTests' do
        inherit! :search_paths
        test_pods
    end
end
