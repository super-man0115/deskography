require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    access_count_to_reset_password_page: Field::Number,
    authentications: Field::HasMany,
    avatar_attachment: Field::HasOne,
    avatar_blob: Field::HasOne,
    bookmark_posts: Field::HasMany,
    bookmarks: Field::HasMany,
    comment_bookmark_users: Field::HasMany,
    comment_bookmarks: Field::HasMany,
    comments: Field::HasMany,
    crypted_password: Field::String,
    email: Field::String,
    items: Field::HasMany,
    posts: Field::HasMany,
    reset_password_email_sent_at: Field::DateTime,
    reset_password_token: Field::String,
    reset_password_token_expires_at: Field::DateTime,
    salt: Field::String,
    user_items: Field::HasMany,
    user_name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    access_count_to_reset_password_page
    authentications
    avatar_attachment
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    access_count_to_reset_password_page
    authentications
    avatar_attachment
    avatar_blob
    bookmark_posts
    bookmarks
    comment_bookmark_users
    comment_bookmarks
    comments
    crypted_password
    email
    items
    posts
    reset_password_email_sent_at
    reset_password_token
    reset_password_token_expires_at
    salt
    user_items
    user_name
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    access_count_to_reset_password_page
    authentications
    avatar_attachment
    avatar_blob
    bookmark_posts
    bookmarks
    comment_bookmark_users
    comment_bookmarks
    comments
    crypted_password
    email
    items
    posts
    reset_password_email_sent_at
    reset_password_token
    reset_password_token_expires_at
    salt
    user_items
    user_name
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
