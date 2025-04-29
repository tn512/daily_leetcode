-- 3368. First Letter Capitalization

-- Main Solution
SELECT content_id, content_text AS original_text,
       INITCAP(content_text) AS converted_text
FROM user_content;

-- Alternative Solution
with content_sep_words as (
  select 
    user_content.content_id,
    user_content.content_text,
    lines.column_value as word_seq,
    trim(
      regexp_substr(
        content_text, '[^ ]+', 1, lines.column_value
      )
    ) as word
  from 
    user_content, 
    table(
      cast(
        multiset(
          select 
            level
          from 
            dual connect by (content_id = PRIOR content_id
            AND prior sys_guid() is not null
            and level <= regexp_count(content_text, ' ')+ 1)
        ) as sys.odciNumberList
      )
    ) lines
),
content_sep_words_capitalized as (
    select content_id,
    content_text,
    word_seq,
    word,
    upper(substr(WORD, 1, 1)) || lower(substr(WORD, 2, 1000)) as formatted_word
    from content_sep_words
)
select
content_id,
content_text as original_text,
LISTAGG(formatted_word, ' ') WITHIN GROUP (ORDER BY word_seq) as converted_text
from content_sep_words_capitalized
group by content_id, content_text
order by 1
