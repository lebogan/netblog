section.container-fluid
  div.card
    div.card-header
      p Search results for "#{env.params.body["#{caption}"]}": 
        | found #{queries.size} record(s)
    div.card-content      
      - if queries.any?
          table.table.table-striped.table-bordered
            thead
              tr
                th Entry Date
                th Category
                th Memo
                th Action
            - queries.each do |query|
                tr
                  td #{query.entry_date}
                  td #{query.category}
                  td #{query.memo}
                  td
                    a href="/log/#{query.id}/edit" Edit
                    a href="/log/#{query.id}/delete" Delete
