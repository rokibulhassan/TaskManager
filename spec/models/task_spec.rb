require 'rails_helper'

RSpec.describe Task, type: :model do
  context "with valid data" do
    subject(:task) { FactoryGirl.create(:task) }

    it 'should create task' do
      expect(task.class).to eq(Task)
    end

    it 'task should be incomplete as default' do
      expect(task.completed).to eq(false)
    end

    it 'should return expected data' do
      expect(task.title).to eq('Lorem Ipsum is simply dummy text')
      expect(task.description).to eq('Contrary to popular belief, Lorem Ipsum is not simply random text.')
    end
  end

  context "with invalid data" do
    subject(:task) { FactoryGirl.build(:task, title: nil) }

    it 'raise error, title should be present' do
      expect { task.save! }.to raise_error("Validation failed: Title can't be blank")
    end
  end

  describe '#complete!' do
    subject(:task) { FactoryGirl.create(:task) }

    before { task.complete! }

    it 'returns completed true' do
      expect(task.completed).to eq(true)
    end
  end
end
