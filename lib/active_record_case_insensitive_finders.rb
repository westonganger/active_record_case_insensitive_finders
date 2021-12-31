require "active_record"

require "active_record_case_insensitive_finders/version"
require "active_record_case_insensitive_finders/methods"

module ActiveRecordCaseInsensitiveFinders

  def self.get_where_strings_from_hash(hash, arel_table:, current_table_name: nil)
    array = []

    current_table_name = current_table_name.to_s

    hash.each do |k, v|
      if v.is_a?(Hash)
        array += self.get_where_strings_from_hash(v, arel_table: arel_table, current_table_name: k)
      else
        k = k.to_s

        if k.include?(".")
          current_table_name, col = k.split(".")
        else
          col = k
        end

        sql_str = arel_table[col].matches(v)

        if current_table_name && current_table_name != "" && current_table_name != arel_table.table_name
          sql_str = sql_str.to_sql.sub(arel_table.table_name, current_table_name)

          if Arel.respond_to?(:sql)
            sql_str = Arel.sql(sql_str)
          end
        end

        array << sql_str
      end
    end


    return array
  end

  def self.get_order_strings_from_hash(hash, arel_table:, current_table_name: nil)
    array = []

    current_table_name = current_table_name.to_s

    hash.each do |k, v|
      if v.is_a?(Hash)
        array += self.get_order_strings_from_hash(v, arel_table: arel_table, current_table_name: k)
      else
        if ["asc", "desc"].exclude?(v.to_s.downcase)
          raise ArgumentError.new("Invalid sort order provided: `#{v}`. Must be either 'asc' or 'desc'")
        end

        k = k.to_s

        if k.include?(".")
          current_table_name, col = k.split(".")
        else
          col = k
        end

        sql_str = arel_table[col].lower.send(v)

        if current_table_name && current_table_name != "" && current_table_name != arel_table.table_name
          sql_str = sql_str.to_sql.sub(arel_table.table_name, current_table_name)

          if Arel.respond_to?(:sql)
            sql_str = Arel.sql(sql_str)
          end
        end

        array << sql_str
      end
    end

    return array
  end

end
