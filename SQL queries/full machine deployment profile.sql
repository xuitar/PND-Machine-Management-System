SELECT
  md.DeploymentID, md.MachineID, md.MachineLocationID,
  md.StartDate, md.EndDate,

  pa.ParkingAreaID, pa.LocationName, pa.Postcode,
  pa.ParkingZone, pa.RingGoLocationCode,

  ml.LocationDescription, ml.What3Words,
  ml.AcceptsCoin, ml.AcceptsCard,

  cs.Status        AS CurrentStatus,
  cs.ChangedAt     AS StatusChangedAt,
  cs.ChangedBy     AS StatusChangedBy,

  ls.LastServiceAt, ls.LastServiceTechnician,

  oi.OpenIssueCount

FROM machine_deployment md
JOIN machine_location ml
  ON ml.MachineLocationID = md.MachineLocationID
JOIN parking_area pa
  ON pa.ParkingAreaID = ml.ParkingAreaID

-- Current status, the latest status event per deployment
LEFT JOIN (
  SELECT msh.DeploymentID, msh.Status, msh.ChangedAt, msh.ChangedBy
  FROM machine_status_history msh
  JOIN (
    SELECT DeploymentID, MAX(ChangedAt) AS MaxChangedAt
    FROM machine_status_history
    GROUP BY DeploymentID
  ) latest
    ON latest.DeploymentID = msh.DeploymentID
   AND latest.MaxChangedAt = msh.ChangedAt
) cs
  ON cs.DeploymentID = md.DeploymentID

-- Last service per deployment
LEFT JOIN (
  SELECT
    s.DeploymentID,
    MAX(s.`Timestamp`) AS LastServiceAt,
    SUBSTRING_INDEX(
      GROUP_CONCAT(s.Technician ORDER BY s.`Timestamp` DESC),
      ',', 1
    ) AS LastServiceTechnician
  FROM service s
  GROUP BY s.DeploymentID
) ls
  ON ls.DeploymentID = md.DeploymentID

-- Open issues count per deployment
LEFT JOIN (
  SELECT i.DeploymentID, COUNT(*) AS OpenIssueCount
  FROM issue i
  WHERE i.Status = 0
  GROUP BY i.DeploymentID
) oi
  ON oi.DeploymentID = md.DeploymentID

-- Filter to active deployments only
WHERE (md.EndDate IS NULL OR md.EndDate > CURDATE())

ORDER BY pa.LocationName, ml.MachineLocationID, md.StartDate DESC;