require "rails_helper"

RSpec.describe TasksController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  it "loads all of the tasks into @tasks" do
    Task.create!(description: 'task1', completed: false)
    Task.create!(description: 'task2', completed: false)
    get :index

    expect(response.body).to eq(Task.all.to_json)
  end

  describe "POST #create" do
    it "creates tasks with correct attributes" do
      tasks_count = Task.count
      post :create, "{\"description\":\"task1\",\"completed\":false}" 

      expect(response).to be_success
      expect(Task.count). to eq(tasks_count + 1)
      expect(response.body).to eq(Task.all.to_json)
    end
  end

  describe "POST #complete" do
    it "toggles the completion of the task" do
      Task.create!(description: 'task1', completed: false)
      post :complete, "{\"task_id\":#{Task.first.id}}"

      expect(Task.first.completed). to eq(true)
      expect(response.body).to eq(Task.all.to_json)
    end
  end

  describe "POST #toggle_all" do 
    it "toggles the completion of all the tasks" do
      Task.create!(description: 'task1', completed: false)
      Task.create!(description: 'task2', completed: false)
      Task.create!(description: 'task3', completed: false)
      post :toggle_all, "{\"toggle\":false}"

      expect(Task.all.map(&:completed)).to eq([true, true, true])
      expect(response.body).to eq(Task.all.to_json)
    end
  end

  describe "POST #update" do
    it "updates the description of a task" do
      Task.create!(description: 'task1', completed: false)
      put :update, "{\"task_id\":1,\"description\":\"new_task\"}"

      expect(Task.first.description).to eq("new_task")
      expect(response.body).to eq(Task.all.to_json)
    end
  end

  describe "DELETE #clear_completed" do
    it "deletes all the completed tasks" do
      Task.create!(description: 'task1', completed: false)
      Task.create!(description: 'task2', completed: true)
      Task.create!(description: 'task3', completed: true)
      delete :clear_completed 

      expect(Task.count).to eq(1)
      expect(response.body).to eq(Task.all.to_json)
    end
  end

  describe "DELETE #destroy" do
    it "deletes all the completed tasks" do
      Task.create!(description: 'task1', completed: false)
      Task.create!(description: 'task2', completed: true)
      delete :destroy, id: 1 

      expect(Task.count).to eq(1)
      expect(response.body).to eq(Task.all.to_json)
    end
  end
end
