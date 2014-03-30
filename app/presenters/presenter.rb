class Presenter 

	def initialize(template, object)
    @template = (template || Template.new_template)
    @object = object
	end

  protected #-----------------------------------protected

  def h
    @template
  end

  def translations_absolute_path(key)
    "#{h.controller_name}.#{h.action_name}#{key}"
  end
  
  def _t(key, options = {})
    key = key.to_s[0] == '.' ? translations_absolute_path(key) : key
    h.t(key, options)
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def self.delegate_eveything_else_to(delegating_target)
    @delegating_target = delegating_target
  end

  def delegating_target
    @delegating_target ||= self.class.instance_variable_get("@delegating_target")
  end

  def method_missing(method, *args, &block)
    if delegating_target.present?
      send(delegating_target).send(method, *args, &block)
    else
      raise NoMethodError
    end
  end

  #memoize :time, :date
end