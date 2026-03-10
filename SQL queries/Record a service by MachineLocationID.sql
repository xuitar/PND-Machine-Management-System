-- Inputs
SET @MachineLocationID := 1;
SET @TechnicianUserID  := 8;   -- must be a Technician
SET @ts := NOW();
SET @OutsideClean      := 1;
SET @InsideClean       := 1;
SET @CoinSelectorCheck := 1;
SET @BankingComsCheck  := 0;
SET @PrinterCheck      := 1;
SET @Comments          := 'Routine service: cleaned, coin path checked, printer tested.';


INSERT INTO service
(
    DeploymentID, Technician, `Timestamp`,
    OutsideClean, InsideClean, CoinSelectorCheck, 
    BankingComsCheck, PrinterCheck, Comments
)
SELECT
    md.DeploymentID, @TechnicianUserID, @ts,
    @OutsideClean, @InsideClean, @CoinSelectorCheck,
    @BankingComsCheck, @PrinterCheck, @Comments

FROM machine_deployment md
WHERE md.MachineLocationID = @MachineLocationID
    AND (md.EndDate IS NULL OR md.EndDate > CURDATE())
ORDER BY md.StartDate DESC
LIMIT 1;