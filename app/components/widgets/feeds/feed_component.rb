class Widgets::Feeds::FeedComponent < ApplicationComponent
  attr_reader :feed
  delegate :kind, to: :feed

  def initialize(feed)
    @feed = feed
  end

  def see_all_path
    polymorphic_path(feed.items.model, filters)
  end

  private

    def item_component_class
      case kind
      when "proposals"
        Widgets::Feeds::ProposalComponent
      when "debates"
        Widgets::Feeds::DebateComponent
      when "processes"
        Widgets::Feeds::ProcessComponent
      end
    end

    def filters
      if feed.respond_to?(:goal) && kind != "processes"
        { advanced_search: { goal: feed.goal.code }}
      else
        {}
      end
    end
end
