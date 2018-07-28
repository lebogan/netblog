section.container-fluid
  div.card
    div.card-header
      p Application notes:
    div.card-body
      pre 1. Data input constraints
        |       Categories are limited to the selection list presented
        |       Memos are formatted to be consistent in appearance, i.e., 
        |         The first word is capitalized
        |         A period is added at the end if no punctuation (., !, or ?) is present
      pre 2. Searches
        |       Categories are limited to the selection list presented
        |       Memo searches are free-form text, e.g., "my junk memo"
        |       Dates are a defined format such as: 2018-06-08 or 06-08 or 2018
      pre 3. Backups
        |       This is a .sql timestamped file containing schema and data entries.
        |       It is created using the SQLite3 .dump dot-command. It contains the
        |       SQL statements to regenerate the database. A timestamped .bak file
        |       is also created using the .backup dot-command. This is a binary
        |       copy of the database, a snapshot.
        |         
        |       Backups can fail for the following reasons:
        |         - The database, netlog.db, is actually in this directory?
        |             'ls -l ~/netlog_db'
        |         
        |         - Incorrect directory permissions - make sure you own this directory
        |           and can write to it.
        |             'sudo chown -R $USER: ~/netlog_db'
        |             'sudo chmod -R ug=rwx ~/netlog_db'
        |         
        |         - Database directory doesn't exist or is named something else.
        |             'ls -ld ~/netlog_db'
        |         
        |         If you accidentally deleted the database, netlog will automatically
        |         create a new empty one for you when you start the app. Find a good
        |         backup you stored somewhere else and use the restore function under
        |         'Database maintenance' for restoring the data.
        |
