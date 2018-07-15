section.container-fluid style="height: 500px"
  == render "src/views/alerts.slang"
  h4 10 Most recent of #{Memo.count} entries
  div.panel.panel-default
    div.panel-heading
      div
        a.btn.btn-default href="/log/new" Create a new log entry
    div.panel-body      
      - entries = find_all_records
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
