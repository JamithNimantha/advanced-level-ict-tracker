import CoreData


extension PastPapersData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PastPapersData> {
        return NSFetchRequest<PastPapersData>(entityName: "PastPapersData")
    }

    @NSManaged public var compundsPerYear: Double
    @NSManaged public var futureValue: Double
    @NSManaged public var id: String?
    @NSManaged public var interest: Double
    @NSManaged public var payment: Double
    @NSManaged public var paymentMadeAt: Int16
    @NSManaged public var paymentsPerYear: Double
    @NSManaged public var presentValue: Double

}
