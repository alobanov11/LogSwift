//
//  Created by Антон Лобанов on 06.06.2021.
//

protocol ILogOutputStrategiesFactory: AnyObject {
	func strategy(for destination: LogOutputDestination) -> ILogOutputStrategy
}
