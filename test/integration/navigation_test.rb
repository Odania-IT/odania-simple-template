require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
	setup do
		# Setup Languages
		lang_de = Odania::Language.create!(name: 'German', iso_639_1: 'de')
		lang_en = Odania::Language.create!(name: 'English', iso_639_1: 'en')

		# Setup site
		@default_site = ::Odania::Site.create!(name: 'Test', host: 'test.host', is_active: true, is_default: true, tracking_code: '!TRACK THIS!',
															description: 'This is awesome', template: 'odania_simple_template/application',
															default_language_id: lang_de.id.to_s)
		host! @default_site.host

		# Setup data
		menu_de = Odania::Menu.create(site_id: @default_site.id, title: 'English Menu', language_id: lang_de.id, published: true)
		menu_en = Odania::Menu.create(site_id: @default_site.id, title: 'German Menu', language_id: lang_en.id, published: true)

		content = Odania::Content.create(site_id: @default_site.id, title: 'First Content', language_id: lang_de.id,
													body: 'This is the content body!', is_active: true)
		menu_item = Odania::MenuItem.create(menu_id: menu_de.id, title: 'start_test', target_type: 'CONTENT', target_data: {'id' => content.id})
		menu_de.default_menu_item_id = menu_item.id
		menu_de.save!
	end

	test 'content is rendered in new layout' do
		get '/'
		assert_response :success
		assert_template 'odania_simple_template/application'
	end
end

