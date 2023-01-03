#$sourceComp = Read-Host -Prompt "What is the name of the source computer?"
#$user = Read-Host -Prompt "What is the username?"


Copy-Item -Path "D:/Users/llynch/Desktop" -Destination "C:\Users\cvincent\Desktop\llynch" -Recurse -Force
Copy-Item -Path "D:/Users/llynch/Documents" -Destination "C:\Users\cvincent\Desktop\llynch" -Recurse -Force
Copy-Item -Path "D:/Users/llynch/Downloads" -Destination "C:\Users\cvincent\Desktop\llynch" -Recurse -Force
Copy-Item -Path "D:/Users/llynch/Pictures" -Destination "C:\Users\cvincent\Desktop\llynch" -Recurse -Force
Copy-Item -Path "D:/Users/llynch/Videos" -Destination "C:\Users\cvincent\Desktop\llynch" -Recurse -Force

