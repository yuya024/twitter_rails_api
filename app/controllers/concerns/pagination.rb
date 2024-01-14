# frozen_string_literal: true

module Pagination
  private

  def resources_with_pagination(resources)
    {
      current: resources.current_page,
      previous: resources.prev_page,
      next: resources.next_page,
      limit_value: resources.limit_value,
      pages: resources.total_pages
    }
  end
end
