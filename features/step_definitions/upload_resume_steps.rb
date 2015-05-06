When(/^he uploads a resume$/) do
  attach_file(:user_resume, File.join(Rails.root, 'features', 'files', 'Example_Resume_v01.pdf'))
end

When(/^he clicks the "(.*?)" icon$/) do |alt_tag|
  find("i[alt='#{alt_tag}']").click
end
