section.container-fluid
  div.panel.panel-default
    div.panel-heading
      p Search results for "#{env.params.body["#{caption}"]}"
    div.panel-body      
      - if queries.any?
          table.table.table-striped.table-bordered
            thead
              tr
                th Entry Date
                th Category
                th Memo
            - queries.each do |query|
                tr
                  td #{query.entry_date}
                  td #{query.category}
                  td #{query.memo}
