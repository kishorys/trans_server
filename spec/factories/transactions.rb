FactoryGirl.define do
  factory :transaction do
    tuid { (:A..:Z).to_a.shuffle[0,8].join }
    amount 1765 
    method_of_payment "CASH"
    tip_amount 0
    tax_amount 145
    is_synchronous false
    mcc_code 5812
    mid ''
    tid ''
    bp_username ''
    bp_password ''
    operator_id "001"
    supervisor_id "001"
    terminal_id "Terminal 9"
    venue_id 265
    venue_name "GoPago Lounge SF "
    venue_address "44 montgomery, San Francisco, CA"
    venue_city "San Francisco"
    venue_state "CA"
    venue_phone "(415) 944-7246"
    venue_zip "94104"
    created_at 1444990915
    updated_at 1444990915
    local_created_at 1381531003541
    local_order_id "265-9-2509"
  end

end
