# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :geocach, :class => 'Geocache' do
    name "MyString"
    code "MyString"
  end
end
