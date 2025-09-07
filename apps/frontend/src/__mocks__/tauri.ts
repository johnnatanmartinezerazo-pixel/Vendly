// Simula API de Tauri en entorno de test
export const mockTauri = {
  invoke: vi.fn((command: string, args?: unknown) => {
    if (command === "get_app_version") {
      return Promise.resolve("1.0.0-mock");
    }
    if (command === "open_dialog") {
      return Promise.resolve("/mock/path/file.txt");
    }
    return Promise.reject(`Unknown command: ${command}`);
  }),
};
