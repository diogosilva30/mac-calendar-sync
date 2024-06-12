tell application "Calendar"
    -- Execute this script first manually via osascript Exchange_Sync.applescript to allow all security pop-ups. Make sure you use empty destination calendar because it will be wiped each run!
    -- Don't forget to grant full calendar rights from System settings > Privacy & Security > Calendars > App > Options > Full calendar access
    -- Schedule it via crontab -e and paste: "0 * * * * osascript /Users/diosil1/code/mac-calendar-sync/Exchange_Sync.applescript > /Users/diosil1/code/mac-calendar-sync/cronjob.log"
    -- Get the current date and time
    set currentDate to current date
    -- Set the start date range to 7 days ago
    set startDateRange to currentDate - (1 * days)
    -- Set the end date range to 30 days in the future
    set endDateRange to currentDate + (30 * days)

    -- Get the calendar named "Calendar" - ! MODIFY LINE BELOW - Source calendar !
    set sourceCalendar to calendar "Calendar"
    -- Get the calendar named "Work" - ! MODIFY LINE BELOW - Destination calendar (to be overwritten - delete all events and re-create!) !
    set destinationCalendar to calendar "Work"

    -- Delete events from the destination calendar
    set destEvents to every event of destinationCalendar
    repeat with anEvent in destEvents
        delete anEvent
    end repeat

    -- Duplicate events from the source calendar to the destination
    set sourceEvents to every event of sourceCalendar
    repeat with anEvent in sourceEvents
        set eventStartDate to start date of anEvent
        set eventEndDate to end date of anEvent
        set eventSummary to summary of anEvent

        -- Check the event's start date is within the last 7 days and the next 30 days
        if (eventStartDate ³ startDateRange) and (eventStartDate ² endDateRange) then
            if eventEndDate is missing value then
                set eventEndDate to eventStartDate + (60 * minutes) -- Add 60 minutes if there is no end date
            end if
            try
                -- Attempt to create the new event with the specified end date
                set newEvent to make new event at end of destinationCalendar with properties {start date:eventStartDate, end date:eventEndDate, summary:eventSummary}
                -- Logging the start and end dates
                log "Processed event: " & eventSummary & " | Start Date: " & eventStartDate & " | End Date: " & eventEndDate
            on error errMsg number errorNumber
                -- Log any errors
                log "Failed to copy event \"" & eventSummary & "\". Error: " & errMsg & " (Error number " & errorNumber & ")"
            end try
        end if
    end repeat
end tell