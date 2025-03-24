import { StyleSheet, Text, View, Image, TouchableOpacity } from 'react-native';
import { Link } from 'expo-router';
import { Brain, Leaf, TrendingUp } from 'lucide-react-native';

export default function HomeScreen() {
  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Image
          source={{ uri: 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?q=80&w=2940&auto=format&fit=crop' }}
          style={styles.headerImage}
        />
        <View style={styles.headerOverlay}>
          <Text style={styles.title}>ML Yield Predictor</Text>
          <Text style={styles.subtitle}>
            Predict crop yields using advanced machine learning
          </Text>
        </View>
      </View>

      <View style={styles.main}>
        <View style={styles.features}>
          <View style={styles.feature}>
            <Brain size={32} color="#007AFF" />
            <Text style={styles.featureTitle}>Smart Predictions</Text>
            <Text style={styles.featureText}>
              Leverage machine learning to get accurate crop yield predictions
            </Text>
          </View>

          <View style={styles.feature}>
            <Leaf size={32} color="#10B981" />
            <Text style={styles.featureTitle}>Crop Insights</Text>
            <Text style={styles.featureText}>
              Make informed decisions about your agricultural practices
            </Text>
          </View>

          <View style={styles.feature}>
            <TrendingUp size={32} color="#6366F1" />
            <Text style={styles.featureTitle}>Yield Optimization</Text>
            <Text style={styles.featureText}>
              Optimize your crop yields based on data-driven predictions
            </Text>
          </View>
        </View>
        
        <Link href="/predict" asChild>
          <TouchableOpacity style={styles.button}>
            <Text style={styles.buttonText}>Make a Prediction</Text>
          </TouchableOpacity>
        </Link>

        <View style={styles.infoSection}>
          <Text style={styles.infoTitle}>How It Works</Text>
          <Text style={styles.infoText}>
            Our machine learning model analyzes various factors including location,
            season, crop type, and historical data to provide accurate yield
            predictions. This helps farmers make better decisions and optimize
            their agricultural practices.
          </Text>
        </View>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  header: {
    height: 400,
    position: 'relative',
  },
  headerImage: {
    width: '100%',
    height: '100%',
  },
  headerOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  main: {
    flex: 1,
    maxWidth: 960,
    marginHorizontal: 'auto',
    padding: 20,
    width: '100%',
  },
  title: {
    fontSize: 48,
    fontWeight: 'bold',
    color: '#fff',
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 24,
    color: '#fff',
    textAlign: 'center',
    marginTop: 16,
    maxWidth: 600,
  },
  features: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
    gap: 20,
    marginTop: -60,
    marginBottom: 40,
  },
  feature: {
    backgroundColor: '#fff',
    padding: 24,
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    alignItems: 'center',
    flex: 1,
    minWidth: 280,
    maxWidth: 320,
  },
  featureTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#1F2937',
    marginTop: 16,
    marginBottom: 8,
  },
  featureText: {
    fontSize: 16,
    color: '#6B7280',
    textAlign: 'center',
    lineHeight: 24,
  },
  button: {
    backgroundColor: '#007AFF',
    paddingVertical: 16,
    paddingHorizontal: 32,
    borderRadius: 8,
    alignItems: 'center',
    marginVertical: 20,
  },
  buttonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
  },
  infoSection: {
    marginTop: 40,
    padding: 24,
    backgroundColor: '#F9FAFB',
    borderRadius: 12,
  },
  infoTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#1F2937',
    marginBottom: 16,
  },
  infoText: {
    fontSize: 16,
    color: '#4B5563',
    lineHeight: 24,
  },
});