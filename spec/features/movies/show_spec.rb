require 'rails_helper'

RSpec.describe '/users/:id/movies/:id', type: :feature do

  before do
    @steve = User.create!(name: 'steve', email: 'steve@steve.com', password: 'steve123')
    @bob = User.create!(name: "bob", email: "bob@bob.com", password: "bob123")
    
    
  end
  describe 'As a user' do
    context 'When I visit the /users/:id/movies/:id path, where :id, is the id of a valid user' do
      it "I should see the movie's title", :vcr do
        visit "/users/#{@steve.id}/movies/238"

        expect(page).to have_content("The Godfather")
      end
      it "I should see a button to create a Viewing Party", :vcr do
        visit "/users/#{@steve.id}/movies/238"
        
        expect(page).to have_button("Create Viewing Party for The Godfather")
      end

      it "I should see a button to return to the discover page", :vcr do
        visit "/users/#{@steve.id}/movies/238"

        expect(page).to have_button("Return to Discover Page")
        click_on "Return to Discover Page"
        expect(current_path).to eq(user_discover_index_path(@steve.id))
      end

      it "I should see the vote average for the movie", :vcr do
        visit "/users/#{@steve.id}/movies/238"

        expect(page).to have_content("Vote: 8.712")
      end

      it "I should see the runtime for the movie", :vcr do
        visit "/users/#{@steve.id}/movies/238"

        expect(page).to have_content("Runtime: 2hr 55min")
      end

      it "I should see the genres for the movie", :vcr do
        visit "/users/#{@steve.id}/movies/238"

        expect(page).to have_content("Genre:")
        expect(page).to have_content("Drama")
        expect(page).to have_content("Crime")
      end

      it "I should see the summary for the movie", :vcr do
        visit "/users/#{@steve.id}/movies/238"

        expect(page).to have_content("Summary:")
        expect(page).to have_content("Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.")
      end

      it "I should see the cast for the movie", :vcr do
        visit "/users/#{@steve.id}/movies/238"

        expect(page).to have_content("Cast:")
        expect(page).to have_content("Marlon Brando: Don Vito Corleone")
      end

      it "I should see the count of total reviews for the movie", :vcr do
        visit "/users/#{@steve.id}/movies/238"
        
        expect(page).to have_content("3 Reviews")
      end

      it "I should see the reviews and their authors", :vcr do
        visit "/users/#{@steve.id}/movies/238"

        expect(page).to have_content("futuretv:")
        expect(page).to have_content("The Godfather Review by Al Carlson\r \r The Godfather is a film considered by most to be one of the greatest ever made.")
        expect(page).to have_content("crastana:")
        expect(page).to have_content("The best movie ever...")
      end
    end
  end
end