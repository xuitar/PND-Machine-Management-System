SELECT
    pa.ParkingAreaID, pa.LocationName,
    DATE_FORMAT(cc.`Timestamp`, '%Y-%m') AS YearMonth,
    COUNT(*) AS CollectionEvents,
    SUM(cc.Amount) AS TotalAmount
FROM cash_collection cc
JOIN machine_location ml
    ON ml.MachineLocationID = cc.MachineLocationID
JOIN parking_area pa
    ON pa.ParkingAreaID = ml.ParkingAreaID
WHERE cc.Completed = 1
GROUP BY
    pa.ParkingAreaID, pa.LocationName, DATE_FORMAT(cc.`Timestamp`, '%Y-%m')
ORDER BY
    YearMonth DESC, TotalAmount DESC;