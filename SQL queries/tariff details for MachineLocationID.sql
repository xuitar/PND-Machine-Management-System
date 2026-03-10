SET @MachineLocationID := 109;

SELECT
    pa.ParkingAreaID, pa.LocationName, pa.Postcode,
    pa.ParkingZone, pa.RingGoLocationCode,

    pat.ParkingAreaTariffID, pat.EffectiveFrom, pat.EffectiveTo,

    t.TariffID, t.TariffName, t.Description, 
    t.FromDay, t.ToDay, t.FromTime, t.ToTime,

    ts.TariffStepID, ts.DurationMinutes, ts.Price

FROM machine_location ml
JOIN parking_area pa
    ON pa.ParkingAreaID = ml.ParkingAreaID
JOIN parking_area_tariff pat
    ON pat.ParkingAreaID = pa.ParkingAreaID
JOIN tariff t
    ON t.TariffID = pat.TariffID
JOIN tariff_step ts
    ON ts.TariffID = t.TariffID

WHERE ml.MachineLocationID = @MachineLocationID
    AND pat.EffectiveFrom <= NOW()
    AND (pat.EffectiveTo IS NULL OR pat.EffectiveTo > NOW())

ORDER BY t.TariffName, ts.DurationMinutes;