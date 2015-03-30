require 'rails_helper'

RSpec.describe Term, :type => :model do
  it "should have many jobs" do
    expect(Term.reflect_on_association(:jobs).macro).to eq(:has_many)
  end

  it "should respond to label" do
    @term = FactoryGirl.create(:term)
    expect(@term).to respond_to(:label)
  end

  it "should respond to position" do
    @term = FactoryGirl.create(:term)
    expect(@term).to respond_to(:position)
  end

  it "must have a label" do
    @term = FactoryGirl.build(:term, label: nil)
    expect(@term).to be_invalid
  end

  it "must be assigned a position" do
    @term = FactoryGirl.create(:term)
    expect(@term.position).to_not be_nil
  end

  describe "destroy_and_reassign_jobs" do
    context "on a specified term" do
      before(:each) do
        @user = FactoryGirl.create(:user_with_jobs)
        @user.jobs.first.term.destroy_and_reassign_jobs
      end

      it "destroys the term" do
        expect(Term.find_by(label: "Term")).to be_nil
      end

      it "reassigns the the jobs' term" do
        expect(@user.jobs.first.term.label).to eql("Unspecified")
      end
    end

    context "on an unspecified term with no jobs" do
      before(:each) do
        @term = FactoryGirl.create(:term, label: "Unspecified")
        @term.destroy_and_reassign_jobs
      end

      it "destroys the term" do
        expect(Term.find_by(label: "Unspecified")).to be_nil
      end
    end

    context "on an unspecified term with jobs" do
      before(:each) do
        @term = FactoryGirl.create(:term, label: "Unspecified")
        @job = FactoryGirl.create(:job, term: @term)
        @term.destroy_and_reassign_jobs
      end

      it "does not destroy the term" do
        expect(Term.find_by(label: "Unspecified")).to_not be_nil
      end
    end
  end

  describe "reposition" do
    before(:each) do
      @term_1 = FactoryGirl.create(:term, id: 1, position: 1)
      @term_2 = FactoryGirl.create(:term, id: 2, position: 2)
      @term_3 = FactoryGirl.create(:term, id: 3, position: 3)
    end

    it "repositions the terms" do
      Term.reposition({1=>3, 2=>1, 3=>2})
      expect(Term.find(1).position).to eql(3)
      expect(Term.find(2).position).to eql(1)
      expect(Term.find(3).position).to eql(2)
    end

    it "sorts by the new positions" do
      Term.reposition({1=>3, 2=>1, 3=>2})
      expect(Term.first.id).to eql(2)
      expect(Term.last.id).to eql(1)
    end

    it "assigns the lowest possible integers while maintaining order" do
      Term.reposition({1=>9, 2=>4, 3=>7})
      expect(Term.find(1).position).to eql(3)
      expect(Term.find(2).position).to eql(1)
      expect(Term.find(3).position).to eql(2)
    end

    it "ignores ids for terms that don't exist" do
      Term.reposition({1=>9, 2=>4, 3=>7, 4=>3, 5=>2, 6=>1})
      expect(Term.find(1).position).to eql(3)
      expect(Term.find(2).position).to eql(1)
      expect(Term.find(3).position).to eql(2)
    end

    it "won't let multiple terms occupy the same position" do
      expect(Term.reposition({1=>4, 2=>4, 3=>3})).to eql(false)
    end
  end

  describe "refresh_positions" do
    before(:each) do
      @term_1 = FactoryGirl.create(:term, id: 1, position: 1)
      @term_2 = FactoryGirl.create(:term, id: 2, position: 2)
      @term_3 = FactoryGirl.create(:term, id: 3, position: 3)
    end
    
    it "assigns the lowest possible integers while maintaining order" do
      @term_2.destroy
      Term.refresh_positions
      expect(Term.find(1).position).to eql(1)
      expect(Term.find(3).position).to eql(2)
    end
  end
end
