module WallsHelper
	def tape_color(color)
	  case color
		when 'Black'
		  '#232a2b'
		when 'Blue'
		  '#0612c5'
		when 'Green'
		  '#066312'
		when 'Lime'
		  '#73d80f'
		when 'Orange'
		  '#FF8100'
		when 'Pink'
		  '#fd56c3'
		when 'Purple'
		  '#660099'
		when 'Red'
		  '#d20a0a'
		when 'Teal'
		  '#04B6D0'
		when 'White'
		  '#fffff0'
		when 'Yellow'
		  '#ffd700'
		else
		  '#dcdccf'
	  end
	end
end
