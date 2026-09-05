import { Stack, useLocalSearchParams } from "expo-router";
import {
  SafeAreaView,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from "react-native";

export default function IndividualScreen() {
  const { id } = useLocalSearchParams<{ id: string }>();

  return (
    <>
      <Stack.Screen options={{ title: "個体詳細" }} />

      <SafeAreaView style={styles.container}>
        <ScrollView contentContainerStyle={styles.content}>
          <Text style={styles.backLink}>← 個体一覧に戻る</Text>

          <View style={styles.detailPhoto}>
            <Text style={styles.photoText}>Photo</Text>
          </View>

          <Text style={styles.eyebrow}>Individual</Text>
          <Text style={styles.title}>{id}</Text>

          <View style={styles.info}>
            <View style={styles.infoRow}>
              <Text style={styles.infoLabel}>識別番号</Text>
              <Text>{id}</Text>
            </View>

            <View style={styles.infoRow}>
              <Text style={styles.infoLabel}>性別</Text>
              <Text>Unknown</Text>
            </View>

            <View style={styles.infoRow}>
              <Text style={styles.infoLabel}>ステータス</Text>
              <Text>Known individual</Text>
            </View>
          </View>
        </ScrollView>
      </SafeAreaView>
    </>
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
  backLink: {
    marginBottom: 24,
    color: "#555",
  },
  detailPhoto: {
    aspectRatio: 4 / 3,
    marginBottom: 24,
    alignItems: "center",
    justifyContent: "center",
    borderRadius: 12,
    backgroundColor: "#e8e8e6",
  },
  photoText: {
    color: "#888",
  },
  eyebrow: {
    marginBottom: 8,
    fontSize: 14,
    fontWeight: "600",
    color: "#666",
  },
  title: {
    fontSize: 32,
    fontWeight: "700",
    color: "#222",
  },
  info: {
    marginTop: 32,
  },
  infoRow: {
    flexDirection: "row",
    paddingVertical: 14,
    borderBottomWidth: 1,
    borderBottomColor: "#e5e5e5",
  },
  infoLabel: {
    width: 100,
    color: "#777",
  },
});