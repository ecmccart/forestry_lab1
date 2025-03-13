################################################################################
#                                                                              #
#                           1. Data Integration                                #
#                                                                              #
################################################################################


### Step 1.1: Create a GitHub Repository and Upload Files
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1. Go to GitHub (https://github.com/) and log in to your account.
# 2. Create a new repository (e.g., "Forestry_Lab_Data").
# 3. Upload the following files to your repository:
#    - U2_2017data.csv
#    - Species_Codes.csv
#    - Biomass_Equation.csv
# 4. After uploading, click on each file in GitHub and find the "Raw" button.
# 5. Copy the raw URL for each file, as you will need it to read the data in R.

## Step 1.2: Read the U2_2017data.csv File from GitHub
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The `read.csv()` function reads a CSV file directly from an online source.
# Ensure you use the correct "raw" URL for the file.

#----------------
#u2_data <- read.csv()
#----------------

### Step 1.3: Explore the structure and summary of the dataframe
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use str(), skimr::skim(), and dplyr::glimpse() to understand the dataframe.

#----------------

#----------------

### Step 1.4: Remove missing values from the DBH and Code columns using dplyr
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Consider using dplyr's filter() function to exclude rows with NA values in these columns.
# The general syntax for excluding NA values is:
#   dataframe %>% filter(!is.na(column_name))
# Think about how you can apply this syntax to exclude NA values from both DBH and Code columns.
# Implement your solution using this approach.

#----------------
#u2_data <- 
#----------------

### Step 1.5: Keep only overstory trees (Class = "O") using dplyr
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Think about how you can use filter() to select only rows where Class is "O".
# The general syntax for filtering based on a condition is:
#   dataframe %>% filter(condition)
# For example, to filter based on a specific value in a column, you would use:
#   dataframe %>% filter(column_name == "value")
# Implement your solution using this approach.

#----------------
#u2_data <-
#----------------

### Step 1.6: Read the Species_Codes.csv File and Merge It with u2_data_overstory
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use read.csv() to read Species_Codes.csv directly from GitHub into a dataframe named SppCode.
# Make sure to use the "Raw" URL of the file.

#----------------     
#SppCode <- read.csv()
#---------------- 

# Merge u2_data with SppCode using merge.data.frame.
# Consider using the merge() function with all.x = TRUE to preserve all rows from u2_data.
# The general syntax for merging datasets is:
#   merge(x = dataframe1, y = dataframe2, by = "common_column", all.x = TRUE)
# However, if the common column has different names in the two dataframes, you can specify them separately using by.x and by.y.
# For example:
#   merge(x = dataframe1, y = dataframe2, by.x = "column_name_in_df1", by.y = "column_name_in_df2", all.x = TRUE)
# In this case, you should merge based on the `Code` column in u2_data and the `SppCode` column in SppCode.
# Think about how you can apply this syntax to merge u2_data with SppCode using these columns.
# Implement your solution using this approach and store the result in trees_merge.

#----------------
#trees_merge <- merge() 
#----------------

### Step 1.7: Create a new dataset named trees
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create a new dataset named trees with at least the following columns: Plot, Code, Genus, Common.name, DBH, Chojnacky_Code.
# Consider using the select() function from dplyr to choose the desired columns.
# The general syntax for selecting columns is:
#   dataframe %>% select(column1, column2, ...)
# Think about how you can apply this syntax to create the trees dataset from trees_merge.
# Implement your solution using this approach.

#----------------
#trees <- trees_merge %>%
#----------------  

# Checkpoint: Review the Largest DBH Values
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use the following code to verify your results:
#head(trees %>% arrange(desc(DBH)))

# Your results should look similar to this:
#     Plot Code        Genus  Common.name  DBH Chojnacky_Code
#     P6  TUP Liriodendron Tulip poplar 40.1             27
#     J6  CHO      Quercus Chestnut oak 38.2             23
#     H5  TUP Liriodendron Tulip poplar 37.6             27
#     K4  TUP Liriodendron Tulip poplar 36.9             27
#     J6  CHO      Quercus Chestnut oak 35.7             23
#     H2  TUP Liriodendron Tulip poplar 35.4             27
