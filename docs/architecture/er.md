```mermaid
erDiagram
    INDIVIDUALS ||--o{ OBSERVATIONS : "has"

    INDIVIDUALS {
        varchar id PK
        varchar name
        varchar description
        varchar photo_path
        datetime created_at
    }

    OBSERVATIONS {
        varchar id PK
        varchar individual_id FK
        float latitude
        float longitude
    }
```
