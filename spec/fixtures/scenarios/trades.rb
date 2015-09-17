require 'factory_girl'
FactoryGirl.find_definitions

use_manual_close

account :usd_gateway,  FactoryGirl.create(:usd_gateway_key_pair)
account :eur_gateway,  FactoryGirl.create(:eur_gateway_key_pair)
account :scott,        FactoryGirl.create(:scott_key_pair)
account :bartek,       FactoryGirl.create(:bartek_key_pair)

create_account :scott,  :master, 100
create_account :bartek, :master, 100
create_account :usd_gateway, :master, 100
create_account :eur_gateway, :master, 100

close_ledger

trust :scott,  :usd_gateway, "USD"
trust :bartek, :usd_gateway, "USD"
trust :scott,  :eur_gateway, "EUR"
trust :bartek, :eur_gateway, "EUR"

close_ledger

payment :usd_gateway, :scott,  ["USD", :usd_gateway, 500]
payment :eur_gateway, :bartek, ["EUR", :eur_gateway, 500]

close_ledger

offer :bartek, {buy:["USD", :usd_gateway], with:["EUR", :eur_gateway]}, 100, 1.0
offer :bartek, {buy:["USD", :usd_gateway], with:["EUR", :eur_gateway]}, 100, 0.9
offer :bartek, {buy:["USD", :usd_gateway], with:["EUR", :eur_gateway]}, 100, 0.8

close_ledger

offer :scott, {sell:["USD", :usd_gateway], for:["EUR", :eur_gateway]}, 50, 1.0

offer :scott, {sell:["USD", :usd_gateway], for: :native}, 50, 1.0
