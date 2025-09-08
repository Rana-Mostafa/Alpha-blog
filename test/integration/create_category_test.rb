require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get new_category_url
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_url, params: { category: { name: "Travel" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Travel", response.body
  end

  test "get new category form and reject invalid category submission" do
    get new_category_url
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_url, params: { category: { name: " " } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end    
end
