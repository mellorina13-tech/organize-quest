-- Migration: Add role and max_organizations to users table
-- This allows admins/moderators to create more organizations than regular users

-- Add role and max_organizations columns to users table
ALTER TABLE users
ADD COLUMN IF NOT EXISTS role VARCHAR(20) DEFAULT 'user',
ADD COLUMN IF NOT EXISTS max_organizations INTEGER DEFAULT 3;

-- Create index for faster role-based queries
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

-- Example: Set a specific user as admin with 50 organization limit
-- Uncomment and replace with actual email to use:
-- UPDATE users
-- SET role = 'admin',
--     max_organizations = 50
-- WHERE email = 'admin@example.com';

-- Example: Set a user as moderator with 20 organization limit
-- UPDATE users
-- SET role = 'mod',
--     max_organizations = 20
-- WHERE email = 'moderator@example.com';

-- Role types:
-- 'user'  - Regular user (default: 3 organizations)
-- 'mod'   - Moderator (customizable limit)
-- 'admin' - Administrator (customizable limit, e.g., 50)
