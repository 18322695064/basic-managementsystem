import hasPermi from './hasPermi'
import hasRole from './hasRole'

export default {
  install(app) {
    app.directive('hasPermi', hasPermi)
    app.directive('hasRole', hasRole)
  }
}
