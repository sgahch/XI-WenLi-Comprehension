import request from '@/utils/request'

/**
 * 上传附件
 * @param {FormData} data - 包含file, detailId, attachmentType的FormData对象
 */
export function uploadAttachment(data) {
  return request({
    url: '/evaluation/attachment/upload',
    method: 'post',
    data: data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}

/**
 * 查询成绩截图
 * @param {Number} detailId - 详情ID
 */
export function getGradeScreenshots(detailId) {
  return request({
    url: `/evaluation/attachment/grade-screenshot/${detailId}`,
    method: 'get'
  })
}

/**
 * 查询证书材料
 * @param {Number} detailId - 详情ID
 */
export function getCertificates(detailId) {
  return request({
    url: `/evaluation/attachment/certificate/${detailId}`,
    method: 'get'
  })
}

/**
 * 根据详情ID查询所有附件
 * @param {Number} detailId - 详情ID
 */
export function getAttachmentsByDetailId(detailId) {
  return request({
    url: `/evaluation/attachment/detail/${detailId}`,
    method: 'get'
  })
}

/**
 * 根据提交ID查询所有附件
 * @param {Number} submissionId - 提交ID
 */
export function getAttachmentsBySubmissionId(submissionId) {
  return request({
    url: `/evaluation/attachment/submission/${submissionId}`,
    method: 'get'
  })
}

/**
 * 根据提交ID和附件类型查询附件
 * @param {Number} submissionId - 提交ID
 * @param {String} attachmentType - 附件类型：CERTIFICATE或GRADE_SCREENSHOT
 */
export function getAttachmentsBySubmissionIdAndType(submissionId, attachmentType) {
  return request({
    url: `/evaluation/attachment/submission/${submissionId}/type/${attachmentType}`,
    method: 'get'
  })
}

/**
 * 删除附件
 * @param {Array} detailIds - 详情ID数组
 */
export function deleteAttachments(detailIds) {
  return request({
    url: `/evaluation/attachment/${detailIds}`,
    method: 'delete'
  })
}

