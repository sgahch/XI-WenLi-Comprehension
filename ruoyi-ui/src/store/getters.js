const getters = {
  sidebar: state => state.app.sidebar,
  size: state => state.app.size,
  device: state => state.app.device,
  dict: state => state.dict.dict,
  visitedViews: state => state.tagsView.visitedViews,
  cachedViews: state => state.tagsView.cachedViews,
  token: state => state.user.token,
  avatar: state => state.user.avatar,
  id: state => state.user.id,
  userId: state => state.user.id, // 添加userId getter，映射到user.id
  name: state => state.user.name,
  nickName: state => state.user.nickName,
  deptId: state => state.user.deptId, // 添加deptId getter
  dept: state => state.user.dept, // 添加dept getter
  userInfo: state => ({ // 添加userInfo getter，包含用户基本信息
    id: state.user.id,
    name: state.user.name,
    nickName: state.user.nickName,
    avatar: state.user.avatar,
    roles: state.user.roles,
    permissions: state.user.permissions,
    deptId: state.user.deptId,
    dept: state.user.dept
  }),
  introduction: state => state.user.introduction,
  roles: state => state.user.roles,
  permissions: state => state.user.permissions,
  permission_routes: state => state.permission.routes,
  topbarRouters: state => state.permission.topbarRouters,
  defaultRoutes: state => state.permission.defaultRoutes,
  sidebarRouters: state => state.permission.sidebarRouters
}
export default getters
