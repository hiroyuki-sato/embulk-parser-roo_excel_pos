module Embulk
  module Parser
    class RooExcelReader
      def initialize(xlsx,task)
        @xlsx = xlsx
        if sheet = task["default_sheet_name"]
          @default_sheet = sheet
        else
          @default_sheet = xlsx.sheets.first
        end
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

      private
      def boolean_column(column)
	get_data(cell_pos(column['pos']))
      end

      def long_column(column)
	v = get_data(cell_pos(column['pos']))
        v.nil? ? nil : v.to_i
      end

      def double_column(column)
	v = get_data(cell_pos(column['pos']))
        v.nil? ? nil : v.to_f
      end

      def timestamp_column(column)
	v = get_data(cell_pos(column['pos']))
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
	get_data(cell_pos(column['pos']))
      end

      def get_data(cpos)
        s = cpos['sheet']
        r = cpos['row']
        c = cpos['col']

        sheet = @xlsx.sheet(s)
        raise RuntimeError,"Sheet #{s} not found" unless sheet
        sheet.cell(r,c)
      end

      def cell_pos(pos)
	if /([^!]+)!(\D+)(\d+)/ =~ pos
          { 'sheet' => $1,'col' => $2, 'row' => $3.to_i }
	elsif /(\D+)(\d+)/ =~ pos
          { 'sheet' => @default_sheet,'col' => $1, 'row' => $2.to_i }
        else
	  raise RuntimeError,"Invalid pos format"
	end
      end

    end
  end
end
