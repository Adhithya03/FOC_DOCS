import os
import shutil

# Define the directory
directory = "./Writings/"

# Loop over the files in the directory
for filename in os.listdir(directory):
    if filename.endswith(".jpg") or filename.endswith(".png"): # add or modify the conditions based on your image file types
        # Define the new filename
        new_filename = "writings_" + filename
        # Rename the file
        os.rename(os.path.join(directory, filename), os.path.join(directory, new_filename))