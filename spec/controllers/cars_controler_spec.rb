require "rails_helper"

describe CarsController do
  shared_examples "show and index for cars" do
    describe "GET index" do
      it "renders index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "GET show" do
      let(:car) {FactoryBot.create(:car)}

      it "renders :show template" do
        get :show, params: { id: car }
        expect(response).to render_template(:show)
      end

      it "assigns specific car to @car" do
        get :show, params: { id: car }
        expect(assigns(:car)).to eq(car)
      end
    end
  end

  describe "guest user" do
    it_behaves_like "show and index for cars"

    describe "GET new" do
      it "redirects to root path" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    describe "POST create" do
      it "redirects to root path" do
        post :create, params: {car: FactoryBot.attributes_for(:car)}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET edit" do
      it "redirects to root path" do
        get :edit, params: {id: FactoryBot.create(:car)}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT update" do
      it "redirects to root path" do
        put :update, params: {id: FactoryBot.create(:car), car: FactoryBot.attributes_for(:car) }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects to root path" do
        delete :destroy, params: {id: FactoryBot.create(:car)}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "authenticated user" do
    let(:user) { FactoryBot.create(:user)}
    before do
      sign_in(user)
    end
    it_behaves_like "show and index for cars"

    describe "GET new " do
      it "renders :new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "assigns new Car to @car" do
        get :new
        expect(assigns(:car)).to be_a_new(Car)
      end
    end

    describe "POST create" do
      context "valid data" do
        let(:valid_data) {FactoryBot.attributes_for(:car)}

        it "redirects to cars#show" do
          post :create, params: {car: valid_data}
          expect(response).to redirect_to(car_path(assigns[:car]))
        end

        it "creates new car in database" do
          expect {post :create, params: {car: valid_data} }.to change(Car, :count).by(1)
        end
      end

      context "invalid data" do
        let(:invalid_data) {FactoryBot.attributes_for(:car, brand: '')}

        it "renders :new template" do
          post :create, params: {car: invalid_data }
          expect(response).to render_template(:new)
        end
        it "doesn't create new car in the database" do
          expect { post :create, params: {car: invalid_data } }.not_to change(Car, :count)
        end
      end
    end

    context "is not owner of the car" do
      describe "GET edit" do
        it "redirects to cars path" do
          get :edit, params: {id: FactoryBot.create(:car)}
          expect(response).to redirect_to(root_path)
        end

      describe "PUT update" do
        it "redirects to cars path" do
          put :update, params: {id: FactoryBot.create(:car), car: FactoryBot.attributes_for(:car) }
          expect(response).to redirect_to(root_path)
        end
      end
    end

      describe "DELETE destroy" do
        it "redirects to root path" do
          delete :destroy, params: {id: FactoryBot.create(:car)}
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context "is owner of the car" do
    let(:car) {FactoryBot.create(:car, user: user )}

      describe "GET edit" do
        it "renders edit template" do
          get :edit, params: { id: car }
          expect(response).to render_template(:edit)
        end

        it "assigns the requested car to template" do
          get :edit, params: { id: car }
          expect(assigns(:car)).to eq(car)
        end
      end

      describe "PUT update" do
        context "invalid data" do
          let(:invalid_data) {FactoryBot.attributes_for(:car, brand: "", model: "A44")}
          it "renders :edit template" do
            put :update, params: { id: car, car: invalid_data }
            expect(response).to render_template(:edit)
          end

          it "doesn't update values in db" do
            put :update, params: { id: car, car: invalid_data}
            car.reload
            expect(car.model).not_to eq("A44")
          end
        end

        context "valid data" do
          let(:valid_data) {FactoryBot.attributes_for(:car, brand: "VW")}
          it "redirects to car path" do
            put :update, params: { id: car, car: valid_data }
            expect(response).to redirect_to(car_path)
          end

          it "updates values in db" do
            put :update, params: { id: car, car: valid_data }
            car.reload
            expect(car.brand).to eq("VW")
          end
        end
      end

      describe "DELETE destroy" do
        it "redirects to car#index" do
          delete :destroy, params: { id: car }
          expect(response).to redirect_to(cars_path)
        end

        it "deletes from database" do
          delete :destroy, params: { id: car }
          expect(Car.exists?(car.id)).to be_falsy
        end
      end
    end
  end
end
