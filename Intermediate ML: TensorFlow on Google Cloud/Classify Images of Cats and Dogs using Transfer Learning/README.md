1. In the Google Cloud console, on the Navigation menu (Navigation menu icon), click **Vertex AI** > **Workbench**.


2. Find the **vertex-ai-jupyterlab**__ instance and click on the Open JupyterLab button.


3. Open **Terminal** and run command:


`gcloud storage cp gs://qwiklabs-gcp-01-fd0bdda49a66-labconfig-bucket/transfer_learning-v1.0.0.ipynb .`


then


`jupyter nbconvert --clear-output --inplace transfer_learning-v1.0.0.ipynb`


4. Open the notebook file **transfer_learning-v1.0.0.ipynb**__ in Vertex AI Workbench.


5. Run all cells and complete!
