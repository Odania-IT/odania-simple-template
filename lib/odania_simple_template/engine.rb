require 'odania'

module OdaniaSimpleTemplate
	class Engine < ::Rails::Engine
		::Odania.templates['odania_simple_template/application'] = {name: 'Odania Simple Template', template: 'odania_simple_template/application'}
	end
end
