//
//  RC+Lists.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 1/28/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import RealmSwift

extension RealmContainer {
    func loadLists() {
        var lists = [List]()
        /// convert realm lists to normal lists
        let realmLists = realm.objects(RealmList.self)
        for realmList in realmLists {
            let list = List(
                id: realmList.id,
                title: realmList.title,
                description: realmList.desc,
                icon: realmList.icon,
                color: UInt(realmList.color),
                words: realmList.words.map { $0 },
                dateCreated: realmList.dateCreated
            )
            lists.append(list)
        }

        let sortBy = getListsSortBy?() ?? .newestFirst
        switch sortBy {
        case .newestFirst:
            lists = lists.sorted { $0.dateCreated > $1.dateCreated }
        case .oldestFirst:
            lists = lists.sorted { $0.dateCreated < $1.dateCreated }
        case .title:
            lists = lists.sorted { $0.displayedTitle > $1.displayedTitle }
        }
        
        listsUpdated?(lists)
    }

    func addList(list: List) {
        let words = RealmSwift.List<String>()
        words.append(objectsIn: list.words)
        let realmList = RealmList(
            id: list.id,
            title: list.title,
            desc: list.description,
            words: words,
            icon: list.icon,
            color: Int(list.color),
            dateCreated: list.dateCreated
        )

        /// make sure hasn't added yet
        if realm.object(ofType: RealmList.self, forPrimaryKey: list.id) == nil {
            do {
                try realm.write {
                    realm.add(realmList)
                }
            } catch {
                Debug.log("Error writing list: \(error)", .error)
            }
            loadLists()
        }
    }

    func updateList(list: List) {
        if let realmList = realm.object(ofType: RealmList.self, forPrimaryKey: list.id) {
            let words = list.getRealmWords()
            do {
                try realm.write {
                    realmList.title = list.title
                    realmList.desc = list.description
                    realmList.words = words
                    realmList.icon = list.icon
                    realmList.color = Int(list.color)
                    realmList.dateCreated = list.dateCreated
                }
            } catch {
                Debug.log("Error updating list: \(error)", .error)
            }
        }

        loadLists()
    }

    func deleteList(list: List) {
        if let realmList = realm.object(ofType: RealmList.self, forPrimaryKey: list.id) {
            do {
                try realm.write {
                    realm.delete(realmList)
                }
            } catch {
                Debug.log("Error deleting list: \(error)", .error)
            }
        }

        loadLists()
    }
}
