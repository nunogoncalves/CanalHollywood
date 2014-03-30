RailsAdmin.config do |config|

 config.model 'Movie' do
    object_label_method do
      :original_name
    end
  end
 end