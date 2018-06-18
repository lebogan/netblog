section.container-fluid
  div.panel.panel-default
    div.panel-heading
      div
        a.btn.btn-default href="/new" Create a new log entry
  p 10 Most recent entries
    div.panel-body      
      - if memos.any?
          table.table.table-striped.table-bordered
            thead
              tr
                th id
                th entry_date
                th category
                th memo
            - memos.each do |memo|
                tr
                  td
                    a href="#{memo.id}" #{memo.id}
                  td #{memo.entry_date}
                  td #{memo.category}
                  td #{memo.memo}
      - else
          p No records created yet!
