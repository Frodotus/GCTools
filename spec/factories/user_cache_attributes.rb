# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_cache_attribute do
    user_id 1
    code "MyString"
  end
end
