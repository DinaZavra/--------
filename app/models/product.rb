class Product < ActiveRecord::Base
default_scope :order => 'title'
has_many :line_items
before_destroy :ensure_not_referenced_by_any_line_item
# ensure that there are no line items referencing this product
def ensure_not_referenced_by_any_line_item
	if line_items.count.zero?
		return true
	else
		errors.add(:base, 'Line item present')
		return false
	end
end
validates :title, :description, :presence =>true
validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
validates :title, :uniqueness => true
end
