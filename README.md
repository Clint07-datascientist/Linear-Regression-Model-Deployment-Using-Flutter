# Crop Yield Prediction

A machine learning-based application that predicts crop yields using linear regression. The project consists of a trained model, a FastAPI service, and a Flutter mobile application.

## Table of Contents
- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Project Structure](#project-structure)
- [Components](#components)
  - [Linear Regression Model](#linear-regression-model)
  - [API Service](#api-service)
  - [Flutter Application](#flutter-application)
- [Setup and Installation](#setup-and-installation)
  - [Linear Regression Model](#linear-regression-model)
  - [API Service](#api-service)
  - [Flutter Application](#flutter-application)
- [Usage](#usage)
  - Demo Video(#demo-video)
- [API Documentation](#api-documentation)

## Project Overview

This project aims to help farmers and agricultural professionals predict crop yields using machine learning. The system takes various parameters such as area, country, product, production, province, season name, and time to harvest to provide accurate yield predictions.

## Dataset

Sub-Saharan Africa faces severe agricultural data scarcity amidst high food insecurity and a large agricultural yield gap, making crop production data crucial for understanding and enhancing food systems. To address this gap, HarvestStat Africa presents the largest compilation of open-access subnational crop statistics and time-series across Sub-Saharan Africa. Based on agricultural statistics collated by USAID’s Famine Early Warning Systems Network, the subnational crop statistics are standardized and calibrated across changing administrative units to produce consistent and continuous time-series. The dataset includes 574,204 records, primarily spanning from 1980 to 2022, detailing quantity produced (metric tonnes; mt), harvested areas (hectares; ha), and yields (metric tonnes per hectare; mt/ha) for 33 countries and 94 crop types, including key cereals in Sub-Saharan Africa such as wheat, maize, rice, sorghum, barley, millet, and fonio. This new dataset enhances our understanding of how climate variability and change influence agricultural production, supports subnational food system analysis, and aids in operational yield forecasting. As an open-source resource, it establishes a precedent for sharing subnational crop statistics to inform decision-making and modeling efforts.

The model was trained on agricultural data containing the following features:
- Country
- Province
- Product
- Season Name
- Time to Harvest (days)
- Area (hectares)
- Production (tons)

## Project Structure

```
Linear-Regression-Model-Deployment-Using-Flutter/
├── api_endpoint/
│   ├── main.py
│   ├── requirements.txt
│   └── ml_model/
│       └── best_model.pkl
├── mobile_app/
│   └── crop_yield_predictor/
│       ├── lib/
│       │   ├── main.dart
│       │   ├── screens/
│       │   │   ├── home_screen.dart
│       │   │   └── landing_screen.dart
│       │   ├── providers/
│       │   │   └── prediction_provider.dart
│       │   └── services/
│       │       └── api_service.dart
│       └── pubspec.yaml
├── ml_model
|   └── crop_yield_prediction.ipynb
|   ├── best_model.pkl
|   ├── hvstat_africa_data.csv
└── README.me

```

## Components

### Linear Regression Model

The model is trained using scikit-learn's Linear Regression algorithm. It processes the input features to predict crop yields with the following specifications:
- Python version: 3.11
- Scikit-learn version: 1.2.2
- NumPy version: 1.23.5
- Pandas version: 1.5.3

### API Service

The FastAPI service provides a RESTful endpoint for making predictions. Key features:
- FastAPI framework
- CORS middleware enabled
- Input validation using Pydantic
- Error handling and logging
- Model loading and prediction pipeline

The link to the API service is `https://linear-regression-model-deployment-using-aak4.onrender.com`

### Flutter Application

A modern, user-friendly mobile application with the following features:
- Clean and intuitive UI
- Form validation
- Real-time prediction display
- Error handling
- Loading states
- Responsive design

## Setup and Installation

### Linear Regression Model

1. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
cd api_endpoint
pip install -r requirements.txt
```

### API Service

1. Navigate to the API directory:
```bash
cd api_endpoint
```

2. Start the FastAPI server:
```bash
uvicorn main:app --reload
```

The API will be available at `https://linear-regression-model-deployment-using-aak4.onrender.com`

### Flutter Application

1. Install Flutter SDK and set up your development environment
2. Navigate to the mobile app directory:
```bash
cd mobile_app/crop_yield_predictor
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the application:
```bash
flutter run
```
5. ![Image](https://github.com/user-attachments/assets/8e7475a3-069f-4e37-9504-5056bb33b318)

6. ![Image](https://github.com/user-attachments/assets/30ef0f8e-6eba-4975-8525-59090ad3e287)

## Usage

1. Launch the Flutter application
2. Fill in the required fields:
   - Area (hectares)
   - Country
   - Product
   - Production (tons)
   - Province
   - Season Name
   - Time to Harvest (days)
3. Click "Get Prediction" to receive the yield prediction
4. View the predicted yield in tons

   # Demo Video
   https://www.loom.com/share/2c973c828c1b44e49828599b9b549352?sid=98cafc51-9c5a-4215-ad63-60f815a18c3d

## API Documentation

### Endpoints

#### POST /predict

Predicts crop yield based on input parameters.

**Request Body:**
```json
{
    "area": float,
    "country": string,
    "product": string,
    "production": float,
    "province": string,
    "season_name": string,
    "time_to_harvest": float
}
```

**Response:**
```json
{
    "status": "success",
    "predicted_yield": float,
    "input_data": {
        "area": float,
        "country": string,
        "product": string,
        "production": float,
        "province": string,
        "season_name": string,
        "time_to_harvest": float
    }
}
```

**Error Response:**
```json
{
    "detail": "Error message"
}
```

### Example Usage

```python
import requests

url = "https://linear-regression-model-deployment-using-aak4.onrender.com/predict"
data = {
    "area": 100.0,
    "country": "Rwanda",
    "product": "Corn",
    "production": 500.0,
    "province": "Kigali",
    "season_name": "Main",
    "time_to_harvest": 120.0
}

response = requests.post(url, json=data)
print(response.json())
```
