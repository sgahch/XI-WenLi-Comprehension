import request from '@/utils/request'

// =========================================================================
// == 学期成绩明细 CRUD (您的已有功能)
// =========================================================================

// 查询学期成绩明细列表
export function listSemesterScoreDetail(query) {
  return request({
    url: '/evaluation/semesterScore/list',
    method: 'get',
    params: query
  })
}

// 查询学期成绩明细详细
export function getSemesterScoreDetail(id) {
  return request({
    url: '/evaluation/semesterScore/' + id,
    method: 'get'
  })
}

// 新增学期成绩明细
export function addSemesterScoreDetail(data) {
  return request({
    url: '/evaluation/semesterScore',
    method: 'post',
    data: data
  })
}

// 修改学期成绩明细
export function updateSemesterScoreDetail(data) {
  return request({
    url: '/evaluation/semesterScore',
    method: 'put',
    data: data
  })
}

// 删除学期成绩明细
// 修改删除接口以支持批量删除（匹配后端的ids参数）
export function delSemesterScoreDetail(ids) {
  return request({
    url: '/evaluation/semesterScore/' + ids,
    method: 'delete'
  })
}

// 导出学期成绩明细
export function exportSemesterScoreDetail(query) {
  return request({
    url: '/evaluation/semesterScore/export',
    method: 'post', // 导出通常也用 POST 来携带复杂的查询条件
    data: query // 使用 data 而不是 params
  })
}


// =========================================================================
// == 成绩统计与分析 API (修正与补充)
// =========================================================================

/**
 * 【新增】查询学生个人成绩趋势
 * @param {object} params - { studentId, timeRange, dimension }
 */
export function getStudentScoreTrend(params) {
  return request({
    url: '/evaluation/statistics/trend',
    method: 'get',
    params: params
  })
}

/**
 * 【修正】获取班级成绩统计
 * @param {object} query - { classId, timeRange }
 */
export function getClassScoreStatistics(query) {
  return request({
    url: '/evaluation/semesterScore/classStatistics',
    method: 'get',
    params: query
  })
}

/**
 * 【修正】获取专业成绩统计
 * @param {object} query - { majorId, timeRange }
 */
export function getMajorScoreStatistics(query) {
  return request({
    url: '/evaluation/semesterScore/majorStatistics',
    method: 'get',
    params: query
  })
}


// =========================================================================
// == 其他成绩相关 API (您的已有功能)
// =========================================================================

// 根据班级查询成绩列表
export function getScoresByClass(query) {
  return request({
    url: '/evaluation/semesterScore/listByClass',
    method: 'get',
    params: query
  })
}

// 根据专业查询成绩列表
export function getScoresByMajor(query) {
  return request({
    url: '/evaluation/semesterScore/listByMajor',
    method: 'get',
    params: query
  })
}

// 根据学生ID查询成绩列表
export function getScoresByStudent(studentId, query) {
  return request({
    url: '/evaluation/semesterScore/student/' + studentId,
    method: 'get',
    params: query
  })
}

// 计算班级排名
export function calculateClassRanking(data) {
  return request({
    url: '/evaluation/semesterScore/calculateClassRanking',
    method: 'post',
    data: data
  })
}

// 计算专业排名
export function calculateMajorRanking(data) {
  return request({
    url: '/evaluation/semesterScore/calculateMajorRanking',
    method: 'post',
    data: data
  })
}

// 批量计算综合成绩
export function batchCalculateComprehensiveScore(data) {
  return request({
    url: '/evaluation/semesterScore/batchCalculate',
    method: 'post',
    data: data
  })
}

// 计算单个学生综合成绩
// 移除后端不存在的单个学生综合成绩计算接口
// export function calculateComprehensiveScore(data) {
//   return request({
//     url: '/evaluation/semesterScore/calculate',
//     method: 'post',
//     data: data
//   })
// }


// =========================================================================
// == Excel 导入相关 API (您的已有功能)
// =========================================================================

export function downloadImportTemplate() {
  return request({
    url: '/evaluation/semesterScore/importTemplate',
    method: 'post',
    responseType: 'blob'
  })
}

export function importSemesterScoreData(data) {
  return request({
    url: '/evaluation/semesterScore/import',
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}

export function importScoreData(data) {
  return request({
    url: '/evaluation/semesterScore/confirmImport',
    method: 'post',
    data: data
  })
}

export function validateImportData(data) {
  return request({
    url: '/evaluation/semesterScore/validateImport',
    method: 'post',
    data: data
  })
}


// =========================================================================
// == 综测评分项目配置 CRUD (您的已有功能, 与本文件主题关系不大, 但保留)
// =========================================================================

export function listEvaluationItemConfig(query) {
  return request({
    url: '/evaluation/itemConfig/list',
    method: 'get',
    params: query
  })
}

export function getEvaluationItemConfig(query) {
  return request({
    url: '/evaluation/itemConfig',
    method: 'get',
    params: query
  })
}

export function addEvaluationItemConfig(data) {
  return request({
    url: '/evaluation/itemConfig',
    method: 'post',
    data: data
  })
}

export function updateEvaluationItemConfig(data) {
  return request({
    url: '/evaluation/itemConfig',
    method: 'put',
    data: data
  })
}

export function delEvaluationItemConfig(id) {
  return request({
    url: '/evaluation/itemConfig/' + id,
    method: 'delete'
  })
}

export function batchDelEvaluationItemConfig(ids) {
  return request({
    url: '/evaluation/itemConfig/' + ids,
    method: 'delete'
  })
}

export function getConfigByDimension(dimensionType) {
  return request({
    url: '/evaluation/itemConfig/dimension/' + dimensionType,
    method: 'get'
  })
}

export function validateItemCode(itemCode, id) {
  return request({
    url: '/evaluation/itemConfig/validateCode',
    method: 'get',
    params: { itemCode, id }
  })
}

export function batchUpdateItemStatus(data) {
  return request({
    url: '/evaluation/itemConfig/batchStatus',
    method: 'put',
    data: data
  })
}

export function getNextSortOrder(dimensionType) {
  return request({
    url: '/evaluation/itemConfig/nextSort/' + dimensionType,
    method: 'get'
  })
}
