shared_examples "note validations" do
  context "validations" do
    context "length" do
      it { should validate_length_of(:body).is_at_most(1000) }
      it { should validate_length_of(:title).is_at_most(30) }

      context "when private" do
        it "should validate a password is at least 6 characters long" do
          allow(subject).to receive(:private?).and_return(true)

          should validate_length_of(:password).is_at_least(6)
        end
      end

      context "when public" do
        it "should not validate a password is at least 6 characters long" do
          allow(subject).to receive(:private?).and_return(false)

          should_not validate_length_of(:password).is_at_least(6)
        end
      end
    end

    context "presence" do
      it { should validate_presence_of(:user_id) }

      context "when body and title are missing" do
        it " should validate a title is present" do
          allow(subject).to receive(:body).and_return(nil)
          allow(subject).to receive(:title).and_return(nil)

          should validate_presence_of(:title)
        end
      end

      context "when private" do
        it "should validate a password is present" do
          allow(subject).to receive(:private?).and_return(true)

          should validate_presence_of(:password)
        end
      end

      context "when public" do
        it "should not validate a password is present" do
          allow(subject).to receive(:private?).and_return(false)

          should_not validate_presence_of(:password)
        end
      end
    end
  end
end
