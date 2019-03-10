require "rails_helper"

describe CarPolicy do
  subject {described_class.new(user, car)}
  let(:car) {FactoryBot.create(:car)}

  context "not signed in" do
    let(:user) {nil}
    it {is_expected.to permit_action(:index)}
    it {is_expected.to permit_action(:show)}
    it "does not allow to create" do
      expect { Pundit.authorize(user, car, :create?) }.to raise_error(Pundit::NotAuthorizedError)
    end
    it "does not allow to update" do
      expect { Pundit.authorize(user, car, :update?) }.to raise_error(Pundit::NotAuthorizedError)
    end
    it "does not allow to destroy" do
      expect { Pundit.authorize(user, car, :destroy?) }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context "signed in" do
    let (:user) {FactoryBot.create(:user)}
    before(:each) {
      user.cars << car
    }
    it {is_expected.to permit_action(:index)}
    it {is_expected.to permit_action(:show)}
    it {is_expected.to permit_action(:new)}
    it {is_expected.to permit_action(:create)}
    it {is_expected.to permit_action(:update)}
    it {is_expected.to permit_action(:destroy)}
  end

end
