#
# core/state_modifier_test.rb
#   Press the Mouse buttons, and try pressing the modifier keys with it
#   SHIFT, CONTROL, ALT, SUPER
class State_ModifierTest < State

  CNULL  = 0
  CFALSE = 0
  CTRUE  = 1

  def init
    init_data_table
    init_spriteset
    super
  end

  def init_data_table
    @data_table = Table.new(Input::Mouse::BUTTONS.size, Input::Mouse::MODS.size)
  end

  def init_spriteset
    @spritesheet = Spritesheet.new("resources/media_buttons_32x32.png", 32, 32)
  end

  def render
    super
    for y in 0...@data_table.row_count
      @data_table.row(y).each_with_index do |state, i|
        @spritesheet.render(i * 32, y * 32, 0, y % 4) if state == CTRUE
      end
    end
  end

  def update
    MODS.each_with_index do |mod, y|
      BUTTONS.each_with_index do |button, x|
        if mod != CNULL
          #puts format(">> Setting button=%d with mod=%d", button, mod)
          @data_table[x, y] = Input::Mouse.pressed?(button, mod) ? CTRUE : CFALSE
        else
          #puts format(">> Setting button=%d", button)
          @data_table[x, y] = Input::Mouse.pressed?(button) ? CTRUE : CFALSE
        end
      end
    end

    # console debug
    #puts "      | L, R, M"
    #puts "N/A   | " + @data_table.row(0).join(", ")
    #puts "SHIFT | " + @data_table.row(1).join(", ")
    #puts "CTRL  | " + @data_table.row(2).join(", ")
    #puts "ALT   | " + @data_table.row(3).join(", ")
    #puts "SUPER | " + @data_table.row(4).join(", ")
    super
  end

end
