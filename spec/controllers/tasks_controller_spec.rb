require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  context "when user logged in" do

    let(:user) { FactoryGirl.create(:user) }
    let(:anonymous) { FactoryGirl.create(:user, email: 'anonymous@gmail.com') }

    before { sign_in(user) }

    describe "GET #index" do
      it "should return OK" do
        get :index
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "return current users task as json" do
        task1, task2 = FactoryGirl.create(:task, user: user), FactoryGirl.create(:task, user: user)
        get :index
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(2)
        expect(json_response).to eq([task1, task2].as_json(:except => [:created_at, :updated_at]))
      end
    end

    describe "#create" do
      it "should return OK" do
        post :create, task: {title: 'Test Title', description: "Test description", user_id: user.id}
        expect(response.status).to eq(201)
      end

      it "should create new task" do
        expect {
          post :create, task: {title: 'Test Title', description: "Test description", user_id: user.id}
        }.to change(Task, :count).by(1)
      end

      it "should return json of the just created record" do
        post :create, task: {title: 'Test Title', description: "Test description", user_id: user.id}
        json_response = JSON.parse(response.body, :symbolize_names => true)
        expect(json_response[:completed]).to eq(false)
        expect(json_response[:title]).to eq("Test Title")
        expect(json_response[:description]).to eq("Test description")
      end

      it "raise error, while title missing" do
        expect {
          post :create, task: {title: nil, description: "Test description", user_id: user.id}
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end


    describe "#update" do
      let(:task) { FactoryGirl.create(:task, user: user) }

      it "should return OK" do
        patch :update, id: task.id, task: {completed: true}
        expect(response.status).to eq(204)
      end

      it "should update the given task" do
        patch :update, id: task.id, task: {title: "New title", completed: true}
        task.reload
        expect(task.completed).to eq(true)
        expect(task.title).to eq("New title")
      end

      it "raise error, with unknown id" do
        expect {
          patch :update, id: 0, task: {completed: true}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "anonymous can't mange other tasks" do
        task = FactoryGirl.create(:task, user: anonymous)

        patch :update, id: task.id, task: {completed: true}
        expect(response.status).to eq(302)
        expect(task.completed).to eq(false)
      end

    end


    describe "#destroy" do
      let(:task) { FactoryGirl.create(:task, user: user) }

      it "should return OK" do
        delete :destroy, id: task.id
        expect(response.status).to eq(204)
      end

      it "should delete record" do
        delete :destroy, id: task.id
        expect { task.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "anonymous can't mange other tasks" do
        task = FactoryGirl.create(:task, user: anonymous)

        delete :destroy, id: task.id
        expect(response.status).to eq(302)
      end
    end

  end
end
