require "rspec"

require_relative "account"

describe Account do
  let(:checking_number) {"3123456789"}
  let(:account) { Account.new(checking_number) }

  describe "#initialize" do
    context 'with valid input' do
      it 'requires at least one argument' do
        expect { Account.new }.to raise_error(ArgumentError)
      end

      it 'creates an Account with the account number' do
        account.acct_number.should eq("******6789")
      end

      it 'account is instance of Account' do
        account.should be_an_instance_of Account
      end

    end



  end

  describe "#transactions" do

  end

  describe "#balance" do

  end

  describe "#account_number" do

  end

  describe "deposit!" do

  end

  describe "#withdraw!" do

  end
end
