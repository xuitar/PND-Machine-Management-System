SELECT
    pa.ParkingAreaID, pa.LocationName, pa.Postcode, pa.ParkingZone,
    COUNT(i.IssueID) AS TotalIssues
FROM parking_area pa
JOIN machine_location ml
    ON ml.ParkingAreaID = pa.ParkingAreaID
JOIN machine_deployment md
    ON md.MachineLocationID = ml.MachineLocationID
JOIN issue i
    ON i.DeploymentID = md.DeploymentID
GROUP BY
    pa.ParkingAreaID, pa.LocationName, pa.Postcode, pa.ParkingZone
ORDER BY
    TotalIssues DESC, pa.LocationName;