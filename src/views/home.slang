section.container-fluid
  h4 10 Most recent of #{number_of_records} entries
  div.panel.panel-default
    div.panel-heading
      div
        a.btn.btn-default href="/log/new" Create a new log entry
    div.panel-body      
      - if entries.any?
          table.table.table-striped.table-bordered
            thead
              tr
                th Entry Date
                th Category
                th Memo
                th Action
            - entries.each do |entry|
                tr
                  td #{entry.entry_date}
                  td #{entry.category}
                  td #{entry.memo}
                  td
                    a href="/log/#{entry.id}/edit" Edit
                    a href="/log/#{entry.id}/delete" Delete
      - else
          p No records created yet!
