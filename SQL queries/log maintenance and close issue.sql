-- Inputs
SET @DeploymentID := 3;
SET @TechnicianUserID := 8;     -- must be a Technician
SET @IssueID := 2;
SET @Description := 'Replaced coin selector module';
SET @Outcome := 'Resolved';
SET @ts := NOW();

-- Insert maintenance record
INSERT INTO maintenance
(
    DeploymentID, Technician, IssueID,
    Timestamp, Description, Outcome
)
VALUES
(
    @DeploymentID, @TechnicianUserID, @IssueID,
    @ts, @Description, @Outcome
);

-- Update issue status to resolved
UPDATE issue
SET Status = 1
WHERE IssueID = @IssueID;