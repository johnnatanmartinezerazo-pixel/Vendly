// Simula respuestas del backend Axum
export const mockAxum = {
  getUser: vi.fn().mockResolvedValue({
    id: "1",
    name: "John Doe",
    email: "john@example.com",
  }),

  listInventory: vi.fn().mockResolvedValue([
    { id: "101", name: "Laptop", stock: 10 },
    { id: "102", name: "Keyboard", stock: 25 },
  ]),
};
