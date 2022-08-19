require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it '"Sulfuras", being a legendary item, never has to be sold or decreases in Quality' do
      items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=10, quality=80)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Sulfuras, Hand of Ragnaros"
      expect(items[0].sell_in).to eq 10
      expect(items[0].quality).to eq 80
    end

    it '"Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
    Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
    Quality drops to 0 after the concert' do
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
    # it "does not change the name" do
    #   items = [Item.new("foo", 0, 0)]
    #   GildedRose.new(items).update_quality()
    #   expect(items[0].name).to eq "fixme"
    # end
    # it "does not change the name" do
    #   items = [Item.new("foo", 0, 0)]
    #   GildedRose.new(items).update_quality()
    #   expect(items[0].name).to eq "fixme"
    # end
    # it "does not change the name" do
    #   items = [Item.new("foo", 0, 0)]
    #   GildedRose.new(items).update_quality()
    #   expect(items[0].name).to eq "fixme"
    # end
  end

end
