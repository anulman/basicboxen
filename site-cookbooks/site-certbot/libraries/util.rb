# h/t @fratcliffe
# https://github.com/inviqa/chef-certbot/blob/8c7a1df99d8ec5d351c142dfe42ad1f910fa257a/libraries/util.rb

module Certbot
  module Util
    extend self

    def self_signed_certificate?(certfile)
      return false if !::File.exist?(certfile)

      command_base = "openssl x509 -in #{certfile}"

      issuer = Mixlib::ShellOut.new("#{command_base} -issuer -noout")
        .run_command
        .stdout
        .sub(/^issuer=/, '')

      subject = Mixlib::ShellOut.new("#{command_base} -subject -noout")
        .run_command
        .stdout
        .sub(/^subject=/, '')

      issuer == subject
    end
  end
end
