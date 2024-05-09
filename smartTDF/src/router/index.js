import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/layouts/MainMenuLayout.vue'),
      children: [
        {
          path: '/',
          name: 'home',
          component: () => import('@/views/HomeView.vue')
        },
        {
          path: '/login',
          name: 'login',
          component: () => import('@/views/loginPage.vue')
        },
        {
          path: '/buy',
          name: 'Buy',
          component: () => import('@/components/BuyerAccepted.vue')
        },
        {
          path: '/sell',
          name: 'Sell',
          component: () => import('@/components/LandSaleInitiation.vue')
        },
        {
          path: '/survey',
          name: 'survey',
          component: () => import('@/components/LandRegistration.vue')
        },
        {
          path: '/details',
          name: 'details',
          component: () => import('@/components/GetLandDetails.vue')
        },
        {
          path: '/gov',
          name: 'gov',
          component: () => import('@/components/GovApproval.vue')
        }
      ]
    }
  ]
})

export default router
