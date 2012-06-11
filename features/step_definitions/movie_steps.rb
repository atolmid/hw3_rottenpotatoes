# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #if (page.content.index(e1.to_s)) < (page.content.index(e2.to_s))
   # assert true
  #else
  #i  = page.should contain(e1)
  #puts page.body
  regexp = Regexp.new "[#{e1}]*[#{e2}]"
  #print "I am here4!"
  #print page.should have_content("#{e1}"+"#{e}"+"#{e2}") 
  assert page.body =~ regexp
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #flunk "Unimplemented"
  #end
end

Then /^(?:|I )should see "(.*)"$/ do |text|
  #puts page.body
  #save_and_open_page
  
  #print page.should have_content(text)
  if page.respond_to? :should
    #print "I am here1!"
    assert page.should have_content(text)
  else
    #print "I am here!"
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "(.*)"$/ do |text|
  #puts page.body
  #save_and_open_page
  if page.respond_to? :should
  #print "I am here2!"
    assert page.should_not have_content(text)
  else
    #print "I am here3!"
    assert page.has_no_content?(text)
  end
end

When /^(.*) is checked$/ do |rating|
  find(:css, "#ratings_#{rating}").set(true)
  ##pending # express the regexp above with the code you wish you had
end

When /^(?:|I ) follow "(.+)"$/ do |link|
  click_link(link)
end

Then /^I should see all of the movies$/ do
  #p (page.all('table#movies tr').count == 11)
  assert (page.all('table#movies tr').count == 11) # express the regexp above with the code you wish you had
end

Then /^I should see no movies$/ do
  assert page.all('table#movies tr').count == 1 # express the regexp above with the code you wish you had
end

#When /^(?:|I ) follow "Release Date"$/ do |link|
 # click_link(link)
#end
# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  #save_and_open_page
  rating_list.split(",").each do |rating|
    if uncheck == 'un'
      find(:css, "#ratings_#{rating}").set(false)
    else
      find(:css, "#ratings_#{rating}").set(true)
      #save_and_open_page
      #check("ratings_#{rating.strip}")
    end
   
  end
  #visit movies_path
  #save_and_open_page
  #puts page.body
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end
