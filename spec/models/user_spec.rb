# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string
#  email             :string
#  password_digest   :string
#  avatar            :text
#  guess_count       :integer          default("0")
#  is_admin          :boolean          default("false")
#  provider          :string
#  uid               :string
#  oauth_token       :string
#  oauth_expires_at  :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  remember_digest   :string
#  activation_digest :string
#  activated         :boolean          default("false")
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
