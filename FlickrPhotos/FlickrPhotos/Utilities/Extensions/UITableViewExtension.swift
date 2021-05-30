//
//  UITableViewExtension.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import UIKit

extension UITableView {
    /**
     It register table view cell nib file to the table.
     ### For Example ###
     let me suppose that the outlet of table view is TV
     ````
     TV.registerNib(cell: DetailsCell.self)
     ````
     */
    func registerNib<Cell: UITableViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    /**
     It dequeue the cell in cellForRowAt.
     ## Important Notes ##
     we call that function in cellForRowAt
     ### For Example ###
     ````
     cell = tableview.dequeue() as DetailsCell
     return cell
     ````
     */
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError(Errors.CELL_ERROR.rawValue)
        }
        return cell
    }
}
