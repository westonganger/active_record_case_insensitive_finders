# Active Record Case Insensitive Finders

<a href="https://badge.fury.io/rb/active_record_case_insensitive_finders" target="_blank"><img height="21" style='border:0px;height:21px;' border='0' src="https://badge.fury.io/rb/active_record_case_insensitive_finders.svg" alt="Gem Version"></a>
<a href='https://github.com/westonganger/active_record_case_insensitive_finders/actions' target='_blank'><img src="https://github.com/westonganger/active_record_case_insensitive_finders/workflows/Tests/badge.svg" style="max-width:100%;" height='21' style='border:0px;height:21px;' border='0' alt="CI Status"></a>
<a href='https://rubygems.org/gems/active_record_case_insensitive_finders' target='_blank'><img height='21' style='border:0px;height:21px;' src='https://ruby-gem-downloads-badge.herokuapp.com/active_record_case_insensitive_finders?label=rubygems&type=total&total_label=downloads&color=brightgreen' border='0' alt='RubyGems Downloads' /></a>

Adds case-insensitive finder methods to Rails and ActiveRecord

## Installation

```ruby
gem 'active_record_case_insensitive_finders'
```

## Methods

```ruby
Post.ci_find_by(name: "str")
### SAME AS Post.find_by("#{table_name}.name LIKE ?", "str")

Post.ci_find_by!(name: "str")
### SAME AS Post.find_by!("#{table_name}.name LIKE ?", "str")

Post.ci_order(name: :asc)
### SAME AS Post.order("lower(#{table_name}.name) ASC")

Post.ci_where_matches(name: "str")
### SAME AS Post.where("#{table_name}.name LIKE ?", "str")
```

To make any searches use a partially matching ILIKE/LIKE query instead of direct match, simply add the appropriate SQL "%" symbols to your string

```ruby
Post.ci_find_by(name: "%str%")
### SAME AS Post.find_by("lower(#{table_name}.name) LIKE ?", "%str%")

Post.ci_where_matches(name: "%str%")
### SAME AS Post.where("lower(#{table_name}.name) LIKE ?", "str")
```

## Credits

Created & Maintained by [Weston Ganger](https://westonganger.com) - [@westonganger](https://github.com/westonganger)
