require_relative '../app/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it '"Sulfuras", being a legendary item, never has to be sold or decreases in Quality' do# HighComplexity
      expect_value = [10,80]
      items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=10, quality=80)]
      GildedRose.new(items).update_quality()
      return_value = [items[0].sell_in, items[0].quality]
      expect(return_value).to eq expect_value
    end
 
    it '"Backstage passes", increment quality on sellin left but decrese to 0 when sell_in is 0 ' do # HighComplexity
      items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)]
      days=[15,10,5,0]
      quality_return=days.map do |day|
        items[0].sell_in=day
        GildedRose.new(items).update_quality()
        items[0].quality
      end
      expect(quality_return).to eq [21,23,26,0]
    end

    it "Aged Brie actually increases in Quality the older it gets" do # HighComplexity
      items = [
        Item.new(name="Aged Brie", sell_in=2, quality=0),
        Item.new(name="Aged Brie", sell_in=0, quality=0)
      ]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
      expect(items[1].quality).to eq 2
    end

    it "The Quality of an item is never more than 50" do
      items = [Item.new(name="Aged Brie", sell_in=2, quality=50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "Once the sell by date has passed, Quality degrades twice as fast" do
      items = [Item.new(name="foo", sell_in=0, quality=10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "The Quality of an item is never negative" do
      items = [Item.new(name="foo", sell_in=0, quality=0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it '"Conjured" items degrade in Quality twice as fast as normal items' do # HighComplexity
      items = [Item.new(name="Conjured Mana Cake", sell_in=3, quality=6)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 4
      items[0].sell_in=0
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
    
  end

end
