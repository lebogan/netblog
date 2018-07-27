section.container-fluid
  == render "src/views/alerts.slang"
  h4 10 Most recent of #{Memo.count} entries
  div.card
    div.card-header
      div
        a.btn.btn-secondary role="button" href="/log/new" Create a new log entry
    div.card-body
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
