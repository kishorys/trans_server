FactoryGirl.define do
  factory :platform_record do
    tuid { (:A..:Z).to_a.shuffle[0,8].join }
  end
end
