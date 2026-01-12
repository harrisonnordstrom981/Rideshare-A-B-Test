CREATE OR REPLACE VIEW `rideshare-483918.rideshare_ab_test.vw_rideshare_ab_clean` AS
SELECT
  *,
  
  -- Standardized trip status
  CASE
    WHEN ride_completed = TRUE THEN 'COMPLETED'
    ELSE 'CANCELED'
  END AS trip_status_clean,

  -- Realized revenue:
  -- Completed rides contribute revenue
  -- Canceled rides contribute $0
  CASE
    WHEN ride_completed = TRUE THEN COALESCE(total_amount, 0)
    ELSE 0
  END AS realized_revenue

FROM `rideshare-483918.rideshare_ab_test.vw_rideshare_clean`;
