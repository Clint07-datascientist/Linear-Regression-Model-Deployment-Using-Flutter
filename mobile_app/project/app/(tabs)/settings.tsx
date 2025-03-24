import { StyleSheet, Text, View, TouchableOpacity, Linking, Platform } from 'react-native';
import { Github, Mail, BookOpen, Code } from 'lucide-react-native';

export default function SettingsScreen() {
  return (
    <View style={styles.container}>
      <View style={styles.main}>
        <Text style={styles.title}>Settings</Text>
        
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>About</Text>
          <Text style={styles.description}>
            This app uses a sophisticated machine learning model to predict crop yields
            based on various environmental and agricultural factors. The model has been
            trained on extensive historical data to provide accurate predictions for
            different crops across various regions.
          </Text>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Resources</Text>
          
          <TouchableOpacity
            style={styles.link}
            onPress={() => Linking.openURL('https://github.com/Clint07-datascientist/Linear-Regression-Model-Deployment-Using-Flutter')}
          >
            <Github size={24} color="#38434D" />
            <Text style={styles.linkText}>View Source Code</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.link}
            onPress={() => Linking.openURL('https://github.com/Clint07-datascientist/Linear-Regression-Model-Deployment-Using-Flutter/blob/main/README.md')}
          >
            <BookOpen size={24} color="#38434D" />
            <Text style={styles.linkText}>Documentation</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.link}
            onPress={() => Linking.openURL('https://github.com/Clint07-datascientist/Linear-Regression-Model-Deployment-Using-Flutter/issues')}
          >
            <Code size={24} color="#38434D" />
            <Text style={styles.linkText}>Report an Issue</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.link}
            onPress={() => Linking.openURL('mailto:support@example.com')}
          >
            <Mail size={24} color="#38434D" />
            <Text style={styles.linkText}>Contact Support</Text>
          </TouchableOpacity>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>App Information</Text>
          <View style={styles.infoRow}>
            <Text style={styles.infoLabel}>Version</Text>
            <Text style={styles.infoValue}>1.0.0</Text>
          </View>
          <View style={styles.infoRow}>
            <Text style={styles.infoLabel}>Model Version</Text>
            <Text style={styles.infoValue}>2.1.0</Text>
          </View>
          <View style={styles.infoRow}>
            <Text style={styles.infoLabel}>Last Updated</Text>
            <Text style={styles.infoValue}>March 2024</Text>
          </View>
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
  main: {
    flex: 1,
    maxWidth: Platform.select({ web: 960, default: '100%' }),
    marginHorizontal: 'auto',
    padding: 20,
    width: '100%',
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    marginBottom: 24,
    color: '#1F2937',
  },
  section: {
    marginBottom: 32,
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: '600',
    marginBottom: 16,
    color: '#1F2937',
  },
  description: {
    fontSize: 16,
    color: '#4B5563',
    lineHeight: 24,
  },
  link: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    gap: 12,
  },
  linkText: {
    fontSize: 16,
    color: '#38434D',
  },
  infoRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: 8,
    borderBottomWidth: 1,
    borderBottomColor: '#E5E7EB',
  },
  infoLabel: {
    fontSize: 16,
    color: '#6B7280',
  },
  infoValue: {
    fontSize: 16,
    color: '#1F2937',
    fontWeight: '500',
  },
});