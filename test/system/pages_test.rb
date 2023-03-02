require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  setup do
    @page = pages(:one)
  end

  test "visiting the index" do
    visit pages_url
    assert_selector "h1", text: "Pages"
  end

  test "should create page" do
    visit pages_url
    click_on "New page"

    fill_in "Page number", with: @page.page_number
    fill_in "Writing", with: @page.writing_id
    click_on "Create Page"

    assert_text "Page was successfully created"
    click_on "Back"
  end

  test "should update Page" do
    visit page_url(@page)
    click_on "Edit this page", match: :first

    fill_in "Page number", with: @page.page_number
    fill_in "Writing", with: @page.writing_id
    click_on "Update Page"

    assert_text "Page was successfully updated"
    click_on "Back"
  end

  test "should destroy Page" do
    visit page_url(@page)
    click_on "Destroy this page", match: :first

    assert_text "Page was successfully destroyed"
  end
end
