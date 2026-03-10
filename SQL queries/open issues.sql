SELECT
    i.IssueID, i.IssueType, i.Severity,
    i.`Timestamp` AS ReportedAt,
    TIMESTAMPDIFF(DAY, i.`Timestamp`, NOW()) AS DaysOpen,

    md.MachineID, ml.MachineLocationID,
    
    pa.LocationName, pa.Postcode, pa.ParkingZone,

    CONCAT(u.FirstName, ' ', u.LastName) AS ReportedBy,
    u.Role AS ReporterRole,

    i.Description

FROM issue i
JOIN machine_deployment md
    ON md.DeploymentID = i.DeploymentID
JOIN machine_location ml
    ON ml.MachineLocationID = md.MachineLocationID
JOIN parking_area pa
    ON pa.ParkingAreaID = ml.ParkingAreaID
JOIN users u
    ON u.UserID = i.UserID

WHERE i.Status = 0
ORDER BY i.`Timestamp` ASC;