$: << File.expand_path(File.dirname(__FILE__) + '/..')
$: << File.expand_path(File.dirname(__FILE__) + '/../app')

Rspec::Matchers.define :have_card do |card_str|
  match do |cards|
    cards.map {|c| "#{c.name} #{c.value}"}.should include(card_str)
  end
end
