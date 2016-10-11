require "date"
require "spec_helper"

describe ActiveSMS::Backend::Smsru do
  it "has a version number" do
    expect(ActiveSMS::Backend::SMSRU_VERSION).not_to be nil
  end

  context "api_id param during initialization" do
    it "raises argument error if it's not set" do
      expect { described_class.new }.to raise_exception(
        ArgumentError, "Your api_id is not set"
      )
    end

    it "raise argument error if token has invalid format" do
      expect { described_class.new(api_id: "wrongformat") }.to raise_exception(
        ArgumentError, "Your api_id has invalid format"
      )
    end
  end

  describe ".send_sms" do
    let(:api_id) { "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX" }
    subject { described_class.new api_id: api_id }

    let(:phone) { "+100000000" }
    let(:sms_text) { "sms text" }

    def api_response(api_code = 100, balance = nil, sms_id = nil)
      sms_id = (sms_id || "#{DateTime.now.strftime('%Y%d')}-10000#{rand(1..50)}")
      response = "#{api_code}\n"
      response += "#{sms_id}\nbalance=#{balance}\n" if api_code == 100
      response
    end

    context "with api response" do
      specify "code 100 - returns success" do
        stub_request(:post, "http://sms.ru/sms/send")
          .to_return(status: 200, body: api_response(100, 50.1))

        expect(subject.send_sms(phone, sms_text)).to be_success
      end

      specify "unknown code - returns failure" do
        stub_request(:post, "http://sms.ru/sms/send")
          .to_return(status: 200, body: api_response(99_999))

        expect(subject.send_sms(phone, sms_text)).to be_failed
      end
    end
  end
end
