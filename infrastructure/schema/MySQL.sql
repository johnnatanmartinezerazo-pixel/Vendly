-- ==============================
-- Users Table Schema (Optimized MySQL/MariaDB)
-- ==============================

CREATE TABLE IF NOT EXISTS users (
    -- Identificación Principal
    user_id BINARY(16) NOT NULL PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID(), 1)),
    external_id VARCHAR(255) NULL,

    -- Información Básica
    username VARCHAR(50) UNIQUE,
    email VARCHAR(320) NOT NULL UNIQUE,
    email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    phone VARCHAR(20),
    phone_verified BOOLEAN NOT NULL DEFAULT FALSE,

    -- Perfil Personal
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    display_name VARCHAR(150),
    avatar_url TEXT,
    bio TEXT,
    birth_date DATE,
    gender VARCHAR(20),
    locale VARCHAR(10) DEFAULT 'es-ES',
    timezone VARCHAR(50) DEFAULT 'America/Bogota',

    -- Autenticación Tradicional
    password_hash VARCHAR(255),
    password_salt VARCHAR(255),
    password_updated_at DATETIME,
    password_reset_token VARCHAR(255),
    password_reset_expires DATETIME,
    failed_login_attempts INT NOT NULL DEFAULT 0,
    account_locked_until DATETIME,

    -- SSO y Proveedores Externos
    auth_provider VARCHAR(50),
    auth_provider_id VARCHAR(255),
    auth0_user_id VARCHAR(255),
    google_id VARCHAR(255),
    microsoft_id VARCHAR(255),
    facebook_id VARCHAR(255),
    linkedin_id VARCHAR(255),
    github_id VARCHAR(255),

    -- Tokens y Sesiones
    refresh_token TEXT,
    refresh_token_expires DATETIME,
    access_token_version INT NOT NULL DEFAULT 1,

    -- Autenticación Multifactor
    mfa_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    mfa_secret VARCHAR(255),
    mfa_backup_codes JSON, -- array de strings en formato JSON
    mfa_recovery_codes_used INT NOT NULL DEFAULT 0,

    -- Estados y Permisos
    status ENUM('pending','active','suspended','deleted') NOT NULL DEFAULT 'pending',
    role VARCHAR(50) NOT NULL DEFAULT 'user',
    permissions JSON, -- array de permisos en formato JSON
    subscription_tier VARCHAR(50) DEFAULT 'free',

    -- Actividad y Seguimiento
    last_login_at DATETIME,
    last_login_ip VARCHAR(45), -- soporta IPv4/IPv6
    last_login_user_agent TEXT,
    login_count INT NOT NULL DEFAULT 0,
    last_activity_at DATETIME,

    -- Metadata y GDPR
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by BINARY(16),
    updated_by BINARY(16),
    deleted_at DATETIME,
    gdpr_consent JSON,
    data_retention_until DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================
-- Indexes
-- ==============================

-- Búsquedas frecuentes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_external_id ON users(external_id);

-- SSO lookups
CREATE INDEX idx_users_auth_provider_id ON users(auth_provider_id);
CREATE INDEX idx_users_google_id ON users(google_id);
CREATE INDEX idx_users_github_id ON users(github_id);

-- Auditoría
CREATE INDEX idx_users_created_at ON users(created_at);
CREATE INDEX idx_users_deleted_at ON users(deleted_at);
-- ==============================
