section.container-fluid
  div.panel.panel-default
    div.panel-heading
      div
        a.btn.btn-default href="/log/new" Create a new log entry
  p 10 Most recent entries
    div.panel-body      
      - if memos.any?
          table.table.table-striped.table-bordered
            thead
              tr
                th Id
                th Entry Date
                th Category
                th Memo
                th Action
            - memos.each do |memo|
                tr
                  td
                    a href="/log/#{memo.id}" #{memo.id}
                  td #{memo.entry_date}
                  td #{memo.category}
                  td #{memo.memo}
                  td
                    a href="/log/#{memo.id}/edit" Edit
                    a href="/log/#{memo.id}/delete" Delete
      - else
          p No records created yet!
