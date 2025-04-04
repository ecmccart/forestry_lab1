################################################################################
#                                                                              #
#                           6. Final Summary Table                            #
#                                                                              #
################################################################################

### Step 6.1: Merge All Data
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Merge `sum_u2` with `dom_cnt` and `richness`.
#   - Use `left_join()` to combine these dataframes based on the `Plot` column.
#   - Add species name and code in the summary file.

# Example of merging multiple dataframes using dplyr:
#   dataframe1 %>% left_join(dataframe2, by = "common_column") %>%
#   left_join(dataframe3, by = "common_column")

# Implement this step to merge all relevant data into `sum_u2`.

#----------------
sum_u2 <- sum_u2 %>%
  left_join(dom_cnt, by = "Plot") %>%
  left_join(richness, by = "Plot")
#----------------

### Step 6.1.1: Add Species Information and Rename Columns
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Merge species information into the summary dataframe.
#   - Use `left_join()` to combine dataframes based on a common column.
#   - Rename the `Code` column to `Dom_species` and the count column (`n`) to `Abundance`.

# Example of merging dataframes using dplyr:
#   dataframe1 %>% left_join(dataframe2, by = c("column1" = "column2"))

# Example of renaming columns using dplyr:
#   dataframe %>% rename(new_name = old_name)

# Implement this step to add species information and rename columns.

#----------------
sum_u2 <- sum_u2 %>%
  left_join(SppCode[,c('SppCode','Common.name')], by = c("Code" = "SppCode"))

sum_u2 <- sum_u2 %>% 
  rename(Dom_species = Code, Abundance = n)
#----------------

### Step 6.3: Convert Biomass Units
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Convert biomass from kilograms per acre to tons per acre.
#   - Divide the biomass in kilograms per acre by 1000 to convert to tons per acre.

# Example of converting units:
#   dataframe$new_column <- dataframe$old_column / conversion_factor

# Implement this step to convert biomass units.

#----------------
sum_u2$bm_tonpa <- sum_u2$bm_pa / 1000
#----------------

### Step 6.4: Apply Dominance Threshold
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# If relative abundance < 50%, label the plot as "Mixed".
#   - Use `ifelse()` to apply this condition to the `Dom_species` and `Common.name` columns.
#   - Remove duplicate rows to ensure only one dominant species per plot.

# Example of using ifelse() in dplyr:
#   dataframe %>% mutate(column = ifelse(condition, value_if_true, value_if_false))

# Implement this step to apply the dominance threshold.

#----------------
sum_u2 <- sum_u2 %>%
  mutate(Dom_species = ifelse(rel_abd > 50, Dom_species, "Mixed"),
         Common.name = ifelse(rel_abd > 50, Common.name, "Mixed"))

# Remove duplicate rows
sum_u2 <- sum_u2 %>% distinct() 
#----------------

# Question 9: What’s the dominant species of plot D5 now? Compare with your previous answer.
#     The most dominant species of plot D5 now is Mixed. The previous answer was Chestnut oak. 

### Step 6.5: Save the Final Dataset and Commit to GitHub
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Save `sum_u2` to a CSV file for future use.
#   - Use `write.csv()` to export the dataframe to a CSV file.
#   - After saving, commit and push the file to your GitHub repository.

# Example of exporting a dataframe to a CSV file:
#   write.csv(dataframe, "filename.csv", row.names = FALSE)

# Implement this step to save the final dataset.

#----------------
write.csv(sum_u2, "sum_u2_dplyr.csv", row.names = FALSE)
#----------------

library(ggplot2)
ggplot(sum_u2, aes(TPA)) + geom_histogram() + labs(title = "TPA Distribution")

ggplot(sum_u2, aes(TPA)) + 
  geom_histogram() + 
  labs(title = "TPA Distribution", x = "Trees Per Acre (TPA)", y = "Number of Plots") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(sum_u2, aes(BA)) + 
  geom_histogram() + 
  labs(title = "Basal Area", x = "Basal Area (BA)", y = "Number of Plots") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(sum_u2, aes(biomass)) + 
  geom_histogram() + 
  labs(title = "Biomass", x = "Biomass", y = "Number of Plots") +
  theme(plot.title = element_text(hjust = 0.5))

library(forcats)
ggplot(sum_u2[sum_u2$Common.name!='Mixed',],
       aes(fct_infreq(Common.name))) + geom_bar() + labs(title = "Dominant Species by Plot")

sum_u2 %>%
  filter(Common.name != "Mixed") %>%
  ggplot(aes(fct_infreq(Common.name))) +
  geom_bar() +
  labs(title = "Dominant Species by Plot", x = "Species", y = "Count") +
  theme(plot.title = element_text(hjust = 0.5))
