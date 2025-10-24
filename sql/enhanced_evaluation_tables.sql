-- 增强综合测评系统数据库表结构
-- 创建时间: 2024-12-23
-- 说明: 支持德智体美劳五个维度的多学期综测数据管理

-- 1. 学期成绩明细表
DROP TABLE IF EXISTS t_semester_score_detail;
CREATE TABLE t_semester_score_detail (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    student_id VARCHAR(50) NOT NULL COMMENT '学号',
    student_name VARCHAR(100) NOT NULL COMMENT '姓名',
    academic_year VARCHAR(20) NOT NULL COMMENT '学年（如2023-2024）',
    semester TINYINT NOT NULL COMMENT '学期（1上学期，2下学期）',
    
    -- 智育维度
    intellectual_score DECIMAL(5,2) DEFAULT 0.00 COMMENT '智育成绩',
    intellectual_rank INT DEFAULT 0 COMMENT '智育排名',
    intellectual_details JSON COMMENT '智育详细项目得分（JSON格式）',
    
    -- 德育维度
    moral_score DECIMAL(5,2) DEFAULT 0.00 COMMENT '德育成绩',
    moral_rank INT DEFAULT 0 COMMENT '德育排名',
    moral_details JSON COMMENT '德育详细项目得分（JSON格式）',
    
    -- 体育维度
    physical_score DECIMAL(5,2) DEFAULT 0.00 COMMENT '体育成绩',
    physical_rank INT DEFAULT 0 COMMENT '体育排名',
    physical_details JSON COMMENT '体育详细项目得分（JSON格式）',
    
    -- 美育维度
    aesthetic_score DECIMAL(5,2) DEFAULT 0.00 COMMENT '美育成绩',
    aesthetic_rank INT DEFAULT 0 COMMENT '美育排名',
    aesthetic_details JSON COMMENT '美育详细项目得分（JSON格式）',
    
    -- 劳育维度
    labor_score DECIMAL(5,2) DEFAULT 0.00 COMMENT '劳育成绩',
    labor_rank INT DEFAULT 0 COMMENT '劳育排名',
    labor_details JSON COMMENT '劳育详细项目得分（JSON格式）',
    
    -- 综合成绩
    total_score DECIMAL(5,2) DEFAULT 0.00 COMMENT '综合成绩',
    class_rank INT DEFAULT 0 COMMENT '班级排名',
    major_rank INT DEFAULT 0 COMMENT '专业排名',
    
    -- 元数据
    class_id VARCHAR(50) COMMENT '班级ID',
    class_name VARCHAR(100) COMMENT '班级名称',
    major_id VARCHAR(50) COMMENT '专业ID',
    major_name VARCHAR(100) COMMENT '专业名称',
    
    -- 状态和审核
    status TINYINT DEFAULT 0 COMMENT '状态（0草稿，1已提交，2已审核，3已发布）',
    submit_time DATETIME COMMENT '提交时间',
    audit_time DATETIME COMMENT '审核时间',
    auditor_id VARCHAR(50) COMMENT '审核人ID',
    audit_remark VARCHAR(500) COMMENT '审核备注',
    
    -- 系统字段
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    
    -- 索引
    UNIQUE KEY uk_student_semester (student_id, academic_year, semester) COMMENT '学生学期唯一索引',
    INDEX idx_class_semester (class_id, academic_year, semester) COMMENT '班级学期索引',
    INDEX idx_major_semester (major_id, academic_year, semester) COMMENT '专业学期索引',
    INDEX idx_status (status) COMMENT '状态索引',
    INDEX idx_create_time (create_time) COMMENT '创建时间索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='学期成绩明细表';

-- 2. 成绩趋势分析表
DROP TABLE IF EXISTS t_score_trend_analysis;
CREATE TABLE t_score_trend_analysis (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    student_id VARCHAR(50) NOT NULL COMMENT '学号',
    student_name VARCHAR(100) NOT NULL COMMENT '姓名',
    analysis_type TINYINT NOT NULL COMMENT '分析类型（1智育趋势，2德育趋势，3体育趋势，4美育趋势，5劳育趋势，6综合趋势）',
    
    -- 趋势数据（JSON格式存储各学期数据）
    trend_data JSON COMMENT '趋势数据，格式：{"semesters":["2023-2024-1","2023-2024-2"],"scores":[85.5,87.2],"ranks":[15,12]}',
    
    -- 统计分析
    avg_score DECIMAL(5,2) COMMENT '平均成绩',
    max_score DECIMAL(5,2) COMMENT '最高成绩',
    min_score DECIMAL(5,2) COMMENT '最低成绩',
    trend_direction TINYINT COMMENT '趋势方向（1上升，0平稳，-1下降）',
    improvement_rate DECIMAL(5,2) COMMENT '提升幅度（百分比）',
    
    -- 元数据
    class_id VARCHAR(50) COMMENT '班级ID',
    major_id VARCHAR(50) COMMENT '专业ID',
    
    -- 系统字段
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    -- 索引
    UNIQUE KEY uk_student_type (student_id, analysis_type) COMMENT '学生分析类型唯一索引',
    INDEX idx_class_type (class_id, analysis_type) COMMENT '班级分析类型索引',
    INDEX idx_trend_direction (trend_direction) COMMENT '趋势方向索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='成绩趋势分析表';

-- 3. 综测评分项目配置表（增强版）
DROP TABLE IF EXISTS t_evaluation_item_config;
CREATE TABLE t_evaluation_item_config (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    dimension_type TINYINT NOT NULL COMMENT '维度类型（1智育，2德育，3体育，4美育，5劳育）',
    item_code VARCHAR(50) NOT NULL COMMENT '项目编码',
    item_name VARCHAR(100) NOT NULL COMMENT '项目名称',
    item_description VARCHAR(500) COMMENT '项目描述',
    
    -- 评分配置
    max_score DECIMAL(5,2) NOT NULL COMMENT '最高分值',
    min_score DECIMAL(5,2) DEFAULT 0.00 COMMENT '最低分值',
    default_score DECIMAL(5,2) DEFAULT 0.00 COMMENT '默认分值',
    score_type TINYINT DEFAULT 1 COMMENT '评分类型（1数值型，2等级型，3布尔型）',
    score_options JSON COMMENT '评分选项（等级型时使用）',
    
    -- 权重和排序
    weight DECIMAL(3,2) DEFAULT 1.00 COMMENT '权重系数',
    sort_order INT DEFAULT 0 COMMENT '排序序号',
    
    -- 状态控制
    is_required TINYINT DEFAULT 1 COMMENT '是否必填（0否，1是）',
    is_active TINYINT DEFAULT 1 COMMENT '是否启用（0否，1是）',
    
    -- 适用范围
    applicable_grades VARCHAR(200) COMMENT '适用年级（JSON数组）',
    applicable_majors VARCHAR(200) COMMENT '适用专业（JSON数组）',
    
    -- 系统字段
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
    
    -- 索引
    UNIQUE KEY uk_dimension_code (dimension_type, item_code) COMMENT '维度项目编码唯一索引',
    INDEX idx_dimension_active (dimension_type, is_active) COMMENT '维度启用状态索引',
    INDEX idx_sort_order (sort_order) COMMENT '排序索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='综测评分项目配置表';

-- 4. 班级综测统计表
DROP TABLE IF EXISTS t_class_score_statistics;
CREATE TABLE t_class_score_statistics (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    class_id VARCHAR(50) NOT NULL COMMENT '班级ID',
    class_name VARCHAR(100) NOT NULL COMMENT '班级名称',
    academic_year VARCHAR(20) NOT NULL COMMENT '学年',
    semester TINYINT NOT NULL COMMENT '学期',
    
    -- 统计数据
    total_students INT DEFAULT 0 COMMENT '总学生数',
    submitted_students INT DEFAULT 0 COMMENT '已提交学生数',
    audited_students INT DEFAULT 0 COMMENT '已审核学生数',
    
    -- 成绩统计
    avg_total_score DECIMAL(5,2) COMMENT '平均总成绩',
    max_total_score DECIMAL(5,2) COMMENT '最高总成绩',
    min_total_score DECIMAL(5,2) COMMENT '最低总成绩',
    
    -- 各维度平均分
    avg_intellectual_score DECIMAL(5,2) COMMENT '平均智育成绩',
    avg_moral_score DECIMAL(5,2) COMMENT '平均德育成绩',
    avg_physical_score DECIMAL(5,2) COMMENT '平均体育成绩',
    avg_aesthetic_score DECIMAL(5,2) COMMENT '平均美育成绩',
    avg_labor_score DECIMAL(5,2) COMMENT '平均劳育成绩',
    
    -- 统计时间
    statistics_time DATETIME COMMENT '统计时间',
    
    -- 系统字段
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    -- 索引
    UNIQUE KEY uk_class_semester (class_id, academic_year, semester) COMMENT '班级学期唯一索引',
    INDEX idx_statistics_time (statistics_time) COMMENT '统计时间索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='班级综测统计表';

-- 插入默认的评分项目配置数据
INSERT INTO t_evaluation_item_config (dimension_type, item_code, item_name, item_description, max_score, weight, sort_order, is_required) VALUES
-- 智育维度
(1, 'COURSE_SCORE', '课程成绩', '各科目课程成绩的加权平均', 100.00, 0.80, 1, 1),
(1, 'ACADEMIC_COMPETITION', '学科竞赛', '参加学科竞赛获得的加分', 20.00, 0.10, 2, 0),
(1, 'RESEARCH_PROJECT', '科研项目', '参与科研项目获得的加分', 15.00, 0.10, 3, 0),

-- 德育维度
(2, 'MORAL_CONDUCT', '思想品德', '日常思想品德表现评分', 100.00, 0.60, 1, 1),
(2, 'VOLUNTEER_SERVICE', '志愿服务', '参与志愿服务活动获得的加分', 20.00, 0.20, 2, 0),
(2, 'SOCIAL_ACTIVITY', '社会实践', '参与社会实践活动获得的加分', 20.00, 0.20, 3, 0),

-- 体育维度
(3, 'PHYSICAL_TEST', '体能测试', '国家学生体质健康标准测试成绩', 100.00, 0.70, 1, 1),
(3, 'SPORTS_COMPETITION', '体育竞赛', '参加体育竞赛获得的加分', 30.00, 0.20, 2, 0),
(3, 'SPORTS_ACTIVITY', '体育活动', '参与体育活动获得的加分', 10.00, 0.10, 3, 0),

-- 美育维度
(4, 'ART_COURSE', '艺术课程', '艺术类课程成绩', 100.00, 0.60, 1, 1),
(4, 'ART_COMPETITION', '艺术竞赛', '参加艺术竞赛获得的加分', 25.00, 0.25, 2, 0),
(4, 'CULTURAL_ACTIVITY', '文化活动', '参与文化艺术活动获得的加分', 15.00, 0.15, 3, 0),

-- 劳育维度
(5, 'LABOR_PRACTICE', '劳动实践', '劳动实践课程和活动评分', 100.00, 0.70, 1, 1),
(5, 'SKILL_TRAINING', '技能培训', '参与技能培训获得的加分', 20.00, 0.20, 2, 0),
(5, 'INNOVATION_PROJECT', '创新创业', '参与创新创业项目获得的加分', 10.00, 0.10, 3, 0);

-- 创建视图：学生综测成绩汇总视图
CREATE OR REPLACE VIEW v_student_score_summary AS
SELECT 
    ssd.student_id,
    ssd.student_name,
    ssd.class_id,
    ssd.class_name,
    ssd.major_id,
    ssd.major_name,
    ssd.academic_year,
    ssd.semester,
    ssd.intellectual_score,
    ssd.moral_score,
    ssd.physical_score,
    ssd.aesthetic_score,
    ssd.labor_score,
    ssd.total_score,
    ssd.class_rank,
    ssd.major_rank,
    ssd.status,
    ssd.submit_time,
    ssd.audit_time,
    -- 计算各维度在班级中的排名百分位
    ROUND((ssd.class_rank * 100.0 / css.total_students), 2) as class_rank_percentile,
    -- 是否为优秀学生（前20%）
    CASE WHEN ssd.class_rank <= (css.total_students * 0.2) THEN 1 ELSE 0 END as is_excellent
FROM t_semester_score_detail ssd
LEFT JOIN t_class_score_statistics css ON ssd.class_id = css.class_id 
    AND ssd.academic_year = css.academic_year 
    AND ssd.semester = css.semester;

COMMIT;