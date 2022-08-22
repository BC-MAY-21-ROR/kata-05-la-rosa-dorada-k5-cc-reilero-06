class GildedRose

  def initialize(items)
    @items = items
  end

  def normal_item(item)
    item.sell_in -= 1 
    if check_quality(item.quality)
      item.quality -= reduce_quality(item.sell_in)
    end
  end
  def conjured_item(item)
    item.sell_in -= 1 #if item.sell_in > 0
    if check_quality(item.quality)
      item.quality -= reduce_quality(item.sell_in)*2
    end
  end
  def reduce_quality(days)
    days <= 0 ? 2 : 1
  end

  def check_quality(quality)
    quality > 0
  end

  def compare_sell_in(days)
    return 1 if days.between?(6, 10)
    return 2 if days < 6
  end

  def update_quality()
    special = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros","Conjured Mana Cake"]
    @items.each do |item|
      case item.name
      when /Aged/
        #aged_item(item)
      when /Backstage/
        #backstage_item(item)
      when /Sulfuras/
      when /Conjured/
        conjured_item(item)
      else
        normal_item(item)
      end
=begin
      if !special.include? item.name
        if item.quality > 0
          item.quality = item.quality - 1
        end
      else
        if item.quality < 50 && item.name !=special[3]
          item.quality = item.quality + 1
          if item.name == special[1]
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0 && item.name != "Sulfuras, Hand of Ragnaros" && item.name != "Conjured Mana Cake"
              item.quality = item.quality - 1
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
      conjured_item(item) if item.name == special[3]
    end
=end
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
