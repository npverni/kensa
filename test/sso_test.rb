require 'test/helper'

class SsoCheckTest < Test::Unit::TestCase
  include Heroku::Kensa

  setup do
    @data = Manifest.skeleton.merge(:id => 1)
    @data['api']['test'] = 'http://localhost:4567/'
    @data['api']['sso_salt'] = 'SSO_SALT'
  end

  context 'sso' do
    setup    { @sso = Sso.new @data }
    teardown { Timecop.return }

    test 'builds path' do
      assert_equal '/heroku/resources/1', @sso.path
    end

    test 'builds full url' do
      Timecop.freeze Time.utc(2010, 1)
      expected = 'http://localhost:4567/heroku/resources/1?token=b6010f6fbb850887a396c2bc0ab23974003008f6&timestamp=1262304000'

      assert_equal expected, @sso.full_url
    end
  end
end
