# 📝 Module 2: Quiz

## Assessment Results

| Item | Detail |
| :--- | :--- |
| **Your Score** | 100% |
| **Passing Score** | 66% |
| **Status** | Congratulations! You passed this assessment. |

---

## 💡 Questions and Answers

### 1. Emphasizing AI Safety for Sensitive Data

**Question:** You're pitching an AI-powered customer support solution to a potential client. Their company handles **highly sensitive user information**, and they have reservations about potential risks associated with AI systems. To address their concerns and win their trust, which key message about AI safety would be most effective to emphasize?

* "AI safety practices increase development speed, enabling us to deliver your project faster and at a lower cost."
* **"Adherence to AI safety principles helps us build reliable systems that minimize unexpected errors, safeguarding your customer data."**
* "AI safety mechanisms make our systems easier to understand, allowing you greater control and oversight."
* "AI safety prioritizes fairness and avoids biased outcomes, protecting the interests of your diverse customer base."

**Correct Answer:** **"Adherence to AI safety principles helps us build reliable systems that minimize unexpected errors, safeguarding your customer data."**

**Explanation:** This directly emphasizes how **AI safety** translates into **data protection** and **system reliability**, which is the client's primary concern when dealing with highly sensitive user information.

### 2. Generative AI Safety Failure Modes

**Question:** Your manager asked you to lead a project to research the key considerations in AI safety and develop a failure mode catalog to assist evaluate safety in Generative AI products. Which of the following should **not** be included as a failure mode?

* Discrimination.
* Violence.
* **Citation**
* Hate speech

**Correct Answer:** **Citation**

**Explanation:** **Citation** is generally not considered a core safety **failure mode** related to generating harmful content. Failure modes typically involve generating or facilitating harmful outputs such as Discrimination, Violence, or Hate speech. Citation is a desirable feature of helpfulness/truthfulness.

### 3. Fine-tuning an LLM using Human Preferences

**Question:** You want to embed the concept of safety into a pre-trained LLM by fine-tuning it. You have a dataset of prompts and pairs of possible answers, along with **labels created by human safety evaluators indicating their preference for one answer over the other**. Which technique is the most suitable for fine-tuning the LLM in this scenario?

* Zero-shot Learning
* **Reinforcement Learning from Human Feedback (RLHF)**
* Transfer Learning
* Instruction Tuning

**Correct Answer:** **Reinforcement Learning from Human Feedback (RLHF)**

**Explanation:** **RLHF** is specifically designed to align LLMs with human preferences (like safety, helpfulness, or truthfulness). It uses a reward model trained on your human preference dataset to guide the LLM toward generating more preferred responses, effectively incorporating the safety concepts represented in the dataset.
