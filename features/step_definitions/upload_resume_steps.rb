When(/^he uploads a resume$/) do
  attach_file(:user_resume, File.join(Rails.root, 'features', 'files', 'Example_Resume_v01.pdf'))
end
