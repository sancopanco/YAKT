module BoardsHelper
  def div_for_card(object, &block)
    options = { :class => 'card'}

    unless object.is_a?(Card)
      options[:class] += " attached-card rotate-#{rand(6) + 1}"
    end

    div_for(object, options, &block)
  end
end
