module ActiveRecordCaseInsensitiveFinders
  module Methods

    def ci_where_matches(hash)
      this = self

      if !hash.is_a?(Hash)
        raise ArgumentError.new("Invalid argument type")
      end

      where_strings = ActiveRecordCaseInsensitiveFinders.get_where_strings_from_hash(hash, arel_table: arel_table)

      where_strings.each do |sql_str|
        this = this.where(sql_str)
      end

      return this
    end

    def ci_order(hash)
      this = self

      if !hash.is_a?(Hash)
        raise ArgumentError.new("Invalid argument type")
      end

      order_strings = ActiveRecordCaseInsensitiveFinders.get_order_strings_from_hash(hash, arel_table: arel_table)

      order_strings.each do |sql_str|
        this = this.order(sql_str)
      end

      return this
    end

    def ci_find_by(hash)
      return self.ci_where_matches(hash).first
    end

    def ci_find_by!(hash)
      record = self.ci_find_by(hash)

      if record
        return record
      else
        raise ActiveRecord::RecordNotFound
      end
    end

  end
end

ActiveRecord::Relation.send(:include, ActiveRecordCaseInsensitiveFinders::Methods) ### include adds to instance methods
ActiveRecord::Base.send(:extend, ActiveRecordCaseInsensitiveFinders::Methods) ### extend adds to class methods
