# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Shwagr::Application.initialize!

WillPaginate::ViewHelpers.pagination_options[:prev_label] = 'Prev'
WillPaginate::ViewHelpers.pagination_options[:next_label] = 'Next'