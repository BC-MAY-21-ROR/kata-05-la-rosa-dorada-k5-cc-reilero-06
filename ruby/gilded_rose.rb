class GildedRose

  def initialize(items) #we define the initialize and it recives the items
    @items = items
  end

  def normal_item(item) #method that applies the rules to normal items
    item.sell_in -= 1 
    if normal_check_quality(item.quality)
      item.quality -= reduce_quality(item.sell_in)
    end
  end

  def conjured_item(item) #method that appplies the rules to conjured items
    item.sell_in -= 1 #if item.sell_in > 0
    if special_check_quality(item.quality)
      item.quality -= reduce_quality(item.sell_in)*2
    end
  end


  def reduce_quality(days) #method that reduces the quality of the items
    days <= 0 ? 2 : 1
  end

  def normal_check_quality(quality) #method that check that the quality is more than 1 
    quality > 0 and quality < 50
  end

  def special_check_quality(quality) #method that check that the quality is more than 1 
    quality >= 0 and quality < 50
  end

  def compare_sell_in(days, quality) #method that belongs to items Backstage
    return 0 if days <=0
    return quality + 2 if days.between?(6, 10)
    return quality + 3 if days < 6
    return quality + 1
  end

  def aged_item(item) #method that belongs to items Aged Brie
    item.sell_in -= 1
    if special_check_quality(item.quality)
      item.quality += reduce_quality(item.sell_in)
    end
  end 

  def backstage_item(item) #method that belongs to items Backstage
    item.sell_in -= 1
    if special_check_quality(item.quality)
      item.quality = compare_sell_in(item.sell_in, item.quality)
    end
  end

  def update_quality()
    special = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros","Conjured Mana Cake"]
    @items.each do |item|
      case item.name
      when /Aged/
        aged_item(item)
      when /Backstage/
        backstage_item(item)
      when /Sulfuras/
      when /Conjured/
        conjured_item(item)
      else
        normal_item(item)
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
