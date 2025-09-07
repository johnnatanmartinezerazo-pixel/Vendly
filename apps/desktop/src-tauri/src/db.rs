use sea_orm::{Database, DatabaseConnection};
use crate::config::DatabaseConfig;
use anyhow::Result;

pub async fn init_db(cfg: &DatabaseConfig) -> Result<DatabaseConnection> {
    let conn = Database::connect(&cfg.url).await?;
    Ok(conn)
}
