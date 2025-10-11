/* 2025-08-31 19:55:14 [8 ms] */ 
ALTER TABLE attendee_responses
ADD COLUMN audio_url TEXT;
/* 2025-08-31 19:55:32 [4 ms] */ 
SELECT * FROM attendee_responses LIMIT 100;
/* 2025-08-31 20:56:05 [3 ms] */ 
SELECT * FROM interview_questions LIMIT 100;
/* 2025-09-05 16:29:58 [6 ms] */ 
SELECT * FROM attendee_responses LIMIT 100;
/* 2025-09-05 16:56:19 [3 ms] */ 
SELECT * FROM interviews LIMIT 100;
/* 2025-09-05 17:32:51 [2 ms] */ 
SELECT * FROM attendee_responses LIMIT 100;
/* 2025-09-08 21:11:40 [3 ms] */ 
SELECT * FROM interviews LIMIT 100;
/* 2025-09-08 21:13:46 [3 ms] */ 
SELECT * FROM attendee_responses LIMIT 100;
/* 2025-09-08 22:57:40 [2 ms] */ 
SELECT * FROM interviews LIMIT 100;
/* 2025-09-09 17:34:25 [6 ms] */ 
SELECT * FROM interview_questions LIMIT 100;
/* 2025-09-19 12:59:28 [5 ms] */ 
SELECT * FROM interviews LIMIT 100;
/* 2025-09-19 14:45:54 [4 ms] */ 
SELECT * FROM attendee_responses LIMIT 100;
/* 2025-09-30 11:03:05 [4 ms] */ 
ALTER TABLE interviews
ADD COLUMN is_avatar_interview BOOLEAN NOT NULL DEFAULT FALSE;
/* 2025-09-30 11:06:30 [19 ms] */ 
DO $$
BEGIN
    -- Add selected_avatar_id column if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'interviews' 
        AND column_name = 'selected_avatar_id'
    ) THEN
        ALTER TABLE interviews ADD COLUMN selected_avatar_id UUID;
        RAISE NOTICE 'Added selected_avatar_id column to interviews table';
    ELSE
        RAISE NOTICE 'Column selected_avatar_id already exists in interviews table';
    END IF;

    -- Create index for performance
    IF NOT EXISTS (
        SELECT 1 FROM pg_indexes 
        WHERE tablename = 'interviews' 
        AND indexname = 'idx_interviews_selected_avatar_id'
    ) THEN
        CREATE INDEX idx_interviews_selected_avatar_id ON interviews(selected_avatar_id);
        RAISE NOTICE 'Created index on interviews.selected_avatar_id';
    END IF;
END $$;
/* 2025-10-05 14:44:58 [11 ms] */ 
-- Migration: Add JD-CV Matching table;
/* 2025-10-05 14:45:27 [20 ms] */ 
DO $$
BEGIN
    -- Add selected_avatar_id column if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'interviews' 
        AND column_name = 'selected_avatar_id'
    ) THEN
        ALTER TABLE interviews ADD COLUMN selected_avatar_id UUID;
        RAISE NOTICE 'Added selected_avatar_id column to interviews table';
    ELSE
        RAISE NOTICE 'Column selected_avatar_id already exists in interviews table';
    END IF;

    -- Create index for performance
    IF NOT EXISTS (
        SELECT 1 FROM pg_indexes 
        WHERE tablename = 'interviews' 
        AND indexname = 'idx_interviews_selected_avatar_id'
    ) THEN
        CREATE INDEX idx_interviews_selected_avatar_id ON interviews(selected_avatar_id);
        RAISE NOTICE 'Created index on interviews.selected_avatar_id';
    END IF;
END $$;
/* 2025-10-05 14:46:17 [14 ms] */ 
CREATE TABLE IF NOT EXISTS jd_cv_matching (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id VARCHAR(255) NOT NULL,
    company_name VARCHAR(255) DEFAULT '',
    department VARCHAR(255) DEFAULT '',
    designation VARCHAR(255) DEFAULT '',
    industry VARCHAR(255) DEFAULT '',
    role VARCHAR(255) DEFAULT '',
    level VARCHAR(255) DEFAULT '',
    job_description TEXT DEFAULT '',
    job_description_file VARCHAR(500) DEFAULT '',
    cultural_fit TEXT DEFAULT '',
    cultural_fit_file VARCHAR(500) DEFAULT '',
    include_additional_parameters BOOLEAN DEFAULT false,
    parameter_categories JSONB NOT NULL DEFAULT '[]'::jsonb,
    language VARCHAR(50) DEFAULT 'english',
    voice_id VARCHAR(255) DEFAULT '',
    duration VARCHAR(10) DEFAULT '30',
    status VARCHAR(50) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
/* 2025-10-06 21:03:59 [3 ms] */ 
SELECT * FROM interviews LIMIT 100;
