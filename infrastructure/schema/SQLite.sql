-- ==============================
-- Users Table Schema (SQLite)
-- ==============================

CREATE TABLE IF NOT EXISTS users (
    -- Identificación Principal
    user_id TEXT PRIMARY KEY NOT NULL DEFAULT (lower(hex(randomblob(16)))),
    external_id TEXT,

    -- Información Básica
    username TEXT UNIQUE,
    email TEXT NOT NULL UNIQUE,
    email_verified INTEGER NOT NULL DEFAULT 0 CHECK (email_verified IN (0,1)),
    phone TEXT,
    phone_verified INTEGER NOT NULL DEFAULT 0 CHECK (phone_verified IN (0,1)),

    -- Perfil Personal
    first_name TEXT,
    last_name TEXT,
    display_name TEXT,
    avatar_url TEXT,
    bio TEXT,
    birth_date DATE,
    gender TEXT,
    locale TEXT DEFAULT 'es-ES',
    timezone TEXT DEFAULT 'America/Bogota',

    -- Autenticación Tradicional
    password_hash TEXT,
    password_salt TEXT,
    password_updated_at TEXT,
    password_reset_token TEXT,
    password_reset_expires TEXT,
    failed_login_attempts INTEGER NOT NULL DEFAULT 0,
    account_locked_until TEXT,

    -- SSO y Proveedores Externos
    auth_provider TEXT,
    auth_provider_id TEXT,
    auth0_user_id TEXT,
    google_id TEXT,
    microsoft_id TEXT,
    facebook_id TEXT,
    linkedin_id TEXT,
    github_id TEXT,

    -- Tokens y Sesiones
    refresh_token TEXT,
    refresh_token_expires TEXT,
    access_token_version INTEGER NOT NULL DEFAULT 1,

    -- Autenticación Multifactor
    mfa_enabled INTEGER NOT NULL DEFAULT 0 CHECK (mfa_enabled IN (0,1)),
    mfa_secret TEXT,
    mfa_backup_codes TEXT, -- JSON array string
    mfa_recovery_codes_used INTEGER NOT NULL DEFAULT 0,

    -- Estados y Permisos
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','active','suspended','deleted')),
    role TEXT NOT NULL DEFAULT 'user',
    permissions TEXT, -- JSON array string
    subscription_tier TEXT DEFAULT 'free',

    -- Actividad y Seguimiento
    last_login_at TEXT,
    last_login_ip TEXT,
    last_login_user_agent TEXT,
    login_count INTEGER NOT NULL DEFAULT 0,
    last_activity_at TEXT,

    -- Metadata y GDPR
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now')),
    created_by TEXT,
    updated_by TEXT,
    deleted_at TEXT,
    gdpr_consent TEXT, -- JSON string
    data_retention_until TEXT
);

-- ==============================
-- Indexes
-- ==============================

-- Búsquedas frecuentes
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_external_id ON users(external_id);

-- SSO lookups
CREATE INDEX IF NOT EXISTS idx_users_auth_provider_id ON users(auth_provider_id);
CREATE INDEX IF NOT EXISTS idx_users_google_id ON users(google_id);
CREATE INDEX IF NOT EXISTS idx_users_github_id ON users(github_id);

-- Auditoría
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);
CREATE INDEX IF NOT EXISTS idx_users_deleted_at ON users(deleted_at);

-- ==============================
-- Trigger para mantener updated_at
-- ==============================

-- Eliminamos si ya existe para evitar duplicados
DROP TRIGGER IF EXISTS trg_users_updated_at;

-- Creamos el trigger
CREATE TRIGGER trg_users_updated_at
AFTER UPDATE ON users
FOR EACH ROW
WHEN NEW.updated_at = OLD.updated_at
BEGIN
    UPDATE users
    SET updated_at = datetime('now')
    WHERE user_id = OLD.user_id;
END;
-- ==============================
