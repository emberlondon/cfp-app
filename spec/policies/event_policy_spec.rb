require 'rails_helper'

RSpec.describe EventPolicy do

  let(:reviewer) { create(:user, :reviewer) }
  let(:program_team) { create(:user, :program_team) }
  let(:organizer) { create(:organizer) }
  let(:admin) { create(:admin) }
  let(:event) { create(:event) }

  subject { described_class }

  permissions :edit?, :update?, :destroy? do
    it 'denies reviewer users' do
      expect(subject).not_to permit(reviewer, event)
    end

    it 'denies program team users' do
      expect(subject).not_to permit(program_team, event)
    end

    it 'allows admin users' do
      expect(subject).to permit(admin, event)
    end

    it 'allows organizer users' do
      org_event = organizer.organizer_events.first
      expect(subject).to permit(organizer, org_event)
    end

  end

  permissions :create? do
    it 'denies reviewer users' do
      expect(subject).not_to permit(reviewer, event)
    end

    it 'denies program team users' do
      expect(subject).not_to permit(program_team, event)
    end
    it 'denies organizer users' do
      org_event = organizer.organizer_events.first
      expect(subject).to_not permit(organizer, org_event)
    end

    it 'allows admin users' do
      expect(subject).to permit(admin, event)
    end

  end

  permissions :show? do
    it 'allows reviewer users' do
      expect(subject).to permit(reviewer, event)
    end

    it 'allows program team users' do
      expect(subject).to permit(program_team, event)
    end

    it 'allows admin users' do
      expect(subject).to permit(admin, event)
    end

    it 'allows organizer users' do
      org_event = organizer.organizer_events.first
      expect(subject).to permit(organizer, org_event)
    end

  end

end
