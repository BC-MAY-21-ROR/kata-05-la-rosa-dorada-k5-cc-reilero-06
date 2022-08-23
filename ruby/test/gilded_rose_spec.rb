require_relative '../app/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
  things = [
        Item.new(name="Aged Brie", sell_in=2, quality=0),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=1, quality=50),
        Item.new(name="White Wine", sell_in=0, quality=10),
        Item.new(name="Magic Computer", sell_in=1, quality=0),
        Item.new(name="Conjured Mana Cake", sell_in=3, quality=6),
        Item.new(name="Conjured Mana Cake", sell_in=0, quality=6)
      ]
    before(:all) do
      GildedRose.new(things).update_quality
    end

    it '"Sulfuras", being a legendary item, never has to be sold or decreases in Quality' do# HighComplexity
      items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=10, quality=80)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[0].sell_in).to eq 10
      expect(items[0].quality).to eq 80
    end
 
    it '"Backstage passes", increment quality on sellin left but decrese to 0 when sell_in is 0 ' do # HighComplexity
      items = [
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=20),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=20),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=0, quality=20)
      ]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 21
      expect(items[1].quality).to eq 22
      expect(items[2].quality).to eq 23
      expect(items[3].quality).to eq 0
    end

    it "Aged Brie's quality always increases" do
      expect(things[0].quality).to eq 1
    end

    it "The Quality of an item is never more than 50" do
      expect(things[1].quality).to eq 50
    end

    it "Once the sell by date has passed, Quality degrades twice as fast" do
      expect(things[2].quality).to eq 8
    end

    it "The Quality of an item is never negative" do
      expect(things[3].quality).to eq 0
    end

    it '"Conjured" items degrade in Quality twice as fast as normal items' do 
      expect(things[4].quality).to eq 4
    end

    it '"Conjured" items with the sell date passed degrade in Quality twice as fast as normal items' do 
      expect(things[5].quality).to eq 2
    end
    
  end

end
