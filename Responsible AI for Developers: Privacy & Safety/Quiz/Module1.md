# 📝 Module 1: Quiz

## Assessment Results

| Item | Detail |
| :--- | :--- |
| **Your Score** | 100% |
| **Passing Score** | 66% |
| **Status** | Congratulations! You passed this assessment. |

---

## 💡 Questions and Answers

### 1. Privacy Trade-offs

**Question:** In machine learning, privacy measures often introduce trade-offs with other important factors. Which of the following does NOT represent a typical trade-off?

* Privacy and Transparency
* Privacy and Training Efficiency
* Privacy and Fairness
* Privacy and Model Performance

**Correct Answer:** **Privacy and Transparency**

**Explanation:** Transparency is important regardless of the strength of the privacy measure. We should provide information about data and models to the stakeholders when needed. The most common technical trade-offs are with Model Performance, Training Efficiency, and Fairness.

### 2. Evaluating De-identification Techniques

**Question:** You've applied various de-identification techniques to a customer dataset containing sensitive information before using it to train an AI model. Which of the following concepts should you use to evaluate the suitability of your de-identification techniques?

* Productivity and efficiency.
* Scalability and efficiency.
* Complexity and time consumption.
* Reversibility and referential integrity.

**Correct Answer:** **Reversibility and referential integrity.**

**Explanation:** **Reversibility** evaluates whether the data can be re-identified. **Referential integrity** evaluates whether the relationship between records is maintained after de-identification, which is crucial for maintaining data utility.

### 3. Technique for Restricting Data Contribution

**Question:** A customer is working with a large dataset of healthcare records to develop a diagnostic AI model. They want to ensure privacy of sensitive data, by restricting the contribution of specific data on the model during training. Which privacy-focused technique would be best for the customer?

* Data perturbation
* DP-SGD (Differentially Private - Stochastic Gradient Descent)
* Federated Learning
* TFF (TensorFlow Federated)

**Correct Answer:** **DP-SGD (Differentially Private - Stochastic Gradient Descent)**

**Explanation:** **DP-SGD** carefully adds calculated noise into the gradient descent process to protect individual contributions, mathematically guaranteeing that the trained model does not reveal the presence or absence of any single data point.
