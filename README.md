# CrimeCategory

The goal of this project is to develop a machine learning model that predicts the category of a crime based on various crime-related features. 
By analyzing past crime data, the model aims to assist law enforcement agency(LAPD) in identifying trends, allocating resources effectively, and improving public safety measures.
The dataset provided contains historical crime data, including features such as crime location, time, and other relevant attributes. 

**APPROACH FOLLOWED**
![image](https://github.com/user-attachments/assets/66baaa21-3f88-4990-a08d-d64e6330e9a7)
![image](https://github.com/user-attachments/assets/ee781052-8ec5-4467-95a6-d8c394aed118)

**DATA PREPROCESSING STEPS**
1. Target variable was encoded using Label encoding (since multinomial classification).
2. Features were encoded using One Hot encoding (since nominal data).
3. For feature elimination, SelectKBest technique was used to select 15 best features.
4. Then, data was balanced using SMOTE technique.
5. Then, train-test split was applied to segregate the data into training and validation data to build the model.

**MODEL EVALUATION**
1. XGBoost model
+--------------------------+---------+
| Metric                   |   Value |
+==========================+=========+
| Training accuracy Score  |  0.912  |
+--------------------------+---------+
| Testing accuracy Score   |  0.8696 |
+--------------------------+---------+
| Training Precision score |  0.92   |
+--------------------------+---------+
| Testing Precision score  |  0.87   |
+--------------------------+---------+

2. RandomForest model
+--------------------------+---------+
| Metric                   |   Value |
+==========================+=========+
| Training accuracy Score  |  0.7942 |
+--------------------------+---------+
| Testing accuracy Score   |  0.7907 |
+--------------------------+---------+
| Training Precision score |  0.81   |
+--------------------------+---------+
| Testing Precision score  |  0.81   |
+--------------------------+---------+

Since, XGBoost model gave better accuracy, hence, it was selected for test data prediction.

**MODEL DEPLOYMENT**
1. A Joblib file was created to store the model and pre-processing steps.
2. Using streamlit package, model was deployed on render to generate a web app.
