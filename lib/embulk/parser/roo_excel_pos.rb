require 'roo'
require 'embulk/parser/roo_excel_reader'
module Embulk
  module Parser
=begin
    class RooColumn < Column
      attr_accessor :position
      def initialize(idx,name,type,format=nil,pos=nil)
        super(idx,name,type,format)
        @pos = pos
      end
    end
=end

    class RooExcelPos < ParserPlugin
      Plugin.register_parser("roo_excel_pos", self)

      def self.transaction(config, &control)
        # configuration code:
        task = {
          "columns" => config.param("columns", :array)
        }

        columns = []
        task['columns'].each_with_index do |c,i|
          columns << Column.new(i, c['name'], c['type'].to_sym,c['format'])
        end


        yield(task, columns)
      end

      def init
        @columns = task["columns"]
      end

      def run(file_input)
        while file = file_input.next_file

          begin
            xlsx = Roo::Excelx.new(StringIO.new(file.read))
            xlsx.default_sheet = xlsx.sheets.first
            excel_reader = RooExcelReader.new(xlsx)
            row = []
            @columns.each do |col|
              row << excel_reader.read_cell(col)
            end
            @page_builder.add(row)
          rescue ArgumentError
            puts $!
            puts $!.backtrace
            puts "Can't open data file"
          rescue
            raise
          end
        end
        page_builder.finish

      end
    end
  end
end
