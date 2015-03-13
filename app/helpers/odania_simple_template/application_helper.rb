module OdaniaSimpleTemplate
	module ApplicationHelper
		def menu_active(ctrl, action=nil)
			return '' if not controller.controller_name.eql?(ctrl)
			return '' if not action.nil? and not controller.action_name.eql?(action)

			return ' class="active"'.html_safe
		end
	end
end
