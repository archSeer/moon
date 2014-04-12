#
# moon/core/tilemap.rb
#
# This may need to be rewritten in C/++
class Tilemap

  module DataFlag

    NONE            = 0        # 0000 0000 # no flag
    # up and down offsets will conflict, left and right offsets will conflict
    OFF_UP          = 16       # 0001 0000 # enable offset up
    OFF_LEFT        = 32       # 0010 0000 # enable offset left
    OFF_RIGHT       = 64       # 0100 0000 # enable offset right
    OFF_DOWN        = 128      # 1000 0000 # enable offset down
    # note that offset will overwrite each other
    QUART_OFF_TILE  = 1        # 0000 0001 # enable quater offset
    HALF_OFF_TILE   = 1|2      # 0000 0011 # enable half offset
    TQUART_OFF_TILE = 1|2|4    # 0000 0111 # enable 3/4 offset
    FULL_OFF_TILE   = 1|2|4|8  # 0000 1111 # enable full offset

  end

  attr_accessor :tileset    # Spritesheet
  attr_accessor :data       # DataMatrix
  attr_accessor :flags      # DataMatrix
  attr_accessor :data_zmap  # DataMatrix
  attr_accessor :repeat_map # Boolean
  attr_accessor :view       # Cuboid
  attr_accessor :position   # Vector3

  ##
  # initialize
  def initialize
    @tileset    = nil
    @data       = nil
    @flags      = nil
    @data_zmap  = nil
    @repeat_map = false
    @view       = nil
    @position   = Vector3.new(0, 0, 0)
    yield self if block_given?
  end

  ###
  # render(int x, int y, int z, int ox, int oy, int width, int height)
  #   (x), (y), (z)
  #     is the position (in pixels), for the Tilemap to be rendered
  #   (ox), (oy), (oz)
  #     is the data offset (where should the Tilemap#data start from)
  #   (width), (height), (layers)
  #     is the number of cells to render, and the number of layers to be rendered
  ###
  def render(x, y, z)
    return unless @data
    return unless @tileset

    cell_width  = @tileset.cell_width
    cell_height = @tileset.cell_height

    dox = 0
    doy = 0
    doz = 0
    width = @data.xsize
    height = @data.ysize
    layers = @data.zsize

    dox, doy, doz, width, height, layers = *@view if @view

    px, py, pz = *@position

    # we loop by layer
    layers.times do |l|

      dz = l + doz # offset data z index
      if @repeat_map
        dz %= @data.zsize
      else
        next if dz < 0 || dz >= @data.zsize
      end

      # and then by row
      height.times do |i|

        dy = i + doy # offset data y index
        if @repeat_map
          dy %= @data.ysize
        else
          next if dy < 0 || dy >= @data.ysize
        end

        # and then render by cell
        width.times do |j|

          dx = j + dox # offset data x index
          if @repeat_map
            dx %= @data.xsize
          else
            next if dx < 0 || dx >= @data.xsize
          end

          tile_id = @data[dx, dy, dz]
          # if -1 or less, then its a negative tile
          # and therefore should not be rendered
          next if tile_id < 0

          zm = @data_zmap ? @data_zmap[dx, dy, dz] : 0
          flag = @flags ? @flags[dx, dy, dz] : 0

          if flag > 0
            rx, ry, rz = 0, 0, 0
            vx, vy = 0, 0

            if (flag.masked?(DataFlag::FULL_OFF_TILE))
              vx, vy = cell_width, cell_height
            elsif (flag.masked?(DataFlag::TQUART_OFF_TILE))
              vx, vy = (cell_width / 4) * 3, (cell_height / 4) * 3
            elsif (flag.masked?(DataFlag::HALF_OFF_TILE))
              vx, vy = cell_width / 2, cell_height / 2
            elsif (flag.masked?(DataFlag::QUART_OFF_TILE))
              vx, vy = cell_width / 4, cell_height / 4
            end

            if (flag.masked?(DataFlag::OFF_LEFT))
              rx -= vx
            elsif (flag.masked?(DataFlag::OFF_RIGHT))
              rx += vx
            end
            if (flag.masked?(DataFlag::OFF_DOWN))
              ry += vy
            elsif (flag.masked?(DataFlag::OFF_UP))
              ry -= vy
            end
            @tileset.render px + rx + x + j * cell_width,
                            py + ry + y + i * cell_height,
                            pz + rz + z + zm,
                            tile_id
          else
            @tileset.render px + x + j * cell_width,
                            py + y + i * cell_height,
                            pz + z + zm,
                            tile_id
          end

        end
      end
    end
  end

end