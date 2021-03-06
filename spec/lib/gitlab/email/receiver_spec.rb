# frozen_string_literal: true

require 'spec_helper'

describe Gitlab::Email::Receiver do
  include_context :email_shared_context

  context "when the email contains a valid email address in a Delivered-To header" do
    let(:email_raw) { fixture_file('emails/forwarded_new_issue.eml') }
    let(:handler) { double(:handler) }

    before do
      stub_incoming_email_setting(enabled: true, address: "incoming+%{key}@appmail.adventuretime.ooo")

      allow(handler).to receive(:execute)
      allow(handler).to receive(:metrics_params)
    end

    it "finds the mail key" do
      expect(Gitlab::Email::Handler).to receive(:for).with(an_instance_of(Mail::Message), 'gitlabhq/gitlabhq+auth_token').and_return(handler)

      receiver.execute
    end
  end

  context "when we cannot find a capable handler" do
    let(:email_raw) { fixture_file('emails/valid_reply.eml').gsub(mail_key, "!!!") }

    it "raises an UnknownIncomingEmail error" do
      expect { receiver.execute }.to raise_error(Gitlab::Email::UnknownIncomingEmail)
    end
  end

  context "when the email is blank" do
    let(:email_raw) { "" }

    it "raises an EmptyEmailError" do
      expect { receiver.execute }.to raise_error(Gitlab::Email::EmptyEmailError)
    end
  end

  context "when the email was auto generated" do
    let(:email_raw) { fixture_file("emails/auto_reply.eml") }

    it "raises an AutoGeneratedEmailError" do
      expect { receiver.execute }.to raise_error(Gitlab::Email::AutoGeneratedEmailError)
    end
  end
end
