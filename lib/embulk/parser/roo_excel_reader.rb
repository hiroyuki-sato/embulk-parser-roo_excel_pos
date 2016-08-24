module Embulk
  module Parser
    class RooExcelReader
      def initialize(xlsx)
        @xlsx = xlsx
      end
 
      def read_cell(column)
        case column['type'].to_sym
        when :boolean
          boolean_column(column)
        when :long
          long_column(column)
        when :double
          double_column(column)
        when :timestamp
          timestamp_column(column)
        when :string
          string_column(column)
        when :json
          raise RuntimeError,"JSON type not implemented yet"
        else
          raise RuntimeError,"Unkown column type "
        end
      end

      def boolean_column(column)
	r,c = cell_pos(column['pos'])
	@xlsx.cell(r,c)
      end

      def long_column(column)
	r,c = cell_pos(column['pos'])
	v = @xlsx.cell(r,c)
        v.nil? ? nil : v.to_i
      end

      def double_column(column)
	r,c = cell_pos(column['pos'])
	v = @xlsx.cell(r,c)
        v.nil? ? nil : v.to_f
      end

      def timestamp_column(column)
	r,c = cell_pos(column['pos'])
	v = @xlsx.cell(r,c)
        if( v.kind_of?(Date) )
          v.to_time
        elsif ( v.kind_of?(String) )
          format = column['format'] || "%Y-%m-%d"
          Time.strptime(v,format)
        else
          nil
        end
      end
 
      def string_column(column)
	r,c = cell_pos(column['pos'])
	@xlsx.cell(r,c)
      end

      private
      def cell_pos(pos)
	if /(\D+)(\d+)/ =~ pos
	  pos_col = $1
	  pos_row = $2.to_i
	  [pos_col, pos_row]
	else
	  raise RuntimeError,"Invalid pos format"
	end
      end

      Z_NUM = 25
      A_CHR = 65
      def row_str_to_num(pos_col)
	num = 0
	pos_col.reverse.scan(/\w/).each_with_index do |c,i|
	  chr_num = c.ord - A_CHR + 1 
	  num += Z_NUM * i + chr_num
	end
	num
      end
    end
  end
end
