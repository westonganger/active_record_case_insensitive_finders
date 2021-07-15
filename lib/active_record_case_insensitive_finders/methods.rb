module ActiveRecordCaseInsensitiveFinders
  module Methods

    def ci_where_matches(hash)
      this = self

      hash.each do |col, val|
        this = this.where(arel_table[col].matches(val))
      end

      return this
    end

    def ci_order(hash)
      this = self

      hash.each do |col, val|
        this = this.order(arel_table[col].matches(val))
      end

      return this
    end

    def ci_find_by(hash)
      return self.ci_where(hash).first
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
