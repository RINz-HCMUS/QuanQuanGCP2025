## Lab Instructions and Tasks

### Task 0. Setup and Requirements
  **Enable the Necessary APIs:**
    * **Enable the Notebooks API:**
        * In the Google Cloud Console, on the **Navigation menu**, click **APIs & Services > Library**.
        * Search for `Notebooks API` and press **ENTER**.
        * Click on the `Notebooks API` result, and if the API is not enabled, click **Enable**.
    * **Enable the Vertex AI API:**
        * In the Google Cloud Console, on the **Navigation menu**, click **Vertex AI > Dashboard**.
        * Click **ENABLE ALL RECOMMENDED APIS**.
    * *Click **Check my progress** to verify the objective.*

---

### Task 1. Open Vertex AI Workbench Instance

1.  In the Google Cloud Console, on the **Navigation Menu**, click **Vertex AI > Workbench**.
2.  On the **Instance** page, click **CREATE NEW**.
3.  Use the default **zone** and **region**: `us-central1-a` and `us-central1`. Leave the remaining settings as they are and then click **Create**.
    * *The new VM will take 2-3 minutes to start.*
4.  Click **Open JupyterLab**. A JupyterLab window will open in a new tab.
5.  *Click **Check my progress** to verify the objective.*

---

### Task 2. Clone a Course Repo within Your Vertex AI Workbench Instance

1.  In JupyterLab, open a **new terminal window**.
2.  At the command-line prompt, run the following commands to clone the notebook:

    ```bash
    git clone [https://github.com/GoogleCloudPlatform/asl-ml-immersion.git](https://github.com/GoogleCloudPlatform/asl-ml-immersion.git)
    cd asl-ml-immersion
    export PATH=$PATH:~/.local/bin
    make install
    ```

3.  To confirm that you have cloned the repository, double-click on the **`asl-ml-immersion`** directory and ensure that you can see its contents.

4.  *Click **Check my progress** to verify the objective.*

---

### Task 3. Implement Differential Privacy with TensorFlow Privacy

1.  In the notebook interface, navigate to **`asl-ml-immersion > notebooks > responsible_ai > privacy > solutions`** and open **`privacy_dpsgd.ipynb`**.
2.  In the notebook interface, click **Edit > Clear All Outputs**.
3.  Carefully read through the notebook instructions and run through the notebook.
    * *Tip: To run the current cell, click the cell and press **SHIFT+ENTER**. Other cell commands are listed in the notebook UI under **Run**.*

---
