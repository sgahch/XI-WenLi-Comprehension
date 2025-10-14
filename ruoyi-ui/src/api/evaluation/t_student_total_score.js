import request from '@/utils/request'

// 查询学生总成绩列表
export function listT_student_total_score(query) {
  return request({
    url: '/evaluation/t_student_total_score/list',
    method: 'get',
    params: query
  })
}

// 查询学生总成绩详细
export function getT_student_total_score(id) {
  return request({
    url: '/evaluation/t_student_total_score/' + id,
    method: 'get'
  })
}

// 新增学生总成绩
export function addT_student_total_score(data) {
  return request({
    url: '/evaluation/t_student_total_score',
    method: 'post',
    data: data
  })
}

// 修改学生总成绩
export function updateT_student_total_score(data) {
  return request({
    url: '/evaluation/t_student_total_score',
    method: 'put',
    data: data
  })
}

// 删除学生总成绩
export function delT_student_total_score(id) {
  return request({
    url: '/evaluation/t_student_total_score/' + id,
    method: 'delete'
  })
}
