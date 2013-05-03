module ApplicationHelper
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  
  def resource_namedir
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end
  
  def avatar_url(user)
    if user.avatar.present?
      user.avatar.url(:medium)
    else
      default_url = "#{root_url}img/default_user_icon_128.png"
      #gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      #"http://gravatar.com/avatar/#{gravatar_id}.pngs=48&d=#{CGI.escape(default_url)}"
    end
  end
  def get_select_options(t, first_option, multiple = false)
    select("#{t.name.downcase}","id", t.all.collect{|p| [p.name,p.id]},
           {:include_blank => first_option},:multiple => multiple)
  end
  
  def render_modal_content(page_url)
    render :partial => page_url
  end
end
