FactoryGirl.define do
  factory :task do |f|
    f.association :user
    f.title 'Lorem Ipsum is simply dummy text'
    f.description 'Contrary to popular belief, Lorem Ipsum is not simply random text.'
  end
end