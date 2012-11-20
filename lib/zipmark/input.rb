# Plans to support  the following input types:
# checkbox
# date
# datetime
# email
# month
# number
# password
# radio
# range
# search
# tel
# text
# time
# url
# week
module Zipmark
  class Input
    attr_accessor :type, :required, :name, :placeholder, :value
  end
end
