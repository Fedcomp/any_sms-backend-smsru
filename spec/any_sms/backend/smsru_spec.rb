require "date"
require "spec_helper"

describe AnySMS::Backend::Smsru do
  it "has a version number" do
    expect(AnySMS::Backend::SMSRU_VERSION).not_to be nil
  end

  describe ".new" do
    context "api_id:" do
      it "raise argument error if it's not set" do
        expect { described_class.new(api_id: nil) }
          .to raise_error(ArgumentError, "Your api_id is not set")
      end

      it "raise argument error if invalid format" do
        expect { described_class.new(api_id: "wrongformat") }
          .to raise_error(ArgumentError, "Your api_id has invalid format")
      end
    end
  end

  describe "#send_sms" do
    let(:api_id) { "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX" }
    subject(:instance) { described_class.new api_id: api_id }

    let(:phone) { "+100000000" }
    let(:sms_text) { "sms text" }

    def api_response(api_code = 100, balance = nil, sms_id = nil)
      sms_id = (sms_id || "#{Time.now.strftime('%Y%d')}-10000#{rand(1..50)}")
      response = "#{api_code}\n"
      response += "#{sms_id}\nbalance=#{balance}\n" if api_code == 100
      response
    end

    context "response" do
      specify "with code 100 == success" do
        stub_request(:post, "http://sms.ru/sms/send")
          .to_return(status: 200, body: api_response(100, 50.1))

        expect(subject.send_sms(phone, sms_text)).to be_success
      end

      context "with unknown code" do
        let(:unknown_code) { 99_999 }
        subject { instance.send_sms(phone, sms_text) }

        before do
          stub_request(:post, "http://sms.ru/sms/send")
            .to_return(status: 200, body: api_response(unknown_code))
        end

        it "is failed?" do
          expect(subject).to be_failed
        end

        it "hold error code in .meta[:error]" do
          expect(subject.meta[:error]).to eq("Error, code: #{unknown_code}")
        end

        specify ".status is unhandled_status_:code" do
          expect(subject.status).to eq("unhandled_status_#{unknown_code}".to_sym)
        end
      end
    end

    context "on runtime error" do
      let(:exception) { StandardError.new("Whatever could happen") }

      before do
        expect(instance).to receive(:request_api) do
          raise exception
        end
      end

      subject { instance.send_sms(phone, sms_text) }

      it "return :runtime_error status" do
        expect(subject.status).to eq(:runtime_error)
      end

      it "is failed?" do
        expect(subject).to be_failed
      end

      it "hold the exception object" do
        expect(subject.meta[:error]).to be(exception)
      end
    end
  end
end
