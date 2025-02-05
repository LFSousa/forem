require "rails_helper"

RSpec.describe "Link on tags for post in notifications", type: :system do
  let(:js_tag) { create(:tag, name: "javascript") }
  let(:ruby_tag) { create(:tag, name: "ruby") }

  let(:article) do
    create(:article, tags: "javascript, ruby")
  end

  context "when user hasn't logged in" do
    before do
      visit "/dashboard"
    end

    it "shows the sign-with page", js: true do
      expect(page).to have_content(/Sign In With/i, count: Authentication::Providers.available.size)
    end
  end

  context "when logged in user" do
    before do
      sign_in article.user
    end

    it "shows articles", js: true do
      visit "/dashboard"
      expect(page).to have_selector(".spec__dashboard-story", count: 1)
    end
  end
end
