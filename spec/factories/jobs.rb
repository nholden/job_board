FactoryGirl.define do
  factory :job do
    title "Aerospace engineer intern"
    term "Internship"
    location "Seattle, WA"
    majors "Aerospace engineering"
    description "The aerospace engineer intern will most of his effort 
                 designing prototypes for Boeing's next really awesome
                 aircraft, which is due to come out in 2016."
    url "http://www.boeing.com/jobs/aerospaceengineerintern.pdf"
    instructions "Send all applications directly to ceo@boeing.com"
    deadline "2015-12-01"
    salary "$20/hour"
    user
    experience
  end
end
