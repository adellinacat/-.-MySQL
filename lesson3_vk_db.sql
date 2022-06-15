DROP TABLE IF EXISTS post_categories;
CREATE TABLE post_categories (
    post_category INT NOT NULL PRIMARY KEY,
    category VARCHAR (100)
    
);

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
    id SERIAL,
    post_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    title VARCHAR(100),
    content TEXT,
    status VARCHAR(100),
    date_published DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (post_id) REFERENCES users(id),
    FOREIGN KEY (title) REFERENCES post_categories(category)
);


DROP TABLE IF EXISTS post_comments;
CREATE TABLE post_comments (
    id SERIAL, 
    post_comment BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    commenter BIGINT UNSIGNED NOT NULL,
    comment TEXT,
    date_commented DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (post_comment) REFERENCES posts(post_id),
    FOREIGN KEY (commenter) REFERENCES users(id)
);
    
    