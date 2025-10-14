import request from '@/utils/request'

// 查询学生成绩明细列表
export function listT_student_score_detail(query) {
  return request({
    url: '/evaluation/t_student_score_detail/list',
    method: 'get',
    params: query
  })
}

// 查询学生成绩明细详细
export function getT_student_score_detail(id) {
  return request({
    url: '/evaluation/t_student_score_detail/' + id,
    method: 'get'
  })
}

// 新增学生成绩明细
export function addT_student_score_detail(data) {
  return request({
    url: '/evaluation/t_student_score_detail',
    method: 'post',
    data: data
  })
}

// 修改学生成绩明细
export function updateT_student_score_detail(data) {
  return request({
    url: '/evaluation/t_student_score_detail',
    method: 'put',
    data: data
  })
}

// 删除学生成绩明细
export function delT_student_score_detail(id) {
  return request({
    url: '/evaluation/t_student_score_detail/' + id,
    method: 'delete'
  })
}
