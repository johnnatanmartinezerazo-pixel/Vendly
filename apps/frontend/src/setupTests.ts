import { afterEach, vi } from "vitest";
import { cleanup } from "@testing-library/react";

// Limpieza de React Testing Library entre tests
afterEach(() => {
  cleanup();
  vi.clearAllMocks();
});

// Mocks globales
import { mockAxum } from "./__mocks__/axum";
import { mockTauri } from "./__mocks__/tauri";

// Exponer los mocks globalmente
(global as any).mockAxum = mockAxum;
(global as any).mockTauri = mockTauri;
