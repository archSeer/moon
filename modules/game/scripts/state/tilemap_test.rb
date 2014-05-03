#
# core/state/tilemap_test.rb
#
class State::TilemapTest < State

  ##
  # init
  def init
    super
    # 20 x 15 datamap: this is scary as F***
    layer1 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,13,13,13,13,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              13,13,13,13,13,13,13,13,0,0,0,0,0,0,0,0,0,0,0,0,
              13,13,13,13,13,13,13,13,13,0,0,0,0,0,0,0,0,0,0,0,
              13,645,887,887,887,887,675,13,13,13,13,13,13,13,13,0,0,0,0,0,
              13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,0,0,0,0,
              13,13,13,13,13,13,13,645,887,887,887,675,645,675,13,13,80,49,49,49,
              109,109,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,79,79,79,
              15,15,108,109,13,13,13,13,13,13,13,13,13,13,13,13,13,80,79,79,
              19,20,18,107,108,109,13,13,13,13,13,13,828,829,675,13,13,80,79,79,
              79,79,139,137,18,15,108,109,13,13,13,13,858,860,13,13,13,110,79,79,
              79,79,79,79,139,167,18,15,108,13,13,13,889,890,13,13,110,140,79,79]
    layer2 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,75,76,49,77,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              48,0,703,704,705,49,49,77,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,733,734,735,0,0,0,77,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,138,0,0,0,49,49,49,49,49,50,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,134,0,0,0,0,50,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,
              703,704,705,0,73,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              733,734,735,135,0,0,0,0,0,0,0,0,0,0,0,74,135,50,0,0,
              0,16,0,0,0,0,0,703,704,705,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,134,733,734,735,0,0,0,0,0,0,0,0,823,824,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    layer3 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,493,649,650,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,523,525,740,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,767,768,770,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,798,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              493,495,496,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              523,554,586,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              767,768,770,0,0,0,0,493,649,650,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,523,525,740,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,767,768,770,0,0,0,0,0,0,0,0,793,794,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    layers = [layer1, layer2, layer3]
    @tilemap  = Tilemap.new
    @map_data = DataMatrix.new(20, 15, layers.size) #((Screen.width / 32).to_i, (Screen.height / 32).to_i, 3)
    @tileset  = Moon::Spritesheet.new("resources/hyptosis_tile-art-batch-1.png", 32, 32)
    @map_data.map_with_xyz do |n, x, y, z|
      layer = layers[z]
      # tiled spits out map data, that has its index +1, so we need to
      # subtract 1 from it to get the needed index.
      layer[x + y * @map_data.xsize] - 1
    end
    @tilemap.data = @map_data
    @tilemap.tileset = @tileset
    puts "map_data->sizes = [#{@map_data.xsize}, #{@map_data.ysize}, #{@map_data.zsize}]"
  end

  def render
    super
    @tilemap.render(0, 0, 0)
  end

  def update(delta)
    # nothing to do here folks, move along
    super delta
  end

end
# TODO:
# Spritesheet#cols -> returns the total number of columns in the Spritesheet
# Spritesheet#rows -> returns the total number of rows in the Spritesheet
# Spritesheet#size -> returns the total number of cells in the Spritesheet (or just #cols * #rows)

# notes:
#   @map_data.map_with_xyz { |n, x, y, z| rand(16 * 16) }
#     60 fps with only data loop
#     26 fps with data loop rendering
#
#   @map_data using the large dataset up thar:
#     60 fps with only data loop
#     51 fps with data loop rendering