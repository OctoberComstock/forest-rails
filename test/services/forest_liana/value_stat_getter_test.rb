module ForestLiana
  class ValueStatGetterTest < ActiveSupport::TestCase
    test 'Value stat getter with a simple filter' do
      stat = ValueStatGetter.new(BooleanField, {
        type: "Value",
        collection: "boolean_field",
        timezone: "Europe/Paris",
        aggregate: "Count",
        filterType: "and",
        filters: [{
          field: "field",
          value: "true"
        }]
      })

      stat.perform
      assert stat.record.value[:countCurrent] == 0
    end

    test 'Value stat getter with a filter on a belongs_to integer field' do
      stat = ValueStatGetter.new(BelongsToField, {
        type: "Value",
        collection: "belongs_to_field",
        timezone: "Europe/Paris",
        aggregate: "Count",
        filterType: "and",
        filters: [{
          field: "has_one_field:id",
          value: "3"
        }]
      })

      stat.perform
      assert stat.record.value[:countCurrent] == 1
    end

    test 'Value stat getter with a filter on a belongs_to boolean field' do
      stat = ValueStatGetter.new(BelongsToField, {
        type: "Value",
        collection: "belongs_to_field",
        timezone: "Europe/Paris",
        aggregate: "Count",
        filterType: "and",
        filters: [{
          field: "has_one_field:checked",
          value: "false"
        }]
      })

      stat.perform
      assert stat.record.value[:countCurrent] == 0
    end

    test 'Value stat getter with a filter on a belongs_to enum field' do
      stat = ValueStatGetter.new(BelongsToField, {
        type: "Value",
        collection: "belongs_to_field",
        timezone: "Europe/Paris",
        aggregate: "Count",
        filterType: "and",
        filters: [{
          field: "has_one_field:status",
          value: "pending"
        }]
      })

      stat.perform
      assert stat.record.value[:countCurrent] == 1
    end
  end
end
