require "rspec"

require_relative "account"

describe Account do
  let(:checking_number) {"3123456789"}
  let(:account) { Account.new(checking_number) }

  describe "#initialize" do
    context 'with valid input' do
      it 'account is instance of Account' do
        account.should be_an_instance_of Account
      end

      it 'account balance should be zero as default' do
        account.balance.should eq(0)
      end
    end

    context 'with invalid input' do
      it 'account should be 10 numbers' do
        expect { Account.new("345678") }.to raise_error(InvalidAccountNumberError)
      end

      it 'requires at least one argument' do
        expect { Account.new }.to raise_error(ArgumentError)
      end
    end
  end


  describe "#transactions" do
    context 'with valid transactions' do   
      it 'is an array' do
        account.transactions.class.should eq(Array)
      end
    end
  end

  describe "#balance" do
    context 'with valid transactions' do
      it 'returns zero as default' do
        account.balance.should eq(0)
      end

      it 'sums up the transactions' do
         account.stub(:transactions => [5, -10, 15])
         account.balance.should eq 10
      end
    end
  end

  describe "#account_number" do
    context 'returns a hidden account number' do
      it 'is an Account with the account number' do
        account.acct_number.should eq("******6789")
      end

      it 'length of account number is 10 digits long' do
        account.acct_number.length.should eq(10)
      end
    end
  end

  describe "deposit!" do
    context 'with a valid transaction' do
      it 'adds deposit to transactions' do
        account.deposit!(10)
        account.balance.should eq(10)
      end
    end

    context 'with an invalid transaction' do
      it 'does not allow a negative deposit' do
        expect {account.deposit!(-10)}.to raise_error(NegativeDepositError)
      end
    end
  end

  describe "#withdraw!" do
    context 'with a valid withdrawal' do
      let(:account) do
        account = Account.new(checking_number)
        account.stub(:transactions => [10])
        account
      end

      it 'subtracts positive number withdrawal from balance' do
        account.withdraw!(9)
        account.balance.should eq(1)
      end

      it 'subtracts negative number withdrawal from balance' do
        account.withdraw!(-9)
        account.balance.should eq(1)
      end

      it 'raises Overdraft error when greater than balance with negative' do
        expect {account.withdraw!(-11)}.to raise_error(OverdraftError)
      end

      it 'raises Overdraft error when greater than balance with positive' do
        expect {account.withdraw!(11)}.to raise_error(OverdraftError)
      end
    end
  end
end
