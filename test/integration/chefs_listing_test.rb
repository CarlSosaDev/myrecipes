require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
 
 def setup
   @chef = Chef.create!(name:"Carlos", email:"c.sosa@coimbra.com",password:"password",password_confirmation:"password")
   @chef2 = Chef.create(name:"Witiza",email:"wit@sunnon.com", password:"password",password_confirmation:"password")
   @admin_user = Chef.create!(name:"got",email:"got@got.com",password:"password",password_confirmation:"password",admin: true)
 end
 
 test "should get chefs lsiting " do
   sign_in_as(@chef,"password")
   get chefs_path
   assert_template 'chefs/index'
   assert_select 'a[href=?]', chef_path(@chef), text: @chef.name.capitalize
   assert_select 'a[href=?]', chef_path(@chef2), text: @chef2.name.capitalize
 end
 
 test "should delete chef" do
   sign_in_as(@admin_user,"password")
  get chefs_path
  assert_template 'chefs/index'
  assert_difference 'Chef.count', -1 do
   delete chef_path(@chef2)
  end
  assert_redirected_to chefs_path
  assert_not flash.empty?
 end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user,"password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef:{name:"carlos", email:"carlos@carlitos.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "carlos2", @chef.name
    assert_match("carlos2@example.com",@chef.emal)
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: {chef: {name: updated_name, email: updated_email}}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "carlos", @chef.name
    assert_match "carlos@example.com", @chef.name

  end
end
