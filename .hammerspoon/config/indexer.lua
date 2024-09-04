local start_time = os.clock()
print("Indexing...")

-- Path to the database
local dbPath = os.getenv("HOME") .. "/index_database.db"

-- Create the table for files, if it doesn't already exist
os.execute('sqlite3 ' .. dbPath .. ' "CREATE TABLE IF NOT EXISTS files (path TEXT PRIMARY KEY, is_directory INTEGER);"')

-- Function to escape characters for SQL
local function escape_sql(str)
    local map = {
        ["\\"] = "\\\\",
        ["'"] = "''",
        ['"'] = '\\"',
        ["\0"] = "\\0",
        ["\b"] = "\\b",
        ["\n"] = "\\n",
        ["\r"] = "\\r",
        ["\t"] = "\\t",
        ["`"] = "\\`",
        ["$"] = "\\$",
    }

    return str:gsub(".", map)
end

-- Recursive function to insert a file/directory and its contents into the database
local function indexDirectory(path)
    local attrs = hs.fs.attributes(path)

    if attrs then
        -- Prepare the query for inserting this file/directory into the database
        local escapedPath = escape_sql(path)
        local query = string.format('INSERT OR REPLACE INTO files VALUES ("%s", %d);', escapedPath, attrs.mode == "directory" and 1 or 0)
        
        -- Execute the query
        os.execute('sqlite3 ' .. dbPath .. ' "' .. query .. '"')

        -- If it's a directory, index its contents
        if attrs.mode == "directory" then
            for file in hs.fs.dir(path) do
                -- Ignore the special files "." and ".."
                if file ~= "." and file ~= ".." then
                    indexDirectory(path .. "/" .. file)
                end
            end
        end
    end
end

-- Start the indexing
indexDirectory(os.getenv("HOME") .. "/Downloads")

local end_time = os.clock()
print("Time elapsed:", end_time - start_time, "seconds")