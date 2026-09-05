import { useState } from "react";
import { router } from "expo-router";
import {
  Pressable,
  SafeAreaView,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
} from "react-native";

const individuals = [
  {
    id: "K-001",
    name: "K-001",
    description: "Adult · Known individual",
  },
  {
    id: "K-002",
    name: "K-002",
    description: "Adult · Known individual",
  },
  {
    id: "K-003",
    name: "K-003",
    description: "Juvenile · Known individual",
  },
  {
    id: "K-004",
    name: "K-004",
    description: "Adult · Known individual",
  },
];

export default function HomeScreen() {
  const [query, setQuery] = useState("");

  const filteredIndividuals = individuals.filter(
    (individual) =>
      individual.id.toLowerCase().includes(query.toLowerCase()) ||
      individual.name.toLowerCase().includes(query.toLowerCase()),
  );

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.content}>
        <Text style={styles.eyebrow}>OrcaCatalog</Text>
        <Text style={styles.title}>個体を探す</Text>

        <TextInput
          style={styles.search}
          value={query}
          onChangeText={setQuery}
          placeholder="個体名・IDを検索"
        />

        <View style={styles.grid}>
          {filteredIndividuals.map((individual) => (
            <Pressable
              key={individual.id}
              style={styles.card}
              onPress={() => router.push(`/individuals/${individual.id}`)}
            >
              <View style={styles.photoPlaceholder}>
                <Text style={styles.photoText}>Photo</Text>
              </View>

              <View style={styles.cardBody}>
                <Text style={styles.cardTitle}>{individual.name}</Text>
                <Text style={styles.cardDescription}>
                  {individual.description}
                </Text>
              </View>
            </Pressable>
          ))}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#f7f7f5",
  },
  content: {
    padding: 24,
  },
  eyebrow: {
    marginBottom: 8,
    fontSize: 14,
    fontWeight: "600",
    color: "#666",
  },
  title: {
    marginBottom: 24,
    fontSize: 32,
    fontWeight: "700",
    color: "#222",
  },
  search: {
    marginBottom: 24,
    paddingHorizontal: 16,
    paddingVertical: 14,
    borderWidth: 1,
    borderColor: "#ddd",
    borderRadius: 10,
    backgroundColor: "#fff",
    fontSize: 16,
  },
  grid: {
    gap: 16,
  },
  card: {
    overflow: "hidden",
    borderWidth: 1,
    borderColor: "#e5e5e5",
    borderRadius: 12,
    backgroundColor: "#fff",
  },
  photoPlaceholder: {
    aspectRatio: 4 / 3,
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "#e8e8e6",
  },
  photoText: {
    color: "#888",
  },
  cardBody: {
    padding: 16,
  },
  cardTitle: {
    marginBottom: 6,
    fontSize: 18,
    fontWeight: "600",
  },
  cardDescription: {
    fontSize: 14,
    color: "#777",
  },
});