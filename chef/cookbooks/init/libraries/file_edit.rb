class Chef
  class Util
    class FileEdit

      def replace_or_append_line regex, newline
        if has_line? regex
          search_file_replace_line regex, newline
        else
          append_line newline
        end
      end

      def append_line(line)
        @contents << line
        @file_edited = true
      end

      def has_line? regex
        @contents.each do |line|
          if line.match(regex)
            return true
          end
        end
        false
      end

    end
  end
end
